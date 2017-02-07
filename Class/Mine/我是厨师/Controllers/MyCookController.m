//
//  MyCookController.m
//  ESL
//
//  Created by 徐恒 on 16/9/27.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyCookController.h"
#import "OrderCell.h"
#import "InfoOrderViewController.h"
#import "ESLMyNetworkingManager.h"
#import "TCPChannel.h"
#import "CLMapNavigationView.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationChange.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface MyCookController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, TCPChannelDelegate, BMKGeoCodeSearchDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *waitOrdButton;
@property (nonatomic, strong)UIButton *completeButton;
@property (nonatomic, strong)UIButton *waitCompleteButton;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *orangeLabel;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)UITableView *centerTableView;
@property (nonatomic, strong)UITableView *rightTableView;
@property (nonatomic, strong)NSMutableArray *leftArray;
@property (nonatomic, strong)NSMutableArray *centerArray;
@property (nonatomic, strong)NSMutableArray *rightArray;
@property (nonatomic, assign)NSInteger tagInt;
@property (nonatomic, strong)TCPChannel *channel;
@property (nonatomic, assign)TABTYPE type;
//签到还是抢单
@property (nonatomic, copy)NSString *message;

@property (nonatomic, strong)BMKGeoCodeSearch* geocodesearch;
@property (nonatomic, strong)NSString *addressStr;

@end

@implementation MyCookController

#pragma mark -懒加载

-(NSMutableArray *)leftArray
{
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

-(NSMutableArray *)centerArray
{
    if (!_centerArray) {
        _centerArray = [NSMutableArray array];
    }
    return _centerArray;
}

-(NSMutableArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _geocodesearch.delegate = nil; // 不用时，置nil
}


- (void)dealloc {
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    self.channel.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    self.navigationItem.title = @"配送单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    //导航条的颜色  ZXColor(100, 172, 56, 1)   ZXColor(61, 171, 48, 1)
  
    self.channel = [TCPChannel getTcpChannel];
    self.channel.delegate = self;
    [self creatHeaderView];
    [self creatScrollView];
    self.type = LEFT;
    [ESLMyNetworkingManager getCookOrderWithCompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.leftArray = array.mutableCopy;
            NSString *waitString = [NSString stringWithFormat:@"待抢单(%ld)", self.leftArray.count];
            [self.waitOrdButton setTitle:waitString forState:UIControlStateNormal];
            [self.leftTableView reloadData];
        }
    }];
    
    [ESLMyNetworkingManager getCookerToDoOrderWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.centerArray = array.mutableCopy;
            NSString *waitString = [NSString stringWithFormat:@"待执行(%ld)", self.centerArray.count];
            [self.waitCompleteButton setTitle:waitString forState:UIControlStateNormal];
            [self.centerTableView reloadData];
        }
    }];
    [ESLMyNetworkingManager getCookerCompleteWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.rightArray = array.mutableCopy;
            NSString *waitString = [NSString stringWithFormat:@"已完成(%ld)", self.rightArray.count];
            [self.completeButton setTitle:waitString forState:UIControlStateNormal];
            [self.rightTableView reloadData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerView.y + _headerView.height , KWIDTH, KHEIGHT - _headerView.height - _orangeLabel.height - 64)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, KHEIGHT - _headerView.height - _orangeLabel.height - 64);
    [self.view addSubview:_scrollView];
    
    self.leftTableView = [self creatTableViewWith:CGRectMake(0, 0, KWIDTH, KHEIGHT - _headerView.height - _orangeLabel.height - 64)];
    
    self.centerTableView = [self creatTableViewWith:CGRectMake(KWIDTH, 0, KWIDTH, KHEIGHT - _headerView.height - _orangeLabel.height - 64)];
    
    self.rightTableView = [self creatTableViewWith:CGRectMake(2*KWIDTH, 0, KWIDTH, KHEIGHT - _headerView.height - _orangeLabel.height - 64)];
}

-(UITableView *)creatTableViewWith:(CGRect)rect
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [_scrollView addSubview:tableView];
    return tableView;
}

