//
//  ESLWeddingViewController.m
//  ESL
//
//  Created by eyou on 16/9/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLWeddingViewController.h"
#import "StarFeastController.h"
#import "WeddingController.h"
#import "CaseViewController.h"
#import "CLXiShiTangNetanager.h"
#import "CarController.h"
#import "ToJoinChooseController.h"
//#import "StarChoiceController.h"
#import "TablewareController.h"
#import "CLChooseViewController.h"
#import "XHXiShiTangController.h"
#import "XHCollectionCell.h"
#import "XHIconCell.h"
#import "XHDistributionCell.h"
#import "XHTouTiaoCell.h"
#import "WishView.h"
#import "ESLBanerView.h"
#import "ESLHeadlineDetailsController.h"
#define kHeight_SrcollVew 170* SCREEN_DCALE//轮播图高度
//根据当前屏幕宽度得到适配宽度(5和5s的屏幕适配)
#define pixw(p)  ((myWidth1/320.0)*p)
//根据当前屏幕宽度得到适配宽度(6和6s的屏幕适配)
#define pixwn(p)  ((myWidth1/375.0)*p)
//屏幕宽度



#define SH self.view.frame.size.height
@interface ESLWeddingViewController ()<UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
@property (nonatomic, strong)NSArray *wishArray;
@property (nonatomic, copy)NSString *wishString;
@property (nonatomic, strong)WishView *wishView;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UIView *changeView;
@property (nonatomic, copy)NSString *telNum;

@property (nonatomic,strong)NSArray*ImageArray;
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic, strong)ESLBanerView *bb;
@property (nonatomic, assign)BOOL isClick;
@end

@implementation ESLWeddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self getWishWordDate];
    self.title = @"乡村喜宴";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_SrcollVew, KWIDTH, KHEIGHT - kHeight_SrcollVew+49) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    //self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 5;
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.hidden = NO;
    //监听什么网络
    AFNetworkReachabilityManager *megr = [AFNetworkReachabilityManager sharedManager];
    [megr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //         NSLog(@"----- %ld",(long)status);
        if (status == 0)
        {
            [UIViewController showMessage:@"你没有开启没有网络" ViewController:self];
        }else if (status >= 1)
        {
            
        }
    }];
    
    //开始监听
    [megr startMonitoring];
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    
//        self.tableView.scrollEnabled = NO;
//    self.navigationItem.hidesBackButton = YES;
    
    self.hidesBottomBarWhenPushed=NO;
    
//    [self.tableView addHeaderRefresh:^{
//        [weakSelf.timer invalidate];
//        [weakSelf getWishWordDate];
//        [weakSelf.tableView endHeaderRefresh];
//    }];
//        [self.tableView beginHeaderRefresh];
    
    
    [self creat];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    /**
     *  显示tabbar
     */
    self.tabBarController.tabBar.hidden = YES;
    self.isClick = NO;
    /**
     *  显示导航栏
     */
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)getWishWordDate
{
    WK(weakSelf)
    [CLXiShiTangNetanager getCompleteOrderCount:^(id array, NSError *error) {
        NSDictionary *dict = array;
        weakSelf.wishString = [NSString stringWithFormat:@"%@", dict[@"TotalAndFinish"]];
                    NSMutableArray *Array = [NSMutableArray array];
                    Array = dict[@"NearOrderData"];
                    weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:2  target:weakSelf selector:@selector(changeContentOffset:) userInfo:nil repeats:YES];
                    weakSelf.wishArray = Array;
                    self.wishView = [[WishView alloc]initWithFrame:CGRectMake(60, 5, self.view.bounds.size.width - 60, 50) WishArray:Array WishString:weakSelf.wishString];
                    [self.tableView reloadData];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
            }];
    
}

