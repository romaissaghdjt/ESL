//
//  ESLMyViewController.m
//  ESL
//
//  Created by eyou on 16/9/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLMyViewController.h"
#import "AccountCell.h"
#import "MyOrderCell.h"
#import "MyAssetsCell.h"
#import "HodgepodgeCell.h"
#import "MyOrderController.h"

#import "MessageController.h"
#import "PersonalInformationController.h"
#import "ForThePaymentController.h"
#import "ForSheShippingController.h"
#import "ToEvaluateController.h"
#import "ARefundAfterController.h"
#import "MyAssetsController.h"
#import "ESLMyPayViewController.h"
#import "MyOrderController.h"

#import "MyInvitationController.h"
#import "MyWeddingHallController.h"
#import "MyCookController.h"
#import "ShoppingAddressController.h"
#import "MyCollectionController.h"
#import "RealNameAuthenticationController.h"
#import "MyCooperationController.h"
#import "ESLHomeViewController.h"
#import "ESLMyNetworkingManager.h"
//#import "ToJoinChooseController.h"
#import "ToJoinCookChooseController.h"
#import "PersonalController.h"
#import "MyOrderViewModel.h"
#import "ESLUserModel.h"
#import "CLChooseViewController.h"

@interface ESLMyViewController ()<UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
@property (strong, nonatomic)UITableView *TableView;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UIView *changeView;
@property (nonatomic,assign)BOOL isFrist;
@property (nonatomic,strong)ESLHomeViewController*hh;
@property (nonatomic)BOOL isLogin;
@property (nonatomic, strong)NSDictionary *balanceDict;
@property (nonatomic,strong)MyOrderViewModel*ViewModel;
//@property (nonatomic,strong)ESLUserModel*UModel;
@property (nonatomic,strong)NSArray*userArray;
@property (nonatomic, copy)NSString *userID;
@property (nonatomic,strong)NSString*Yes_Or_No;
@end

@implementation ESLMyViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfoData];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        self.TableView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginViewController*login = [[LoginViewController alloc] init];
            login.delegate = self;
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
            
            [self presentViewController:navVC animated:NO completion:nil];
        });
        
    }else{
        _isLogin  = YES;
        self.TableView.hidden = NO;

        [self.TableView reloadData];
    }
    [ESLMyNetworkingManager getAccountBalanceWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSDictionary *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.balanceDict = result;
            [self.TableView reloadData];
        }
    }];
    
    self.tabBarController.tabBar.hidden = NO;
}
//登陆返回代理
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"我的";
    //监听什么网络
    AFNetworkReachabilityManager *megr = [AFNetworkReachabilityManager sharedManager];
    [megr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0)
        {
            [UIViewController showMessage:@"你没有开启没有网络" ViewController:self];
        }else if (status >= 1)
        {
            
        }
    }];
    
    //开始监听
    [megr startMonitoring];
    _isLogin  = NO;

    [self createTableView];
    [self RemoveTheLine];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"铃铛"] style:(UIBarButtonItemStylePlain) target:self action:@selector(ClickBtn:)];

    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ZXColor(255, 255, 255, 1);
    [self getUserInfoData];
    
}
- (void)getUserInfoData
{
    WK(weakSelf)
    _ViewModel= [[MyOrderViewModel alloc]init];
    _ViewModel.User_Block = ^(id UserData)
    {
         weakSelf.userArray = UserData;
        [weakSelf.TableView reloadData];
    };
    
    [_ViewModel getUserInfo];
}
- (void)getJoin_Yes_or_No
{
    WK(weakSelf)
    _ViewModel= [[MyOrderViewModel alloc]init];
    _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
        if ([Cancl_Or_deleteData isEqualToString:@"你从来没有申请过厨师加盟"]) {
            [[ShowMessageTools sharedInstance]showMessageBack:Cancl_Or_deleteData controller:weakSelf block:^{
                ToJoinCookChooseController *tojoinC = [[ToJoinCookChooseController alloc]init];
                [weakSelf.navigationController pushViewController:tojoinC animated:YES];
            }];
            
        }else
        {
            [[ShowMessageTools sharedInstance]showSimplMessage:Cancl_Or_deleteData controller:weakSelf];
        }
    };
    [_ViewModel getYes_Or_Join];
}
- (void)ClickBtn:(UIButton *)sender
{
    MessageController *messageC = [[MessageController alloc]init];
    [self.navigationController pushViewController:messageC animated:YES];
}

