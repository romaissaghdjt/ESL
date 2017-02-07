//
//  ESLHomeViewController.m
//  ESL
//
//  Created by eyou on 16/9/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLHomeViewController.h"
#import "HomeNetManager.h"
#import "HomeButtonDelegate.h"
#import "ESLWeddingViewController.h"
#import "ESLPrivateViewController.h"
#import "ESLBuyViewController.h"
#import "ESLNewAddViewController.h"
#import "ESLFruitViewController.h"
#import "ESLHotViewController.h"
#import "NSDate+Calendar.h"
#import "ESLFoodInfoViewController.h"
#import "ESLHotViewController.h"
#import "ESLFeastDetailViewController.h"
#import "FeastDtiallController.h"
#import "ESLDefaultView.h"
#import "ESLCategoryFoodCell.h"
#import "ESLHomeCategoryDelegate.h"
#import "ESLSearchViewController.h"
#import "ESLFoodInfoViewController.h"
#import "UIScrollView+Refresh.h"
#import "UIButton+WebCache.h"
#import "ESLTitleCell.h"
#import "ESLThreeCell.h"
#import "BanerView.h"
#import "ESLHelpViewController.h"
#import "ESLBagListViewController.h"
#import "ESLSingleArrayModel.h"
#import "ESLTopHeaderViewController.h"
#import "ESLCookerInfoViewController.h"

#define kHeight_SrcollVew 120* SCREEN_DCALE//轮播图高度

@interface ESLHomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeButtonDelegate, ESLHomeCategoryDelegate, BanerViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSArray *promoteArr;
@property (nonatomic, assign)NSInteger totalTime;
@property (nonatomic, assign)BOOL isLoad;
@property (nonatomic, strong)NSString *describeStr;
@property (nonatomic, strong)NSArray *singleArray;
@property (nonatomic, strong)NSArray *threeArray;
@property (nonatomic, strong)NSArray *topArray;
@property (nonatomic, strong)BanerView *bb;
@property (nonatomic, strong)NSMutableArray *topImageArray;
@end

@implementation ESLHomeViewController

-(NSMutableArray *)topImageArray
{
    if (!_topImageArray) {
        _topImageArray = [NSMutableArray array];
    }
    return _topImageArray;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WK(weakSelf)
    
    self.navigationItem.title = @"甬尚鲜";
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(noticeBackground:) name:@"HomeBackground" object:nil];
    
    [center addObserver:self selector:@selector(noticeForeground:)name:@"HomeForeground" object:nil];
    
    self.isLoad = NO;
    
    //监听什么网络
    AFNetworkReachabilityManager *megr = [AFNetworkReachabilityManager sharedManager];
    [megr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //         NSLog(@"----- %ld",(long)status);
        if (status == 0)
        {
            //获取沙盒路径，
            NSString *path_sandox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
            //创建一个存储plist文件的路径
            NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/pic.plist"];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:newPath];
            [self.bb creatWithArray:arr];
            [UIViewController showMessage:@"你没有开启网络" ViewController:self];
        }else if (status >= 1)
        {
            
        }
    }];
    
    //开始监听
    [megr startMonitoring];
    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ZXColor(255, 255, 255, 1);
    //导航条前面部分
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (SW == 320) {
        addressBtn.frame =CGRectMake( 5, 0, 50*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
        [addressBtn setImageEdgeInsets:(UIEdgeInsetsMake(3*SCREEN_SCALE,35*SCREEN_SCALE,0,0))];
        [addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-35*SCREEN_SCALE,0,5*SCREEN_SCALE)];
    }else if (SW==375){
        addressBtn.frame =CGRectMake( 5, 0, 45*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
        
        [addressBtn setImageEdgeInsets:(UIEdgeInsetsMake(1*SCREEN_SCALE,30*SCREEN_SCALE,0,0))];
        [addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-30*SCREEN_SCALE,0,5*SCREEN_SCALE)];
    }else if (SW>375){
        addressBtn.frame =CGRectMake( 5, 0, 45*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
        
        [addressBtn setImageEdgeInsets:(UIEdgeInsetsMake(3*SCREEN_SCALE,30*SCREEN_SCALE,0,0))];
        [addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-30*SCREEN_SCALE,0,5*SCREEN_SCALE)];
    }
    [addressBtn setTitle:@"宁波" forState: UIControlStateNormal];
    [addressBtn setImage:[UIImage imageNamed:@"未标题-2"] forState:UIControlStateNormal];
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    addressBtn.userInteractionEnabled = NO;
    UIBarButtonItem *address = [[UIBarButtonItem alloc]initWithCustomView:addressBtn];
    self.navigationItem.leftBarButtonItem = address;
    //导航条中间部分
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 160*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    titleImage.image = [UIImage imageNamed:@"logo"];
    titleImage.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = titleImage;
    
    //导航条后面部分
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20*SWIDTH_SCALE, 20*SHEIGHT_DCALE)];
    [searchBtn setImage:[UIImage imageNamed:@"20x20"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"20x20"] forState:UIControlStateSelected];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = search;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self creatHeaderView];
    [self creatCategoryView];
    
    [self.tableView addHeaderRefresh:^{
        [weakSelf destroyTimer];
        [weakSelf creatTimer];
        [weakSelf creatCategoryView];
        [weakSelf.tableView endHeaderRefresh];
    }];
}
//搜索内容
-(void)searchBtnClick{
    ESLSearchViewController *search = [[ESLSearchViewController alloc]init];
    search.isYY = YES;
    [self.navigationController pushViewController:search animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    [self creatTimer];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self destroyTimer];
}