-(void)changeContentOffset:(NSTimer *)timer
{
    [self.wishView.scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
}

#pragma mark - Table view data source
- (void)creat
{
     UIView*bb = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, kHeight_SrcollVew)];
    bb.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bb];
    NSString*url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryWiddingMainPageTopPictrue"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        
        NSArray*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        DCPicScrollView  *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,0,KWIDTH, kHeight_SrcollVew) WithImageUrls:dic];
        
        picView1.backgroundColor = [UIColor clearColor];
        [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("你点到我了😳index:%zd\n",index);
        }];
        picView1.AutoScrollDelay = 2.0f;
        
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        
        //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
        //error错误信息
        //url下载失败的imageurl                                                                                                                                                                                                                                                                                                                                                                                             
       
                [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
                    NSLog(@"%@",error);
                }];
        
        [bb addSubview:picView1];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 120;
    }else if (indexPath.section == 3)
    {
        return 120;
    }
    else if (indexPath.section == 0)
    {
        return (KWIDTH-120)/5 + 60;
    }
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        static NSString *str = @"CoCell";
        XHCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[XHCollectionCell alloc]init];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        [cell.XiYanBtn addTarget:self action:@selector(XiYanBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ChuJuBtn addTarget:self action:@selector(ChuJuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.XiShiTangBtn addTarget:self action:@selector(XiShiTangBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.HunQingBtn addTarget:self action:@selector(HunQingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.AnLieBtn addTarget:self action:@selector(AnLieBtn:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *ID = @"TCell";
        XHTouTiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[XHTouTiaoCell alloc]init];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            imageView.image = [UIImage imageNamed:@"喜宴头条"];
            [cell addSubview:imageView];
        }
        [cell addSubview:self.wishView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *ID = @"iconCell";
        XHIconCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"XHIconCell" owner:nil options:nil].lastObject;
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell.topBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.bottomBtn addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    static NSString *ss = @"DCell";
    XHDistributionCell *cell = [tableView dequeueReusableCellWithIdentifier:ss];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"XHDistributionCell" owner:nil options:nil].lastObject;
    }
    [cell.hunqBt  addTarget:self action:@selector(hunqbnt) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.huncheBnt  addTarget:self action:@selector(che) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.YSxBnt  addTarget:self action:@selector(ysx) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
//拨打客服电话
- (void)click{
    [self bookBtnClickWithTitle:@"友情提示" Message:@"宁波统一客服电话" Tel:@"400-8261-707"];
}

-(void)bookBtnClickWithTitle:(NSString *)title Message:(NSString *)message Tel:(NSString *)tel
{
    self.telNum = tel;
    if (!self.hiddenView) {
        self.hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        self.hiddenView.backgroundColor = [UIColor blackColor];
        self.hiddenView.alpha = 0.5;
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        
        [currentWindow addSubview:self.hiddenView];
        
        self.changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
        self.changeView.center = self.hiddenView.center;
        [currentWindow addSubview:self.changeView];
        
        self.changeView.backgroundColor = [UIColor whiteColor];
        UILabel *presentationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        presentationLabel.backgroundColor = [UIColor lightGrayColor];
        presentationLabel.textAlignment = NSTextAlignmentCenter;
        presentationLabel.text = title;
        presentationLabel.tag = 50;
        presentationLabel.textColor = [UIColor darkGrayColor];
        presentationLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.changeView addSubview:presentationLabel];
        
        UILabel *callLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 300, 30)];
        callLabel.font = [UIFont boldSystemFontOfSize:18];
        callLabel.text = message;
        callLabel.tag = 51;
        callLabel.textAlignment = NSTextAlignmentCenter;
        [self.changeView addSubview:callLabel];
        
        UIButton *numBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 300, 30)];
        [numBtn setTitle:tel forState:UIControlStateNormal];
        numBtn.tag = 52;
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [numBtn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        numBtn.enabled = NO;
        [self.changeView addSubview:numBtn];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 150, 100, 40)];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitle:@"拨打" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:ZXColor(83, 162, 38, 1)];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(callTel:) forControlEvents:UIControlEventTouchUpInside];
        [self.changeView addSubview:sureBtn];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 150, 100, 40)];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:ZXColor(83, 162, 38, 1)];
        [cancelBtn addTarget:self action:@selector(callCancel:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.layer.masksToBounds = YES;
        [self.changeView addSubview:cancelBtn];
        
        self.changeView.layer.cornerRadius = 20;
        self.changeView.layer.masksToBounds = YES;
    }
    else
    {
        ((UILabel *)[self.changeView viewWithTag:50]).text = title;
        ((UILabel *)[self.changeView viewWithTag:51]).text = message;
        [((UIButton *)[self.changeView viewWithTag:52]) setTitle:tel forState:UIControlStateNormal];
        self.changeView.hidden = NO;
        self.hiddenView.hidden = NO;
    }
}

