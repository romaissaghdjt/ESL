//
//  ESLBuyViewController.m
//  ESL
//
//  Created by eyou on 16/9/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLBuyViewController.h"
#import "BuyHeaderCell.h"
#import "BuyBodyCell.h"
#import "ESLFoodInfoViewController.h"
#import "ESLBuyNetManager.h"
#import "ESLBuyModel.h"
#import "HomeNetManager.h"
#import "NSDate+Calendar.h"

@interface ESLBuyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
//抢购产品数组
@property (nonatomic, strong)NSMutableArray *productArray;
@property (nonatomic, assign)NSInteger totalTime;
@property (nonatomic, assign)BOOL isLoad;

@end

@implementation ESLBuyViewController
-(NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatTimer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self destroyTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view showBusyHUD];
    
    self.isLoad = NO;
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeBackground:) name:@"BuyBackground" object:nil];
    
    [center addObserver:self selector:@selector(noticeForeground:) name:@"BuyForeground" object:nil];

    [center addObserver:self selector:@selector(noticeStopBuy:) name:@"StopBuy" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"秒抢购";
    self.tabBarController.tabBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [ESLBuyNetManager getGetRobberyProductsWithCompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            for (NSDictionary *dict in array) {
                ESLBuyModel *model = [[ESLBuyModel alloc]init];
                [model setValueWithDictionary:dict];
                [self.productArray addObject:model];
            }
            [self.view hideBusyHUD];
            [self.tableView reloadData];
        }
    }];
}

-(void)noticeStopBuy:(NSNotificationCenter *)center
{
    self.totalTime = 0;
}

-(void)noticeBackground:(NSNotificationCenter *)center
{
    [self destroyTimer];
}

-(void)noticeForeground:(NSNotificationCenter *)center
{
    [self creatTimer];
}

-(void)creatTimer
{
    [HomeNetManager getRobbeyTimeWithCompletionHandler:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            NSString *endTime = [dict[@"EndTime"] substringToIndex:19];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *endDate = [NSDate local:[formatter dateFromString:endTime]];
            NSDate *nowDate = [NSDate local:[NSDate date]];
            
            self.totalTime = [endDate timeIntervalSinceDate:nowDate];
            self.isLoad = YES;
            [self.tableView reloadData];
        }
    }];
}

-(void)destroyTimer
{
    BuyHeaderCell *cell = [self.view viewWithTag:100];
    [cell.timer invalidate];
    cell.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BuyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyHeaderCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"BuyHeaderCell" owner:nil options:nil].firstObject;
            cell.tag = 100;
        }
        if (self.isLoad == YES) {
            [cell settTimeValue:self.totalTime];
            self.isLoad = NO;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        BuyBodyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyBodyCell"];
        
        if (!cell) {
            
            cell = [[NSBundle mainBundle]loadNibNamed:@"BuyBodyCell" owner:nil options:nil].firstObject;
        }
        [cell setValueWithModel:self.productArray[indexPath.row - 1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }
    return 128;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    if (self.totalTime <= 0) {
        [self.view showWarning:@"本次抢购已结束"];
        return;
    }
    ESLFoodInfoViewController *fivc = [[ESLFoodInfoViewController alloc]init];
    fivc.type = SNAP;
    fivc.isFromRob = YES;
    fivc.buyModel = self.productArray[indexPath.row - 1];
    [self.navigationController pushViewController:fivc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"BuyBackground" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"BuyForeground" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"StopBuy" object:nil];
}


@end