-(void)noticeBackground:(NSNotificationCenter *)center
{
    [self destroyTimer];
}

-(void)noticeForeground:(NSNotificationCenter *)center
{
    [self creatTimer];
}

-(void)destroyTimer
{
    ESLThreeCell *cell = [self.view viewWithTag:100];
    [cell.timer invalidate];
    cell.timer = nil;
}

//抢购时间
-(void)creatTimer
{
    [HomeNetManager getRobbeyTimeWithCompletionHandler:^(NSDictionary *dict, NSError *error) {
        if (error) {
            //            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
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
//滚动图片
- (void)creatHeaderView
{
    self.bb = [[BanerView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, kHeight_SrcollVew)];
    self.bb.delegate = self;
    self.bb.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.bb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//分类图片
-(void)creatCategoryView
{
    [HomeNetManager getHomeCategoryPictureWithCompletionHandler:^(NSArray *singleArray, NSArray *threeArray, NSArray *topArray, NSString *describeStr, NSError *error) {
        if (error) {
            [self.view showWarning:@"服务器繁忙"];
        }
        else
        {
            [self.topImageArray removeAllObjects];
            for (ESLSingleArrayModel *model in topArray) {
                [self.topImageArray addObject:model.ImageUrl];
            }
            self.singleArray = singleArray;
            self.threeArray = threeArray;
            self.topArray = topArray;
            self.describeStr = describeStr;
            
        }
        //获取沙盒路径，
        NSString *path_sandox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //创建一个存储plist文件的路径
        NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/pic.plist"];
        if (self.topImageArray) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //写入plist文件
                [self.topImageArray writeToFile:newPath atomically:YES];
            });
            [self.bb creatWithArray:self.topImageArray];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if (self.singleArray.count != 0) {
        count++;
    }
    return 2 + count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.singleArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ESLTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLTitleCell"];
        if (cell == nil) {
            cell = [[ESLTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ESLTitleCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell creatTitleCell];
            cell.delegate = self;
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        ESLThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLThreeCell"];
        if (cell == nil) {
            cell = [[ESLThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ESLThreeCell"];
            cell.tag = 100;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell initContent];
        }
        [cell creatThreeImage:self.threeArray WithStr:self.describeStr];
        if (self.isLoad == YES) {
            [cell setBaseTime:self.totalTime];
            self.isLoad = NO;
        }////////////////////////
        return cell;
    }
    else
    {
        ESLSingleArrayModel *singleArrayModel = self.singleArray[indexPath.row];
        ESLCategoryFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryFoodCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLCategoryFoodCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:singleArrayModel.ImageUrl] placeholderImage:nil];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"海鲜",@"className", nil];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"ClassName" object:nil userInfo:dict];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            self.tabBarController.selectedIndex=1;
        }
        else if (indexPath.row == 1) {
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"蔬菜",@"className", nil];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"ClassName" object:nil userInfo:dict];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            self.tabBarController.selectedIndex=1;
        }
        else
        {
            ESLSingleArrayModel *singleArrayModel = self.singleArray[indexPath.row];
            ESLBagListViewController *blvc = [[ESLBagListViewController alloc]init];
            blvc.imgUrl = singleArrayModel.ImageUrl;
            [self.navigationController pushViewController:blvc animated:YES];
        }
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (KWIDTH - 25) * 0.25;
    }
    else if (indexPath.section == 1){
        return KWIDTH/5*3.0;
    }
    return 136;
}

-(void)clickButtonWithType:(NSString *)type
{
    //乡村喜宴
    if ([type isEqualToString:@"wedding"]) {
        ESLWeddingViewController *wvc = [[ESLWeddingViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];
    }
    //私人订制
    else if ([type isEqualToString:@"private"]) {
        ESLHotViewController *pvc = [[ESLHotViewController alloc]init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    //你情我元
    else if ([type isEqualToString:@"help"]) {
        ESLHelpViewController *pvc = [[ESLHelpViewController alloc]init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    //抢购
    else if ([type isEqualToString:@"fastBuy"]) {
        ESLBuyViewController *bvc = [[ESLBuyViewController alloc]init];
        [self.navigationController pushViewController:bvc animated:YES];
    }
    //厨师
    else if ([type isEqualToString:@"cookers"]) {
        ESLCookerInfoViewController *cvc = [[ESLCookerInfoViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
    }
    //水果
    else if ([type isEqualToString:@"fruit"]) {
        ESLFruitViewController *fvc = [[ESLFruitViewController alloc]init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    //最新上架
    else if ([type isEqualToString:@"newFood"]) {
        self.tabBarController.selectedIndex=1;
    }
    //人气套餐
    else if ([type isEqualToString:@"hotFood"]) {
        ESLHotViewController *hvc = [[ESLHotViewController alloc]init];
        [self.navigationController pushViewController:hvc animated:YES];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeBackground" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeForeground" object:nil];
}

-(void)topImageClick:(NSInteger)index
{
    ESLTopHeaderViewController *tvc = [[ESLTopHeaderViewController alloc]init];
    ESLSingleArrayModel *model = self.topArray[index];
    tvc.urlStr = model.Url;
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