-(void)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.telNum]]];
}
-(void)callCancel:(UIButton *)sender
{
    self.changeView.hidden = YES;
    self.hiddenView.hidden = YES;
}

- (void)click1{
    [self bookBtnClickWithTitle:@"友情提示" Message:@"宁波统一客服电话" Tel:@"13957470390"];
}

#pragma mark --- button 的点击事件
- (void)YuDingBtn:(UIButton *)sender
{

    
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)XiYanBtn:(UIButton *)sender
{
    StarFeastController *xiyan = [[StarFeastController alloc]init];
    [self.navigationController pushViewController:xiyan animated:YES];
}
- (void)ChuJuBtn:(UIButton *)sender
{
    TablewareController *canju = [[TablewareController alloc]init];
    [self.navigationController pushViewController:canju animated:YES];
    
}

- (void)XiShiTangBtn:(UIButton *)sender
{
    XHXiShiTangController *xiyan = [[XHXiShiTangController alloc]init];
    xiyan.isFromOther = NO;
    [self.navigationController pushViewController:xiyan animated:YES];
    
}
- (void)HunQingBtn:(UIButton *)sender
{
    WeddingController *xishitang = [[WeddingController alloc]init];
    [self.navigationController pushViewController:xishitang animated:YES];
    
}
- (void)AnLieBtn:(UIButton *)sender
{
    CaseViewController *anlie = [[CaseViewController alloc]init];
    [self.navigationController pushViewController:anlie animated:YES];
    
}
- (void)HuDongBtn:(UIButton *)sender
{
    // 判断是否登录过
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];

        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    
    CLChooseViewController *cvc = [[CLChooseViewController alloc]initWithNibName:@"CLChooseViewController" bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
}
- (void)HunCheBtn:(UIButton *)sender
{
    CarController *marriageCC = [[CarController alloc]init];
    [self.navigationController pushViewController:marriageCC animated:YES];
}
//- (void)JiaMengBtn:(UIButton *)sender
//{
//    ToJoinChooseController *tojoinC = [[ToJoinChooseController alloc]init];
//    [self.navigationController pushViewController:tojoinC animated:YES];
//    
//}
#pragma mark - Table view delegate
- (void)showMessageAboutWrong:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        XHIndetController *XHindetC = [[XHIndetController alloc]init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:XHindetC];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [btn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [btn setTintColor:ZXColor(83, 162, 38, 1)];
//        btn.frame = CGRectMake(0, 0, 20, 20);
//        btn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        XHindetC.navigationItem.leftBarButtonItem = leftItem;
//        
//        [self presentViewController:navigation animated:YES completion:nil];
    }];
    
    [alert addAction:cancelAction];
}
- (void)message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancenlA = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:nil];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
        [self presentViewController:navVC animated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [alert addAction:cancenlA];
}
- (void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//判断是否有未支付的订单
-(void)judgeHaveNoCompleteOrderWithTel:(NSString *)tel CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    //NSString *url = [PREURL stringByAppendingString:@"BookHandler.ashx"];
   // NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //parameters[@"Action"] = @"GetOrderIDNoMoney";
    //parameters[@"fkCusTel"] = tel;
//    [CLXiShiTangNetanager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
//        if (error) {
//            completionHandler(nil,error);
//        }
//        else
//        {
//            completionHandler(responseObj[@"提示"], nil);
//        }
//        
//    }];
}
//下面三个傻逼button点击方法
- (void)hunqbnt
{
    WeddingController *xishitang = [[WeddingController alloc]init];
    [self.navigationController pushViewController:xishitang animated:YES];
}
- (void)che
{
    CarController *marriageCC = [[CarController alloc]init];
    [self.navigationController pushViewController:marriageCC animated:YES];
}
- (void)ysx
{
//    [];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        ESLHeadlineDetailsController *headliD = [[ESLHeadlineDetailsController alloc]init];
        [self.navigationController pushViewController:headliD animated:YES];
    }
}
-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
