//
//  ESLPaymentController.m
//  ESL
//
//  Created by 徐恒 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLPaymentController.h"
#import "ESLPaymentCell.h"
#import "ConfirmOrderController.h"
#import "ESLConfirmBottomView.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "MZTimerLabel.h"
#import "MyOrderController.h"
#define H 30
#import "ESLShopCartViewController.h"
#import "ESLFeastDetailViewController.h"
#import "ESLFoodInfoViewController.h"
#import "GuideViewController.h"
#import "ESLPayModel.h"
#import "ESLShopNetworkingManager.h"
typedef enum
{
    WECHAT,ALIPAY
}PAYTYPE;
@interface ESLPaymentController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *TableView;
@property (strong , nonatomic)ESLConfirmBottomView *confirmBV;
@property (strong, nonatomic)ConfirmOrderController *confirm;
@property (assign, nonatomic)NSInteger  i;
@property (nonatomic,strong)UIView *headView;
@property (strong, nonatomic)UIButton *confirmBtn;//确认支付按钮
@property (assign, nonatomic)NSString *snapDate;//获取时间
@property (strong, nonatomic)UILabel *headLab;
@property (strong, nonatomic)UILabel *priceLab;
@property (nonatomic, assign)PAYTYPE type;
@property (nonatomic, strong)NSArray *payList;
@property (strong, nonatomic)UIButton *selectedBtn;//优惠券按钮
@property (strong, nonatomic)UILabel *availableLab;//可用额度
@property (strong, nonatomic) UILabel *moneyLab;//应支付的额度
//@property (strong, nonatomic)UIButton *btn;
@end

@implementation ESLPaymentController
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    UILabel *labelText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticepPaySuccess:) name:@"paySuccess" object:nil];
    [center addObserver:self selector:@selector(noticepPayFailure:) name:@"payFailure" object:nil];
    self.navigationItem.title = @"选择支付方式";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = ZXColor(240, 240, 240, 1);
    
    self.payList = [ESLPayModel getPayList];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 22)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(22, -22, 20, 0)];
    [button setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBtn;
    _i=-1;
    [self createView];
    [self createTable];
    [self createBtn];
    [self request];
    [self requestCouponsData];
    self.type = ALIPAY;
}
#pragma mark == 请求时间 ===
- (void)request{
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Order&Function=HttpQueryOrderLatestPayDt&OrderID=%@"],_orderNum];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.snapDate = dic[@"Date"];
        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:_priceLab andTimerType:MZTimerLabelTypeTimer];
        [timer setCountDownTime:self.snapDate.integerValue];//支付时间
        [timer startWithEndingBlock:^(NSTimeInterval countTime) {
            _headLab.text = @"付款时间已到";
            _headLab.textColor = [UIColor grayColor];
        [self showFailureMessage:@"您在支付时间以内未支付请重新下单"];
        }];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)createBtn{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,KHEIGHT-40, KWIDTH, 40)];
    btn.backgroundColor = ZXColor(91, 179, 77, 1);
    [btn setTitle:[NSString stringWithFormat:@"确认支付¥%.2f",self.priceLabel.floatValue] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ClickConfirmBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.confirmBtn = btn;
}
#pragma mark == 确认==
- (void)ClickConfirmBtnBtn{
    if (self.type == ALIPAY) {
        [self doAlipayPay];
    }
    else if (self.type == WECHAT)
    {
        [self doWechatPay];
    }
    
}
- (void)backClick{
    NSArray *vcArray = self.navigationController.viewControllers;
    NSLog(@"%@",vcArray);
    for (UIViewController *vc in vcArray) {
        if ([vc isKindOfClass:[ESLFeastDetailViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
        }else if([vc isKindOfClass:[ESLShopCartViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
        }else if ([vc isKindOfClass:[ESLFoodInfoViewController class]]){
            [self.navigationController popToViewController:vc animated:NO];
        }
    }

    if (_isBB ==YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    
    
}
- (void)createView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 30)];
    headView.backgroundColor = ZXColor(253, 248, 224, 1);
    [self.view addSubview:headView];
    self.headView = headView;
    
    _headLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 120, 30)];
    _headLab.text = @"支付剩余时间:";
    _headLab.textColor = ZXColor(249, 149, 47, 1);
    _headLab.textAlignment = NSTextAlignmentCenter;
    _headLab.font = [UIFont systemFontOfSize:15];
    [headView addSubview:_headLab];
    
    _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headLab.frame), 0, KWIDTH-_headLab.frame.size.width, 30)];
    _priceLab.textColor = ZXColor(249, 149, 47, 1);
    _priceLab.text = @"03分10秒";
    [headView addSubview:_priceLab];
    
 
}
- (void)createTable{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.rowHeight = 80;
    _TableView.tableFooterView = [UIView new];//去掉多余的线
    _TableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_TableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        static NSString *ID = @"cell";
        ESLPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLPaymentCell" owner:nil options:nil].firstObject;
            [cell.CheckBtn setImage:defaultImg forState:UIControlStateNormal];
            [cell.CheckBtn setImage:seletedImg forState:UIControlStateSelected];
        }
    ESLPayModel *model = self.payList[indexPath.row];
    cell.Img.image = [UIImage imageNamed:model.imageName];
    cell.NameLabel.text = model.nameText;
    cell.SubtitleLable.text = model.describeName;
    cell.CheckBtn.selected = model.btnIsSelect;
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (ESLPayModel *model in self.payList) {
        model.btnIsSelect = NO;
    }
    ESLPayModel *model = self.payList[indexPath.row];
    model.btnIsSelect = YES;
    if (indexPath.row == 0) {
        self.type = ALIPAY;
    }
    else
    {
        self.type = WECHAT;
    }

    [self.TableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ZXColor(255, 250, 236, 1);
    UILabel *orderLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, H)];
    orderLab.text = @"订单号:";
    orderLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:orderLab];
    
    UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderLab.frame)+20, orderLab.frame.origin.y , KWIDTH-100, H)];
    numLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:numLab];
    numLab.text = [NSString stringWithFormat:@"%@",self.orderNum];
    
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, numLab.frame.origin.y+orderLab.frame.size.height, KWIDTH, 1)];
    oneView.backgroundColor = ZXColor(240, 240, 240, 1);
    [view addSubview:oneView];
    
    UILabel *payAmountLab = [[UILabel alloc]initWithFrame:CGRectMake(orderLab.frame.origin.x, oneView.frame.origin.y+10 , 70, H)];
    payAmountLab.text = @"支付金额:";
    payAmountLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:payAmountLab];
    
  _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(payAmountLab.frame)+10, oneView.frame.origin.y+10 , KWIDTH-100, H)];
    _moneyLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:_moneyLab];
    _moneyLab.text = [NSString stringWithFormat:@"%.2f",self.priceLabel.floatValue];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, _moneyLab.frame.origin.y+orderLab.frame.size.height, KWIDTH, 1)];
    secondView.backgroundColor = ZXColor(240, 240, 240, 1);
    [view addSubview:secondView];
    
