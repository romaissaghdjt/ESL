//
//  AppDelegate.m
//  ESL
//
//  Created by eyou on 16/9/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "AppDelegate.h"
#import "ESLHomeViewController.h"
#import "GuideViewController.h"
#import "XHTabBarController.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AlipaySDK/AlipaySDK.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "ESLBuyViewController.h"
#import "MyOrderController.h"
#import "MTVersionHelper.h"
#import "MyOrderController.h"


@interface AppDelegate ()
@property (nonatomic, strong)BMKMapManager *mapManager;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UIView *changeView;
@property (nonatomic, copy)NSString *telNum;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [application setApplicationIconBadgeNumber:0];
    
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            [self goToMssageViewControllerWith:remoteNotification];
        }
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    //创建极光推送
    [self creatJPushWithOptions:launchOptions];   
    //微信支付
    [WXApi registerApp:@"wxfc7bea7dec194b51" withDescription:@"com.nbeysx.ESL"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cookReturn:) name:@"CookReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CookReport:) name:@"CookReport" object:nil];
    
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [NSThread sleepForTimeInterval:1.5];//启动页停留时间
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        self.window.rootViewController =[[GuideViewController alloc] init];
    }
    else
    {
        //如果不是第一次启动的话,使用XHTabBarController作为根视图
        self.window.rootViewController = [[XHTabBarController alloc]init];
    }
    self.mapManager = [[BMKMapManager alloc]init];
    BOOL ret  = [self.mapManager start:@"UvqIyiMWjNQQX7GnYFUpwpBS7pZVVNG7" generalDelegate:nil];
    if (ret) {
        //NSLog(@"启动成功");
    }
    //检测更新
    [MTVersionHelper checkNewVersion];
    
    [ShareSDK registerApp:@"1ab20445e5f7c"
     
          activePlatforms:@[
                            
                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeRenren),
//                            @(SSDKPlatformTypeGooglePlus)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 //             case SSDKPlatformTypeQQ:
                 //                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 //                 break;
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 //                 break;
                 //             case SSDKPlatformTypeRenren:
                 //                 [ShareSDKConnector connectRenren:[RennClient class]];
                 //                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxfc7bea7dec194b51"
                                       appSecret:@"fd9b590fda0d911fc8a15f63027e0571"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeGooglePlus:
                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                            redirectUri:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([((UITabBarController *)application.keyWindow.rootViewController) isKindOfClass:[GuideViewController class]]) {
        if ([((UINavigationController*)((GuideViewController *)application.keyWindow.rootViewController).XHtabBar. selectedViewController).visibleViewController isKindOfClass:[ESLHomeViewController class]]) {
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"HomeBackground" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        else if ([((UINavigationController*)((GuideViewController *)application.keyWindow.rootViewController).XHtabBar.selectedViewController).visibleViewController isKindOfClass:[ESLBuyViewController class]])
        {
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"BuyBackground" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        return;
    }
    if ([((UINavigationController*)((UITabBarController *)application.keyWindow.rootViewController).selectedViewController).visibleViewController isKindOfClass:[ESLHomeViewController class]]) {
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"HomeBackground" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    else if ([((UINavigationController*)((UITabBarController *)application.keyWindow.rootViewController).selectedViewController).visibleViewController isKindOfClass:[ESLBuyViewController class]])
    {
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"BuyBackground" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    
    if ([(application.keyWindow.rootViewController) isKindOfClass:[GuideViewController class]]) {
        if ([((UINavigationController*)((GuideViewController *)application.keyWindow.rootViewController).XHtabBar. selectedViewController).visibleViewController isKindOfClass:[ESLHomeViewController class]]) {
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"HomeForeground" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        else if ([((UINavigationController*)((GuideViewController *)application.keyWindow.rootViewController).XHtabBar.selectedViewController).visibleViewController isKindOfClass:[ESLBuyViewController class]])
        {
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"BuyForeground" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        return;
    }
    if ([((UINavigationController*)((UITabBarController *)application.keyWindow.rootViewController).selectedViewController).visibleViewController isKindOfClass:[ESLHomeViewController class]]) {
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"HomeForeground" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    else if ([((UINavigationController*)((UITabBarController *)application.keyWindow.rootViewController).selectedViewController).visibleViewController isKindOfClass:[ESLBuyViewController class]])
    {
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"BuyForeground" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //应用重新启动要重新连接自动登录
    if (pw == nil&&us == nil) {
        return;
    }else{
        NSString*str = [[NSUserDefaults standardUserDefaults]objectForKey:@"server"];
        if ([str isEqualToString:@"out"]) {
            NSLog(@"自己断开要手动登陆操作");
        }else
        {
            NSString*str = [[NSUserDefaults standardUserDefaults]objectForKey:@"take"];

            if ([str isEqualToString:@"takeup"]) {
                return;
            }else{
                //除自己断开其他任何情况系统自动登陆<在你登陆过第一次后>
                [[TCPChannel getTcpChannel]reConnect];
            }
        }
    }
}



-(void)creatJPushWithOptions:(NSDictionary *)launchOptions
{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    [JPUSHService setBadge:0];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [self goToMssageViewControllerWith:userInfo];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [self goToMssageViewControllerWith:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self goToMssageViewControllerWith:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    [self goToMssageViewControllerWith:userInfo];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"paySuccess" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [self.window showWarning:@"支付成功"];
            }
            else
            {
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"payFailure" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [self.window showWarning:@"支付失败"];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {

                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"paySuccess" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [self.window showWarning:@"支付成功"];
            }
            else
            {
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"payFailure" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }
        }];
    }
    NSLog(@"%@", url.host);
    return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:{
                [self.window showWarning:@"支付成功"];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"paySuccess" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }
                break;
                
            default:{
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"payFailure" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [self.window showWarning:@"支付失败"];
            }
                break;
        }
    }
}
#pragma mark ---- 收到通知处理
- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{

    NSString * targetStr = [msgDic objectForKey:@"Page"];
    if ([targetStr isEqualToString:@"CookRob"]||[targetStr isEqualToString:@"CookReturn"]) {
        
        NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@"push"forKey:@"push"];
        [pushJudge synchronize];
        
        MyOrderController * moc = [[MyOrderController alloc]init];
        UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:moc];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
        
    }
//    else if ([targetStr isEqualToString:@"账号被顶"]) {
//        
//        NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//        [pushJudge setObject:@"push"forKey:@"push"];
//        [pushJudge synchronize];
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self.window.rootViewController presentViewController:naVC animated:YES completion:nil];
//    }
}

-(void)cookReturn:(NSNotificationCenter *)center
{
    [self.window showWarning:@"你的订单已被抢单,请去订单查看详情"];
}

-(void)CookReport:(NSNotification *)obj
{
    [self bookBtnClickWithTitle:@"友情提示" Message:@"你预定的厨师已到服务点" Tel:obj.userInfo[@"Msg"]];
}
#pragma mark -- 弹出框
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

-(void)callCancel:(UIButton *)sender
{
    self.changeView.hidden = YES;
    self.hiddenView.hidden = YES;
}

-(void)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.telNum]]];
}

@end