//去掉导航栏 下面的线
- (void)RemoveTheLine{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }

}
- (void)createTableView{
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-49-64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.showsVerticalScrollIndicator = NO;
    [_TableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];//去掉多余的线
     [self.view addSubview:_TableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 8;
    }else{
        return 1;
    }
}
- (UIImage*)loadimage:(NSString*)str
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    return image;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {//个人信息
        static NSString *ID = @"cell";
        AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"AccountCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
           
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Abg"]];
            cell.userNameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            cell.userAccountLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            cell.lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        }
        if (_isLogin == YES) {
            cell.userAccountLable.text = us;
        }
        
             ESLUserModel*UModel = self.userArray[0];
       
                cell.userNameLable.text = UModel.NickName;

        
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:UModel.ImageUrl]];
            return cell;
        
    }else if (indexPath.section==1){
        static NSString *ID = @"cell";
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            
            [cell.ForThePayment addTarget:self action:@selector(ClickForThePayment:) forControlEvents:UIControlEventTouchUpInside];
            [cell.ForSheShipping addTarget:self action:@selector(ClickForSheShipping:) forControlEvents:UIControlEventTouchUpInside];
            [cell.ToEvaluate addTarget:self action:@selector(ClickToEvaluate:) forControlEvents:UIControlEventTouchUpInside];
            [cell.ARefundAfter addTarget:self action:@selector(ClickARefundAfter:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section==2){
        static NSString *ID = @"cell";
        MyAssetsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MyAssetsCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            [cell.TopUp addTarget:self action:@selector(ClickTopUp:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.balanceLabel.text = [NSString stringWithFormat:@"%.02lf",[self.balanceDict[@"AccountValue"] floatValue]];
        cell.freezeLabel.text = [NSString stringWithFormat:@"%.02lf",[self.balanceDict[@"FrozenValue"] floatValue]];;
        return cell;
    }else{
        static NSString *ID = @"cell";
        HodgepodgeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"HodgepodgeCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
            if (indexPath.row==0){
                cell.Img.image = [UIImage imageNamed:@"123"];
                cell.Name.text = @"我是厨师";
        }
        else if (indexPath.row==1){
            cell.Img.image = [UIImage imageNamed:@"123456"];
            cell.Name.text = @"收货地址";
        }
        else if (indexPath.row==2){
            cell.Img.image = [UIImage imageNamed:@"7"];
            cell.Name.text = @"我的收藏";
        }
        else if (indexPath.row==3){
            cell.Img.image = [UIImage imageNamed:@"8"];
            cell.Name.text = @"我要加盟";
        }
        else if (indexPath.row==4){
            cell.Img.image = [UIImage imageNamed:@"hd"];
            cell.Name.text = @"互动";
        }
        else if (indexPath.row==5){
            cell.Img.image = [UIImage imageNamed:@"share"];
            cell.Name.text = @"我要分享";
        }
        else if (indexPath.row==6) {
            cell.Img.image = [UIImage imageNamed:@"10"];
            cell.Name.text = @"联系客服";
        }else{
            cell.Img.image = [UIImage imageNamed:@"10"];
            cell.Name.text = @"视频";
        }
        
        return cell;
    }
}
/*待支付*/
- (void)ClickForThePayment:(UIButton *)sender
{
    MyOrderController *MyOrderC = [[MyOrderController alloc]init];
    MyOrderC.int_ID = 1;
    [self.navigationController pushViewController:MyOrderC animated:YES];
}
/*待发货*/
- (void)ClickForSheShipping:(UIButton *)sender
{
    MyOrderController *MyOrderC = [[MyOrderController alloc]init];
    MyOrderC.int_ID = 2;
    [self.navigationController pushViewController:MyOrderC animated:YES];
}
/*待收货*/
- (void)ClickToEvaluate:(UIButton *)sender
{
    MyOrderController *MyOrderC = [[MyOrderController alloc]init];
    MyOrderC.int_ID = 3;
    [self.navigationController pushViewController:MyOrderC animated:YES];
}
/*待评价*/
- (void)ClickARefundAfter:(UIButton *)sender
{
    MyOrderController *MyOrderC = [[MyOrderController alloc]init];
    MyOrderC.int_ID = 4;
    [self.navigationController pushViewController:MyOrderC animated:YES];
}
/*充值*/
-(void)ClickTopUp:(UIButton *)sender
{
    ESLMyPayViewController *mpvc = [[ESLMyPayViewController alloc]init];
    [self.navigationController pushViewController:mpvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }else if (indexPath.section==1){
        return 102;
    }else if (indexPath.section==2){
        return 100;
    }else{
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        return 0.00f;
    }else{
        return 5.0f;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {//个人信息
        PersonalController *PIC = [[PersonalController alloc]init];
        ESLUserModel*model =  self.userArray[0];
        PIC.umodel = model;
        [self.navigationController pushViewController:PIC animated:YES];
    }else if (indexPath.section==1){//我的订单

        MyOrderController *MyOrderVC = [[MyOrderController alloc]init];
        [self.navigationController pushViewController:MyOrderVC animated:YES];
       }else if (indexPath.section==2){//我的资产

        MyAssetsController *MyAC = [[MyAssetsController alloc]init];
        [self.navigationController pushViewController:MyAC animated:YES];
    }else{
      if (indexPath.row==0){//我是厨师
        [ESLMyNetworkingManager getUserInfoCompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [self.view showWarning:@"服务器繁忙"];
            }
            else
            {
                self.userID = result;
                if ([self.userID isEqualToString:@"32"]) {
                    MyCookController *MyCC = [[MyCookController alloc]init];
                    [self.navigationController pushViewController:MyCC animated:YES];
                }
                else
                {
                    [self.view showWarning:@"您还没有加盟厨师"];
                }
            }
        }];
//            MyWeddingHallController *MyWHC = [[MyWeddingHallController alloc]init];
//            [self.navigationController pushViewController:MyWHC animated:YES];
        }
        else if (indexPath.row==1){//收货地址
            ShoppingAddressController *shipAC = [[ShoppingAddressController alloc]init];
            [self.navigationController pushViewController:shipAC animated:YES];
        }
        else if (indexPath.row==2){//我的收藏
            MyCollectionController *MyCc = [[MyCollectionController alloc]init];
            [self.navigationController pushViewController:MyCc animated:YES];
        
        }
        else if (indexPath.row==3){//我的合作
             [self getJoin_Yes_or_No];
            
            
        }
        else if (indexPath.row==4){
            
            CLChooseViewController *cvc = [[CLChooseViewController alloc]init];
            [self presentViewController:cvc animated:YES completion:nil];
//
        }
      else if (indexPath.row==5){
          
          //1、创建分享参数
          NSArray* imageArray = @[[UIImage imageNamed:@"120x120.png"]];
          //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
          //if (imageArray) {
          
          NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
          [shareParams SSDKSetupShareParamsByText:@"甬尚鲜为你提供一站式的生鲜配送服务。"
                                           images:imageArray
                                              url:[NSURL URLWithString: @"http://ysx001.nbeysx.com"]
                                            title:@"甬尚鲜已经上线欢迎下载"
                                             type:SSDKContentTypeAuto];
          [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                   items:nil
                             shareParams:shareParams
                     onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                         
                         switch (state) {
                             case SSDKResponseStateSuccess:
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                     message:nil
                                                                                    delegate:nil
                                                                           cancelButtonTitle:@"确定"
                                                                           otherButtonTitles:nil];
                                 [alertView show];
                                 break;
                             }
                             case SSDKResponseStateFail:
                             {
                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                 message:[NSString stringWithFormat:@"%@",error]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK"
                                                                       otherButtonTitles:nil, nil];
                                 [alert show];
                                 break;
                             }
                             default:
                                 break;
                         }
                     }
           ];
      }
        else if(indexPath.row==6){
            //            联系客服
            [self reservationClick];
        }else{
            MyInvitationController *myInvitationC = [[MyInvitationController alloc]init];
            [self.navigationController pushViewController:myInvitationC animated:YES];
        }
       
    }
}
//联系客服
-(void)reservationClick
{
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
        presentationLabel.text = @"友情提示";
        presentationLabel.textColor = [UIColor darkGrayColor];
        presentationLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.changeView addSubview:presentationLabel];
        
        UILabel *callLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 300, 30)];
        callLabel.font = [UIFont boldSystemFontOfSize:18];
        callLabel.text = @"请拨打我公司服务热线";
        callLabel.textAlignment = NSTextAlignmentCenter;
        [self.changeView addSubview:callLabel];
        
        UIButton *numBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 300, 30)];
        [numBtn setTitle:@"400-8261-707" forState:UIControlStateNormal];
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
        self.changeView.hidden = NO;
        self.hiddenView.hidden = NO;
    }
}
-(void)callCancel:(UIButton *)sender
{
    self.changeView.hidden = YES;
    self.hiddenView.hidden = YES;
}

-(void)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://400-8216-707"]];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