//    UILabel *couponsLab = [[UILabel alloc]initWithFrame:CGRectMake(orderLab.frame.origin.x, secondView.frame.origin.y+10, 60, H)];
//    couponsLab.text = @"优惠券:";
//    couponsLab.font = [UIFont systemFontOfSize:15];
//    [view addSubview:couponsLab];
//
//    _availableLab = [[UILabel alloc]init];
//    if (SW==320) {
//        _availableLab.frame = CGRectMake(CGRectGetMaxX(couponsLab.frame)+60, secondView.frame.origin.y+10,80, H);
//    }else if (SW==375){
//        _availableLab.frame = CGRectMake(CGRectGetMaxX(couponsLab.frame)+75, secondView.frame.origin.y+10,80, H);
//    }else{
//        _availableLab.frame = CGRectMake(CGRectGetMaxX(couponsLab.frame)+90, secondView.frame.origin.y+10,80, H);
//    }
//    _availableLab.text = @"可用优惠券";
//    _availableLab.font = [UIFont systemFontOfSize:15];
//    _availableLab.textColor = [UIColor grayColor];
//    [view addSubview:_availableLab];
//    
//    _selectedBtn = [[UIButton alloc]init];
//    if (SW==320) {
//        _selectedBtn.frame = CGRectMake(CGRectGetMaxX(_availableLab.frame)+68, secondView.frame.origin.y+12, 22, 22);
//    }else if (SW==375){
//        _selectedBtn.frame = CGRectMake(CGRectGetMaxX(_availableLab.frame)+108, secondView.frame.origin.y+12, 22, 22);
//    }else{
//        _selectedBtn.frame = CGRectMake(CGRectGetMaxX(_availableLab.frame)+132, secondView.frame.origin.y+12, 22, 22);
//    }
//    [_selectedBtn setImage:defaultImg forState:UIControlStateNormal];
//    [_selectedBtn setImage:seletedImg forState:UIControlStateSelected];
//    [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
////    selectedBtn.backgroundColor = [UIColor redColor];
//    [view addSubview:_selectedBtn];
//    
    UIView *towView = [[UIView alloc]initWithFrame:CGRectMake(0, _moneyLab.frame.origin.y+_moneyLab.frame.size.height, KWIDTH, 10)];
    towView.backgroundColor = ZXColor(240, 240, 240, 1);
    [view addSubview:towView];
    
    UILabel *methodLab = [[UILabel alloc]initWithFrame:CGRectMake(orderLab.frame.origin.x, towView.frame.origin.y+10 , KWIDTH, H)];
    methodLab.text = @"请选择支付方式";
    methodLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:methodLab];
    
    self.TableView.tableHeaderView = view;
    return view;
}
//优惠券的点击事件
- (void)selectedBtnClick:(UIButton *)sender{
    sender.selected =! sender.selected;
    if (!sender.selected) {
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",self.priceLabel.floatValue];
        [self.confirmBtn setTitle:[NSString stringWithFormat:@"确认支付¥%.2f",self.priceLabel.floatValue] forState:UIControlStateNormal];

        _availableLab.textColor = [UIColor grayColor];

    }else{
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",self.priceLabel.floatValue-self.availableLab.text.floatValue];
        [self.confirmBtn setTitle:[NSString stringWithFormat:@"确认支付¥%.2f",self.priceLabel.floatValue-self.availableLab.text.floatValue] forState:UIControlStateNormal];
        _availableLab.textColor = [UIColor blackColor];
    }
}
//获取优惠券额度
- (void)requestCouponsData{
    //https://ess.nbeysx.com/ashx/User.ashx?Function=HttpQueryVoucherValue&UserTel=15558793823&UserPhyAdd=123456
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"User.ashx?Function=HttpQueryVoucherValue&UserTel=%@&UserPhyAdd=%@"],us,KUUID];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"%@",dic);
        self.availableLab.text = [NSString stringWithFormat:@"%.2f",[dic[@"VoucherValue"] floatValue]];
        if (self.availableLab.text.length == 0 ) {
            self.selectedBtn.userInteractionEnabled = NO;
            [self.selectedBtn setImage:defaultImg forState:UIControlStateNormal];
        }
    } failedWithError:^(NSError *Error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)doWechatPay
{
    [ESLShopNetworkingManager getWechatPayWithPurpose:@"0" Value:nil OrderID:self.orderNum VoucherValue:self.availableLab.text  CompletionHandler:^(NSDictionary *dict, NSError *error) {
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

- (void)doAlipayPay
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
    dict[@"purpose"] = @"0";
    dict[@"UserTel"] = us;
    dict[@"OrderID"] = self.orderNum;
    dict[@"VoucherValue"] = self.availableLab.text;
    dict[@"value"] = [NSString stringWithFormat:@"%.2f", self.priceLabel.floatValue];
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    order.biz_content.body = str;
    order.biz_content.subject = self.orderNum;
    order.biz_content.out_trade_no = self.orderNum; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", self.priceLabel.floatValue]; //商品价格
    
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

//到时还未确认支付
- (void)showFailureMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    WK(weakSelf)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:cancelAction];
}

-(void)noticepPaySuccess:(NSNotificationCenter *)center
{
    if ([self.view.window.rootViewController isKindOfClass:[GuideViewController class]]) {
        if ([((UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController).visibleViewController isKindOfClass:[self class]])
        {
            self.view.window.rootViewController.tabBarController.selectedIndex=3;
            [(UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController popToRootViewControllerAnimated:NO];
            MyOrderController *myVC = [[MyOrderController alloc]init];
            [(UINavigationController*)((UITabBarController *)((GuideViewController *)self.view.window.rootViewController).XHtabBar).selectedViewController pushViewController:myVC animated:NO];
        }
        return;
    }
    if ([((UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController).visibleViewController isKindOfClass:[self class]]) {
        self.view.window.rootViewController.tabBarController.selectedIndex=3;
        [(UINavigationController*)((UITabBarController *)self.view.window.rootViewController).selectedViewController popToRootViewControllerAnimated:NO];
        MyOrderController *myVC = [[MyOrderController alloc]init];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"paySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"payFailure" object:nil];
}
@end
