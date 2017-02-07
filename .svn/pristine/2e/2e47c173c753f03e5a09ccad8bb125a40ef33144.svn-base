//
//  ESLMyPayViewController.m
//  ESL
//
//  Created by eyou on 16/11/15.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLMyPayViewController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "MyAssetsController.h"
#import "GuideViewController.h"
#import "ESLShopNetworkingManager.h"

typedef enum
{
    WECHAT, ALIPAY
}PAYTYPE;
@interface ESLMyPayViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *wechatChose;
@property (weak, nonatomic) IBOutlet UIImageView *alipayChose;
@property (weak, nonatomic) IBOutlet UITextField *payNum;
@property (nonatomic, assign)PAYTYPE type;

@end

@implementation ESLMyPayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticepPaySuccess:) name:@"paySuccess" object:nil];
    [center addObserver:self selector:@selector(noticepPayFailure:) name:@"payFailure" object:nil];
    
    self.title = @"账户充值";
    self.payNum.delegate = self;
    self.type = WECHAT;
    self.payNum.keyboardType = UIKeyboardTypeDecimalPad;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wechatPayClick:(UITapGestureRecognizer *)sender {
    self.wechatChose.image = [UIImage imageNamed:@"Selected"];
    self.alipayChose.image = [UIImage imageNamed:@"Unselected"];
    self.type = WECHAT;
}
- (IBAction)alipayCIick:(UITapGestureRecognizer *)sender {
    self.wechatChose.image = [UIImage imageNamed:@"Unselected"];
    self.alipayChose.image = [UIImage imageNamed:@"Selected"];
    self.type = ALIPAY;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat rects = 216 - (KHEIGHT - 237 - 60);
    if (rects >= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = -rects;
            self.view.frame = frame;
        }];
    }
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

-(void)doWechatPay
{
    [ESLShopNetworkingManager getWechatPayWithPurpose:@"1" Value:[NSString stringWithFormat:@"%.2f", self.payNum.text.floatValue] OrderID:[self getTimeNow] VoucherValue:nil CompletionHandler:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [self.view showWarning:@"服务器繁忙"];
        }
        else
        {
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req];
        }
    }];
}

- (IBAction)gotoNext:(UIButton *)sender {
    if (self.payNum.text.length == 0) {
        return;
    }
    if ([self.payNum.text doubleValue]>50000) {
        [self.view showWarning:@"本次最多可充值50000.00"];
        return;
    }
    if (self.type == ALIPAY) {
        [self doAlipay];
    }
    else if (self.type == WECHAT)
    {
        [self doWechatPay];
    }
}

- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

-(void)noticepPaySuccess:(NSNotificationCenter *)center
{
    if ([self.view.window.rootViewController isKindOfClass:[GuideViewController class]]) {
        if ([((UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController).visibleViewController isKindOfClass:[self class]])
        {
            self.view.window.rootViewController.tabBarController.selectedIndex=3;
            [(UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController popToRootViewControllerAnimated:NO];
            MyAssetsController *myVC = [[MyAssetsController alloc]init];
            [(UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController pushViewController:myVC animated:NO];
        }
        return;
    }
    if ([((UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController).visibleViewController isKindOfClass:[self class]]) {
        self.view.window.rootViewController.tabBarController.selectedIndex=3;
        [(UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController popToRootViewControllerAnimated:NO];
        MyAssetsController *myVC = [[MyAssetsController alloc]init];
        [(UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController pushViewController:myVC animated:NO];
    }
}

-(void)noticepPayFailure:(NSNotificationCenter *)center
{
    if ([self.view.window.rootViewController isKindOfClass:[GuideViewController class]]) {
        if ([((UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController).visibleViewController isKindOfClass:[self class]])
        {
            [self.view showWarning:@"支付失败"];
        }
        return;
    }
    if ([((UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController).visibleViewController isKindOfClass:[self class]]) {
        [self.view showWarning:@"支付失败"];
    }
}

-(void)doAlipay
{
    NSString *appID = APPID;
    NSString *privateKey = PRIVATEKEY;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    order.notify_url = [PREURL stringByAppendingString:@"alipay_index.ashx"];
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //支付与充值
    dict[@"purpose"] = @"1";
    dict[@"UserTel"] = us;
    dict[@"OrderID"] = [self getTimeNow];
    dict[@"value"] = [NSString stringWithFormat:@"%.2f", self.payNum.text.floatValue];
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    order.biz_content.body = str;
    order.biz_content.subject = @"充值";
    order.biz_content.out_trade_no = dict[@"OrderID"]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", self.payNum.text.floatValue]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"com.nbeysx.ESL";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [self noticepPaySuccess:nil];
            }
            else
            {
                [self noticepPayFailure:nil];
            }
        }];
    }

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"paySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"payFailure" object:nil];
}
@end
