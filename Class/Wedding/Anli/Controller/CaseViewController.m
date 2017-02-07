//
//  CaseViewController.m
//  YY
//
//  Created by eyou on 16/5/6.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CaseViewController.h"
#import "InstanceCell.h"
#import "InstanceLeftCell.h"
#import "CaseModle.h"
#import "HeardView.h"
#import "LoginViewController.h"
#define SCREEN_SCALE ([[UIScreen mainScreen] bounds].size.width/375)
#define SCREEN_DCALE ([[UIScreen mainScreen] bounds].size.height/667)
@interface CaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *rightTableView;
@property (strong, nonatomic)UITableView *leftTableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray*array;
@property (nonatomic) BOOL isRelate;
@property (nonatomic, strong)CaseModle *CMoedle;
@property (nonatomic)BOOL isFirst;
@property (nonatomic, strong)HeardView *heardView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation CaseViewController
-(NSMutableArray *)array
{
    if (!_array) {
        _array= [NSMutableArray array];
    }
    return _array;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置状态栏样式没有如果您的应用程序使用默认UIViewController-based状态栏系统
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实例";
    self.isFirst = YES;
   
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;

    self.isRelate = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self request];
    [self cretaerightTableView];
    [self crataerleftTableView];
    
    [self.rightTableView reloadData];
    [self createRightBtn];
}
//返回首页和订单的下拉框
- (void)createRightBtn{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setImage:[UIImage imageNamed:@"50x40_02"] forState:UIControlStateNormal];
//    if (SH<=568) {
//        btn.frame = CGRectMake(245, 10, 40, 30);
//    }else if (SH>568){
//        btn.frame = CGRectMake(320, 10, 40, 30);
//    }
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
//    btn.tintColor = [UIColor grayColor];
//
//    [btn addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.bb = btn;
}
-(void)clickA
{
//    _Menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    //    messageC.view.userInteractionEnabled = YES;
//    messageC.deleagte = self;
//    _Menu.contentController = messageC;
//    [_Menu showFrom:self.bb];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_Menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        
//    }else if (indexPath.row==1){
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
//        // @property (strong, nonatomic)UIButton *btn;
//        // @property (strong, nonatomic)XHIndetController *XHindetC;
//        _XHindetC = [[XHIndetController alloc]init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:_XHindetC];
//        
//        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_btn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [_btn setTintColor:ZXColor(83, 162, 38, 1)];
//        _btn.frame = CGRectMake(0, 0, 20, 20);
//        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
//        _XHindetC.navigationItem.leftBarButtonItem = leftItem;
//        
//        [self presentViewController:navigation animated:NO completion:nil];
//        
//    }
}
//- (void)click
//{
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)request
{
//     [self.view showBusyHUD];
    [zJRequestManager requestWithUrl:[PREURL stringByAppendingString: @"Other.ashx?Function=HttpQueryCase"] parmDic:nil method:GET1 succeedWithData:^(NSData *data) {



        NSArray *key = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];

        
        if ([key isKindOfClass:[NSNull class]]) {
            return ;
        }else
        {
            for (NSDictionary *dic in key) {
                CaseModle *CMoedle = [[CaseModle alloc]init];
                CMoedle.ImageUrl = dic[@"ImageUrl"];
                CMoedle.LevelID = dic[@"LevelID"];
                CMoedle.Name = dic[@"Name"];
                CMoedle.Price = dic[@"Price"];
                CMoedle.Remark = dic[@"Remark"];
                CMoedle.SampleID = dic[@"SampleID"];
                self.CMoedle = CMoedle;
                [self.dataArray addObject:self.CMoedle];
                
                NSLog(@"%@ %@",dic,self.dataArray);
            }
            
                _CMoedle = _dataArray.firstObject;
                [self.array addObjectsFromArray:_CMoedle.ImageUrl];
            self.heardView.RemarkLable.text = _CMoedle.Remark;
//            self.heardView.PriceLable.text = [NSString stringWithFormat:@"总价为%@元",_CMoedle.Price];
            [self.leftTableView reloadData];
            [self.rightTableView reloadData];
            if (self.isFirst) {
                NSInteger topCellSection = [[[self.leftTableView indexPathsForVisibleRows]firstObject]section];
                if (self.dataArray.count != 0) {
                    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                }
                
            }
        }
//        [self.view hideBusyHUD];
     } failedWithError:^(NSError *connectionError) {
        
 }];
}
- (void)cretaerightTableView
{
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(140*SWIDTH_SCALE, 0, KWIDTH-140*SWIDTH_SCALE, KHEIGHT-65) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 120*SHEIGHT_DCALE;
//    _rightTableView.scrollEnabled = NO;
    _rightTableView.separatorStyle = NO;
    _heardView = [[HeardView alloc]initWithFrame:CGRectMake(0, 0, self.rightTableView.width, 30)];
    self.CMoedle = _dataArray.firstObject;
    //去掉多余的分割线
    [_rightTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.rightTableView.tableHeaderView = _heardView;
    [self.view addSubview:_rightTableView];
}

-(void)crataerleftTableView
{
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 140*SWIDTH_SCALE, KHEIGHT) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
//    _leftTableView.backgroundColor = [UIColor lightGrayColor];
    _leftTableView.rowHeight = 60*SHEIGHT_DCALE;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //去掉多余的分割线
    [_leftTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:_leftTableView];
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////    if ([tableView isEqual:_rightTableView]) {
////        return _dataArray.count;
////    }else{
//        return _dataArray.count;
////    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_leftTableView]) {
        return _dataArray.count;
    }else{
        return _array.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_rightTableView]) {
        static NSString *ID = @"mycell";
        InstanceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"InstanceCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            //去掉多余的分割线
            [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
            
        }
            [cell.img sd_setImageWithURL:[NSURL URLWithString:_array[indexPath.row]] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    
        return cell;
    }else{
        /**
         以下方法
         在创建cell时候选择第几个cell被选中
         *
         */
//        //********************************************
       
        //*******************************************
        static NSString *DD = @"mecell";
        InstanceLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:DD];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"InstanceLeftCell" owner:nil options:nil].firstObject;
           
            //改变cell被点击时候的颜色*************************
            cell.backgroundColor = ZXColor(240, 240, 240,1);
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectedBackgroundView;
            //****************************************
            // 左侧示意条
            UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 6, 60)];
            liner.backgroundColor = [UIColor orangeColor];
            [selectedBackgroundView addSubview:liner];
        }
        CaseModle *model = self.dataArray[indexPath.row];

        cell.Title.text = model.Name;
    
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_rightTableView]) {
        return 130;
    }else{
        return 60;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
  
        [self.array removeAllObjects];
        self.array  = [NSMutableArray array];
        _CMoedle = _dataArray [indexPath.row];
        _heardView.RemarkLable.text = _CMoedle.Remark;
//        _heardView.PriceLable.text = self.heardView.PriceLable.text = [NSString stringWithFormat:@"总价为%@元",_CMoedle.Price];
        [self.array addObjectsFromArray:_CMoedle.ImageUrl];
        [self.rightTableView reloadData];
  
    }

}
#pragma mark == cell 将要显示的时候就会调用此方法  使cell分割线右边的缺失部分补齐 ==
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