-(void)creatHeaderView
{
    //警告框
    _orangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 20)];
    _orangeLabel.text = @"小伙伴 未缴纳保证金前,还不能抢单哟!";
    _orangeLabel.backgroundColor = ZXColor(231, 149, 65, 1);
    _orangeLabel.textColor = [UIColor whiteColor];
    _orangeLabel.textAlignment = NSTextAlignmentCenter;
    _orangeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_orangeLabel];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, _orangeLabel.height + 64, KWIDTH, 50)];
    [self.view addSubview:_headerView];
    
    self.waitOrdButton = [self creatHeaderButton:CGRectMake(0, 0, KWIDTH / 3.0, 50) WithTitle:@"待抢单(0)"];
    [self.waitOrdButton addTarget:self action:@selector(waitOrdClick:) forControlEvents:UIControlEventTouchUpInside];
    self.waitOrdButton.selected = YES;
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, 60, 3)];
    self.lineView.centerX = self.waitOrdButton.centerX;
    self.lineView.backgroundColor = ZXColor(87, 169, 0, 1);
    [_headerView addSubview:self.lineView];
    
    self.waitCompleteButton = [self creatHeaderButton:CGRectMake(KWIDTH / 3.0, 0, KWIDTH / 3.0, 50) WithTitle:@"待执行(0)"];
    [self.waitCompleteButton addTarget:self action:@selector(waitCompleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.completeButton = [self creatHeaderButton:CGRectMake(2 *KWIDTH / 3.0, 0, KWIDTH / 3.0, 50) WithTitle:@"已完成(0)"];
    [self.completeButton addTarget:self action:@selector(completeClick:) forControlEvents:UIControlEventTouchUpInside];

}

//待抢单点击事件
-(void)waitOrdClick:(UIButton *)sender
{
    self.tagInt = 0;
    self.waitOrdButton.selected = YES;
    self.waitCompleteButton.selected = NO;
    self.completeButton.selected = NO;
    self.type = LEFT;
    self.lineView.centerX = self.waitOrdButton.centerX;
    [self.leftTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    if (sender) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}
//待执行点击事件
-(void)waitCompleteClick:(UIButton *)sender
{
    self.tagInt = 1;
    self.waitOrdButton.selected = NO;
    self.waitCompleteButton.selected = YES;
    self.completeButton.selected = NO;
    self.type = CENTER;
    self.lineView.centerX = self.waitCompleteButton.centerX;
    [self.centerTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    if (sender) {
        [self.scrollView setContentOffset:CGPointMake(KWIDTH, 0) animated:NO];
    }
    
}
//已完成点击事件
-(void)completeClick:(UIButton *)sender
{
    self.tagInt = 2;
    self.waitOrdButton.selected = NO;
    self.waitCompleteButton.selected = NO;
    self.completeButton.selected = YES;
    self.lineView.centerX = self.completeButton.centerX;
    self.type = RIGHT;
    [self.rightTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    if (sender) {
        [self.scrollView setContentOffset:CGPointMake(2*KWIDTH, 0) animated:NO];
    }
}

-(UIButton *)creatHeaderButton:(CGRect)rect WithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:ZXColor(87, 169, 0, 1) forState:UIControlStateSelected];
    [_headerView addSubview:button];
    return button;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.leftTableView]) {
        return self.leftArray.count;
    }
    else if ([tableView isEqual:self.centerTableView]) {
        return self.centerArray.count;
        
    }
    else{
        return self.rightArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil].firstObject;
        if ([tableView isEqual:_leftTableView]) {
            cell.GPSBtn.hidden = NO;
            cell.getItButton.hidden = NO;
            [cell.getItButton setTitle:@"立即抢单" forState:UIControlStateNormal];
            [cell.getItButton addTarget:self action:@selector(getOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.GPSBtn addTarget:self action:@selector(GPSButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([tableView isEqual:_centerTableView]) {
            cell.getItButton.hidden = NO;
            cell.GPSBtn.hidden = NO;
            [cell.getItButton setTitle:@"签到执行" forState:UIControlStateNormal];
            [cell.getItButton addTarget:self action:@selector(checkInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.GPSBtn addTarget:self action:@selector(GPSButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.GPSBtn.hidden = YES;
            cell.getItButton.hidden = YES;
        }
        [cell.infoButton addTarget:self action:@selector(infoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    //待抢单
    if ([tableView isEqual:_leftTableView]) {
        CookOrderModel *cookOrderModel = self.leftArray[indexPath.section];
        cell.getItButton.enabled = YES;
        cell.GPSBtn.tag = indexPath.section;
        cell.getItButton.tag = indexPath.section;
        cell.orderNum.text = cookOrderModel.orderID;
        cell.priceLabel.text = [NSString stringWithFormat:@"%.02f", cookOrderModel.wages.floatValue];
        cell.bookDateLabel.text = cookOrderModel.createTime;
        cell.serviceDateLabel.text = [NSString stringWithFormat:@"%@ %@",[cookOrderModel.serverTime substringToIndex:10], cookOrderModel.dinnerTime];
        cell.servicePlace.text = cookOrderModel.serverAddr;
        cell.serviceNum.text = [NSString stringWithFormat:@"%@桌", cookOrderModel.serverNum];
        cell.orderStateLabel.text = cookOrderModel.orderState;
        cell.orderStateLabel.hidden = NO;
        cell.orderState.hidden = NO;
        cell.orderPriceConstraint.constant = 40.0;
    }
    //待执行
    else if ([tableView isEqual:_centerTableView]) {
        CookOrderModel *cookOrderModel = self.centerArray[indexPath.section];
        if ([cookOrderModel.state isEqualToString:@"0"]) {
             [cell.getItButton setTitle:@"签到执行" forState:UIControlStateNormal];
            cell.getItButton.backgroundColor = ZXColor(87, 169, 0, 1);
            cell.getItButton.enabled = YES;
        }
        else if ([cookOrderModel.state isEqualToString:@"1"]) {
            [cell.getItButton setTitle:@"签到成功" forState:UIControlStateNormal];
            [cell.getItButton setBackgroundColor:[UIColor grayColor]];
            cell.getItButton.enabled = NO;
        }
        cell.GPSBtn.tag = indexPath.section;
        cell.getItButton.tag = indexPath.section;
        cell.orderNum.text = cookOrderModel.orderID;
        cell.priceLabel.text = [NSString stringWithFormat:@"%.02f", cookOrderModel.wages.floatValue];
        cell.bookDateLabel.text = cookOrderModel.createTime;
        cell.serviceDateLabel.text = [NSString stringWithFormat:@"%@ %@",[cookOrderModel.serverTime substringToIndex:10], cookOrderModel.dinnerTime];
        cell.servicePlace.text = cookOrderModel.serverAddr;
        cell.serviceNum.text = [NSString stringWithFormat:@"%@桌", cookOrderModel.serverNum];
        cell.orderStateLabel.hidden = YES;
        cell.orderState.hidden = YES;
        cell.orderPriceConstraint.constant = 10.0;
    }
    //已完成
    else if ([tableView isEqual:_rightTableView]) {
        CookOrderModel *cookOrderModel = self.rightArray[indexPath.section];
        cell.orderNum.text = cookOrderModel.orderID;
        cell.priceLabel.text = [NSString stringWithFormat:@"%.02f", cookOrderModel.wages.floatValue];
        cell.bookDateLabel.text = cookOrderModel.createTime;
        
        cell.serviceDateLabel.text = [NSString stringWithFormat:@"%@ %@",[cookOrderModel.serverTime substringToIndex:10], cookOrderModel.dinnerTime];
        cell.servicePlace.text = cookOrderModel.serverAddr;
        cell.serviceNum.text = [NSString stringWithFormat:@"%@桌", cookOrderModel.serverNum];
        cell.orderStateLabel.hidden = YES;
        cell.orderState.hidden = YES;
        cell.orderPriceConstraint.constant = 10.0;
    }
    
    cell.infoButton.tag = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTableView]) {
        return 250;
    }
    else
    {
        return 220;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger tag = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
//    if (tag == 0) {
//        [self waitOrdClick:nil];
//    }
//    else if (tag == 1)
//    {
//        [self waitCompleteClick:nil];
//    }
//    else
//    {
//        [self completeClick:nil];
//    }
//    NSInteger tag = self.tagInt;
//    self.tagInt = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
//    if (self.tagInt == 0 && tag != self.tagInt) {
//        [self waitOrdClick:nil];
//    }
//    else if (self.tagInt == 1 && tag != self.tagInt)
//    {
//        [self waitCompleteClick:nil];
//    }
//    else if (self.tagInt == 2 && tag != self.tagInt)
//    {
//        [self completeClick:nil];
//    }
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tag = self.tagInt;
    self.tagInt = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (self.tagInt == 0 && tag != self.tagInt) {
        [self waitOrdClick:nil];
    }
    else if (self.tagInt == 1 && tag != self.tagInt)
    {
        [self waitCompleteClick:nil];
    }
    else if (self.tagInt == 2 && tag != self.tagInt)
    {
        [self completeClick:nil];
    }
}
//查看详情
-(void)infoButtonClick:(UIButton *)sender
{
    InfoOrderViewController *iovc = [[InfoOrderViewController alloc]init];
    CookOrderModel *model = nil;
    switch (self.type) {
        case LEFT:
            model = self.leftArray[sender.tag];
            break;
        case CENTER:
            model = self.centerArray[sender.tag];
            break;
        default:
            model = self.rightArray[sender.tag];
            break;
    }
    iovc.cookOrderModel = model;
    [self.navigationController pushViewController:iovc animated:YES];
}
//弹出框
-(void)postMessage:(UIButton *)sender Message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        if ([message isEqualToString:@"是否签到"]) {
            [self checkInButtonConfirm:sender];
        }
        else
        {
            [self PanicBuyingButtonConfirm:sender];
        }
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    
}

//立即抢购
-(void)getOrderButtonClick:(UIButton *)sender
{
    self.message = @"是否抢单";
    [self postMessage:sender Message:self.message];
}

-(void)PanicBuyingButtonConfirm:(UIButton *)sender
{
    CookOrderModel *cookOrderModel = self.leftArray[sender.tag];
    NSString *string = [NSString stringWithFormat:@"HEAD=000000\r\nBODY={\"Module\":\"CookRob\",\"Method\":\"SubmitCook\",\"CookRequireID\":\"%@\",\"CookTel\":\"%@\"}",cookOrderModel.ID,us];
    
    [self.channel.asyncSocket writeData:[[NSString stringWithFormat:@"HEAD=%06lu\r\nBODY={\"Module\":\"CookRob\",\"Method\":\"SubmitCook\",\"CookRequireID\":\"%@\",\"CookTel\":\"%@\"}",string.length - 5,cookOrderModel.ID,us] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}

//导航
-(void)GPSButtonClick:(UIButton *)sender
{
    CookOrderModel *model = nil;
    switch (self.type) {
        case LEFT:
            model = self.leftArray[sender.tag];
            break;
        case CENTER:
            model = self.centerArray[sender.tag];
            break;
        default:
            model = self.rightArray[sender.tag];
            break;
    }
    self.addressStr = model.serverAddr;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.address = model.serverAddr;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

//签到
-(void)checkInButtonClick:(UIButton *)sender
{
    self.message = @"是否签到";
    [self postMessage:sender Message:self.message];
}

//确认签到
-(void)checkInButtonConfirm:(UIButton *)sender
{
    CookOrderModel *cookOrderModel = self.centerArray[sender.tag];
    [ESLMyNetworkingManager getCookerCheckInWithUserTel:us UserPhyAdd:KUUID ProID:cookOrderModel.ID CompletionHandler:^(NSString *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            if ([result isEqualToString:@"开始成功"]) {
                cookOrderModel.state = @"1";
            }
            else
            {
                [UIViewController showMessage:result ViewController:self];
            }
            [self.centerTableView reloadData];
            
        }
    }];
}


-(void)getOrderWithNSDictionary:(NSDictionary *)dict Type:(ORDTYPE)type
{
    if (type == WAITORDER) {
        CookOrderModel *model = [[CookOrderModel alloc]init];
        model.ID = dict[@"ID"];
        model.orderID = dict[@"OrderID"];
        model.wages = dict[@"Wages"];
        model.createTime = dict[@"CreateTime"];
        model.serverTime = dict[@"ServerTime"];
        model.serverAddr = dict[@"ServerAddr"];
        model.serverNum = dict[@"TableNumber"];
        [self.leftArray addObject:model];
        NSString *waitString = [NSString stringWithFormat:@"待抢单(%ld)", self.leftArray.count];
        [self.waitOrdButton setTitle:waitString forState:UIControlStateNormal];
        [self.leftTableView reloadData];
    }
    else if (type == WAITCOMPLETE)
    {
        if ([dict[@"Result"] isEqualToString:@"成功"]) {
            NSArray *array = self.leftArray.mutableCopy;
            for (CookOrderModel *model in array) {
                if ([model.ID isEqualToString:dict[@"CookRequireID"]]) {
                    [self.centerArray addObject:model];
                    [self.leftArray removeObject:model];
                }
            }
            NSString *waitString1 = [NSString stringWithFormat:@"待抢单(%ld)", self.leftArray.count];
            [self.waitOrdButton setTitle:waitString1 forState:UIControlStateNormal];
            NSString *waitString2 = [NSString stringWithFormat:@"待执行(%ld)", self.centerArray.count];
            [self.waitCompleteButton setTitle:waitString2 forState:UIControlStateNormal];
            [self.leftTableView reloadData];
            [self.centerTableView reloadData];
        }
        [UIViewController showMessage:dict[@"Result"] ViewController:self];
    }
    else if (type == ISBOOKED)
    {
        NSArray *array = self.leftArray.mutableCopy;
        for (CookOrderModel *model in array) {
            if ([model.ID isEqualToString:dict[@"ID"]]) {
                [self.leftArray removeObject:model];
            }
        }
        NSString *waitString1 = [NSString stringWithFormat:@"待抢单(%ld)", self.leftArray.count];
        [self.waitOrdButton setTitle:waitString1 forState:UIControlStateNormal];
        [self.leftTableView reloadData];
    }
}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    CLMapNavigationView *vc = [[CLMapNavigationView alloc] init];
    [vc showMapNavigationViewWithtargetLatitude:result.location.latitude targetLongitute:result.location.longitude toName:self.addressStr];
    [self.view addSubview:vc];
    
}


@end
