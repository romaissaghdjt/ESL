//
//  XHXiShiTangController.m
//  YY
//
//  Created by 徐恒 on 16/4/23.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHXiShiTangController.h"
#import "DistrictAlertViewController.h"
#import "TownViewController.h"
#import "CLXiShiTangNetanager.h"
#import "VillageViewController.h"
#import "CLMapViewController.h"
#import "MapBottomView.h"
#import "LoginViewController.h"
#import "CLCalendarViewController.h"
#import "UIView+HUD.h"

@interface XHXiShiTangController ()<UITextFieldDelegate>
@property (strong, nonatomic)UITextField *day;

@property (strong, nonatomic) UIImageView *dropdownMenu;
@property (strong, nonatomic) NSArray *areaArray;

@property (strong, nonatomic) NSString *str;
@property (strong, nonatomic) UITextField *addressTextField;
//通过区选中的所有城镇
@property (nonatomic, strong)NSArray *townList;
//选中的乡村
@property (nonatomic, strong)CLVillageModel *villageModel;

@property (nonatomic, strong)CLTownsModel *townModel;

//通过城镇选中的所有乡村
@property (nonatomic, strong)NSArray *villageList;

//所选择的日期
@property (strong, nonatomic)NSString *chooseDate;

@property (nonatomic, strong)MapBottomView *mapBottomView;
//所有喜事堂数据模型
@property (nonatomic, strong)XiShiTangModel *xiShiTangModel;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@property (nonatomic, strong)UITextField *linkmanField;
@property (nonatomic, strong)UITextField *linkTelField;
@property (nonatomic, strong)UIButton *districtBtn;
@property (nonatomic, strong)UILabel *townLabel;
@property (nonatomic, strong)UILabel *villageLabel;
@end

@implementation XHXiShiTangController
-(CLVillageModel *)villageModel
{
    if (!_villageModel) {
        _villageModel = [[CLVillageModel alloc]init];
    }
    return _villageModel;
}

-(CLTownsModel *)townModel
{
    if (!_townModel) {
        _townModel = [[CLTownsModel alloc]init];
    }
    return _townModel;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WK(weakSelf)
    [self.view showBusyHUD];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"喜事堂";
    self.tabBarController.tabBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark --  第一行
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 163*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    label.text = @"请选择所在区域：";
    //   label. backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    
    self.districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.districtBtn.frame = CGRectMake(165*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 93*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
    [self.districtBtn setTitle:@"鄞州区" forState:UIControlStateNormal];
    [self.districtBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.districtBtn addTarget:self action:@selector(pushDistrictView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.districtBtn.layer.cornerRadius = 5;
    self.districtBtn.layer.masksToBounds = YES;
    self.districtBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    self.districtBtn.layer.borderWidth = 1;
    [self.view addSubview:self.districtBtn];
    [self.districtBtn setImage:[UIImage imageNamed:@"drop_down.png"] forState:UIControlStateNormal];
    self.districtBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.districtBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -50);
    self.districtBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    
    UIView *townView = [[UIView alloc]initWithFrame:CGRectMake(260*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 105*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    townView.layer.cornerRadius = 5;
    townView.layer.masksToBounds = YES;
    townView.layer.borderColor = [[UIColor grayColor] CGColor];
    townView.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushTownView)];
    [townView addGestureRecognizer:tap];
    townView.tag = 49;
    
    
    self.townLabel = [[UILabel alloc]init];
    self.townLabel.frame = CGRectMake(0*SWIDTH_SCALE, 5*SHEIGHT_DCALE, 80*SWIDTH_SCALE, 20*SHEIGHT_DCALE);
    
//    townLabel.text = @"咸祥镇";
    self.townLabel.font = [UIFont systemFontOfSize:16];
    self.townLabel.textColor = [UIColor blueColor];
    [townView addSubview:self.townLabel];
    self.townLabel.tag = 50;
    self.townLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIImageView *townImage = [[UIImageView alloc]initWithFrame:CGRectMake(85*SWIDTH_SCALE, 5*SHEIGHT_DCALE, 15*SWIDTH_SCALE, 20*SHEIGHT_DCALE)];
    townImage.image = [UIImage imageNamed:@"drop_down.png"];
    townImage.contentMode = UIViewContentModeScaleAspectFit;
    [townView addSubview:townImage];
    [self.view addSubview:townView];
    
#pragma mark --  第二行
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(10*SWIDTH_SCALE, 150*SHEIGHT_DCALE, 130*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    label5.text = @"请选择喜事堂:";
    label5.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label5];
    
    UIView *villageView = [[UIView alloc]initWithFrame:CGRectMake(140*SWIDTH_SCALE, 150*SHEIGHT_DCALE, 185*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    villageView.layer.cornerRadius = 5;
    villageView.layer.masksToBounds = YES;
    villageView.layer.borderColor = [[UIColor grayColor] CGColor];
    villageView.layer.borderWidth = 1;
    UITapGestureRecognizer *tapVillage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushVillageView)];
    [villageView addGestureRecognizer:tapVillage];
    villageView.tag = 48;
    
    self.villageLabel = [[UILabel alloc]init];
    self.villageLabel.frame = CGRectMake(0, 5*SHEIGHT_DCALE, 165*SWIDTH_SCALE, 20*SHEIGHT_DCALE);
    self.villageLabel.textColor = [UIColor blueColor];
//    villageLabel.text = @"南头村";
    self.villageLabel.font = [UIFont systemFontOfSize:15];
    self.villageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:villageView];
    
    [villageView addSubview:self.villageLabel];
    self.villageLabel.tag = 51;
    
    UIImageView *villageImage = [[UIImageView alloc]initWithFrame:CGRectMake(165*SWIDTH_SCALE, 5*SHEIGHT_DCALE, 15*SWIDTH_SCALE, 20*SHEIGHT_DCALE)];
    villageImage.image = [UIImage imageNamed:@"drop_down.png"];
    villageImage.contentMode = UIViewContentModeScaleAspectFit;
    [villageView addSubview:villageImage];
    
    
    UIButton *searchMap = [UIButton buttonWithType:UIButtonTypeCustom];
    searchMap.frame = CGRectMake(330*SWIDTH_SCALE, 150*SHEIGHT_DCALE, 30*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
    [searchMap setImage:[UIImage imageNamed:@"dingwei.png"] forState:UIControlStateNormal];
    [searchMap addTarget:self action:@selector(xishiClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchMap setTintColor:[UIColor grayColor]];
    [self.view addSubview:searchMap];
    
    
#pragma mark --  第三行
    self.mapBottomView = [[MapBottomView alloc]init];
    self.mapBottomView.frame = CGRectMake(0, 210*SHEIGHT_DCALE, KWIDTH, 100);
    //    _mapBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mapBottomView];
    
#pragma mark -- 第六行
    
    UILabel *label13 = [[UILabel alloc]initWithFrame:CGRectMake(30*SWIDTH_SCALE, 360*SHEIGHT_DCALE, 105*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    //        label13.backgroundColor = [UIColor redColor];
    label13.text = @"查看档期:";
    label13.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label13];
    
    self.day = [[UITextField alloc]initWithFrame:CGRectMake(135*SWIDTH_SCALE, 360*SHEIGHT_DCALE, 145*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    //    self.day.backgroundColor = [UIColor greenColor];
    self.day.placeholder = @"请查看喜宴日期";
    self.day.enabled = NO;
    [self.view addSubview:self.day];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(290*SWIDTH_SCALE, 350*SHEIGHT_DCALE, 50*SWIDTH_SCALE, 50*SHEIGHT_DCALE);
    [button2 setImage:[UIImage imageNamed:@"day.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(riqiClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    if (self.isFromOther == YES) {
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(30*SWIDTH_SCALE, 550*SHEIGHT_DCALE, 300*SWIDTH_SCALE, 50*SHEIGHT_DCALE);
        confirmBtn.center = CGPointMake(self.view.center.x, 550*SHEIGHT_DCALE);
        
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setBackgroundColor:ZXColor(90, 172, 56, 1)];
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:confirmBtn];
    }
    [CLXiShiTangNetanager getAllDistrictDateWithCompletionHandler:^(XiShiTangModel *xiShiTangModel, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"网络错误" ViewController:self];
        }
        else
        {
            weakSelf.xiShiTangModel = xiShiTangModel;
            weakSelf.areaArray = weakSelf.xiShiTangModel.Counties;
            weakSelf.townList = weakSelf.xiShiTangModel.Counties.firstObject.Towns;
            weakSelf.townModel = weakSelf.townList.firstObject;
            weakSelf.villageList = ((CLTownsModel *)weakSelf.townList.firstObject).Villages;
            self.townLabel.text = weakSelf.townModel.TownName;
        }
        [self.view hideBusyHUD];
        
    }];
    
    
    [CLXiShiTangNetanager getXiShiTangInfoWithID:@"1" CompletionHandler:^(CLVillageModel *model, NSError *error) {
        weakSelf.villageModel = model;
        self.villageLabel.text = model.Name;
        [_mapBottomView setValueForVillageModel:weakSelf.villageModel];
    }];
    [self createRightBtn];
    
#pragma mark -- 第七行
    UILabel *linkmanLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*SWIDTH_SCALE, 450*SHEIGHT_DCALE, 80*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    [self.view addSubview:linkmanLabel];
    linkmanLabel.font = [UIFont systemFontOfSize:15];
    linkmanLabel.text = @"收货人:";
    
    self.linkmanField = [[UITextField alloc]initWithFrame:CGRectMake(150*SWIDTH_SCALE, 450*SHEIGHT_DCALE, KWIDTH - 150*SWIDTH_SCALE - 10 , 30*SHEIGHT_DCALE)];
    self.linkmanField.placeholder = @"请输入姓名";
    self.linkmanField.delegate = self;
    self.linkmanField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.linkmanField];
    
    UILabel *linkTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*SWIDTH_SCALE, 500*SHEIGHT_DCALE, 80*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    linkTelLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:linkTelLabel];
    linkTelLabel.text = @"联系电话:";
    [self.view addSubview:linkTelLabel];
    
    self.linkTelField = [[UITextField alloc]initWithFrame:CGRectMake(150*SWIDTH_SCALE, 500*SHEIGHT_DCALE, KWIDTH - 150*SWIDTH_SCALE - 10 , 30*SHEIGHT_DCALE)];
    self.linkTelField.font = [UIFont systemFontOfSize:15];
    self.linkTelField.placeholder = @"请输入联系电话";
    self.linkTelField.delegate = self;
    [self.view addSubview:self.linkTelField];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(100*SWIDTH_SCALE, 570*SHEIGHT_DCALE, KWIDTH - 200*SWIDTH_SCALE, 40*SHEIGHT_DCALE)];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitle:@"设为收货地址" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundColor:ZXColor(60, 170, 40, 1)];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//返回首页和订单的下拉框
- (void)createRightBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"50x40_02"] forState:UIControlStateNormal];
    if (SH<=568) {
        btn.frame = CGRectMake(245, 10, 40, 30);
    }else if (SH>568){
        btn.frame = CGRectMake(320, 10, 40, 30);
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.tintColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.bb = btn;
}
-(void)clickA
{
    //@property (strong, nonatomic) DropdownMenu *Menu ;
    //@property (strong, nonatomic)UIButton *bb;
    //MessageControllerDelegeta
//    _Menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 40*2+10;
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
#pragma mark ---- 区域点击事件
-(void)confirmBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if ([_linkmanField.text isEqualToString:@""]||[_linkTelField.text isEqualToString:@""]) {
        [UIViewController showMessage:@"信息不能为空" ViewController:self];
        return;
    }
    
    //判断手机格式
    if (![_linkTelField.text verityTelepone]) {
        [UIViewController showMessage:@"手机格式不正确" ViewController:self];
        return;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(?:[\u4e00-\u9fa5|a-zA-Z])+?$" options:0 error:nil];
    
    NSTextCheckingResult *result2 = [regex firstMatchInString:_linkmanField.text options:0 range:NSMakeRange(0, _linkmanField.text.length)];
    
    if (!result2) {
        [UIViewController showMessage:@"姓名格式错误" ViewController:self];
        return;
    }
    NSString *countyID = nil;
    if ([self.districtBtn.titleLabel.text isEqualToString:@"鄞州区"]) {
        countyID = @"6";
    }
    else if ([self.districtBtn.titleLabel.text isEqualToString:@"北仑区"]) {
        countyID = @"4";
    }
    else if ([self.districtBtn.titleLabel.text isEqualToString:@"奉化市"]) {
        countyID = @"9";
    }
    [CLXiShiTangNetanager setXiShiTangAddressWithRecvTel:_linkTelField.text RecvName:_linkmanField.text CountyID:countyID Details:[NSString stringWithFormat:@"%@%@喜事堂",self.townLabel.text,self.villageLabel.text] CompletionHandler:^(NSString *result, NSError *error) {
        [self.view showWarning:result];
        self.linkTelField.text = @"";
        self.linkmanField.text = @"";
    }];
    
}

-(void)pushDistrictView:(UIButton *)sender
{
    WK(weakSelf)
    DistrictAlertViewController *vc = [[DistrictAlertViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(100*SWIDTH_SCALE, 230) Array:self.xiShiTangModel.Counties];

    vc.chooseBlock = ^(CLCitiesModel *citiesModel){
        weakSelf.townList = citiesModel.Towns;
        weakSelf.townModel = weakSelf.townList.firstObject;
        weakSelf.villageList = ((CLTownsModel *)weakSelf.townList.firstObject).Villages;
        [sender setTitle:citiesModel.CountyName forState:UIControlStateNormal];
        ((UILabel *)[weakSelf.view viewWithTag:50]).text = citiesModel.Towns.firstObject.TownName;
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = citiesModel.Towns.firstObject.Villages.firstObject.Name;
        CLVillageModel *villageModel = weakSelf.villageList.firstObject;
        [CLXiShiTangNetanager getXiShiTangInfoWithID:villageModel.HallID CompletionHandler:^(CLVillageModel *model, NSError *error) {
            weakSelf.villageModel = model;
            [_mapBottomView setValueForVillageModel:weakSelf.villageModel];
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)pushTownView
{
    WK(weakSelf)
    TownViewController *vc = [[TownViewController alloc] initWithSourceView:[self.view viewWithTag:49] sourceRect:[self.view viewWithTag:49].bounds contentSize:CGSizeMake(130*SWIDTH_SCALE, 230) Array:self.townList];
    vc.chooseBlock = ^(CLTownsModel *townModel){
        weakSelf.townModel = townModel;
        ((UILabel *)[weakSelf.view viewWithTag:50]).text = townModel.TownName;
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = townModel.Villages.firstObject.Name;
        weakSelf.villageList = townModel.Villages;
        CLVillageModel *villageModel = weakSelf.villageList.firstObject;
        [CLXiShiTangNetanager getXiShiTangInfoWithID:villageModel.HallID CompletionHandler:^(CLVillageModel *model, NSError *error) {
            weakSelf.villageModel = model;
            [_mapBottomView setValueForVillageModel:weakSelf.villageModel];
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)pushVillageView
{
    WK(weakSelf)
    VillageViewController *vc = [[VillageViewController alloc] initWithSourceView:[self.view viewWithTag:48] sourceRect:[self.view viewWithTag:48].bounds contentSize:CGSizeMake(250*SWIDTH_SCALE , 230) Array:self.villageList];
    vc.chooseBlock = ^(CLVillageModel *villageModel){
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = villageModel.Name;
        [CLXiShiTangNetanager getXiShiTangInfoWithID:villageModel.HallID CompletionHandler:^(CLVillageModel *model, NSError *error) {
            weakSelf.villageModel = model;
            [_mapBottomView setValueForVillageModel:weakSelf.villageModel];
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark ---- 喜事堂点击事件
- (void)xishiClick:(UIButton *)sender
{
    WK(weakSelf)
    CLMapViewController *mapVC = [[CLMapViewController alloc]init];
    mapVC.currentLongitude = [self.villageModel.Longitude doubleValue];
    mapVC.currentLatitude = [self.villageModel.Latitude doubleValue];
    mapVC.townID = self.townModel.TownID;
    mapVC.villageModel = self.villageModel;
    mapVC.completionHandler = ^(CLVillageModel *villageModel){
        [_mapBottomView setValueForVillageModel:villageModel];
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = villageModel.Name;
        weakSelf.villageModel = villageModel;
    };
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark -- 预定点击事件
-(void)ButtonClick:(UIButton *)sender
{
    WK(weakSelf)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"预定成功" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:alertAction];
    
}

#pragma mark --- 喜宴日期
-(void)riqiClick:(UIButton *)sender
{
//    WK(weakSelf)
    CLCalendarViewController *cvc = [[CLCalendarViewController alloc]init];
//    CalendarViewController *cvc= [[CalendarViewController alloc]initWithNibName:@"CalendarViewController" bundle:nil];
    cvc.isFromOther = NO;
    cvc.villagemodel = self.villageModel;
//    cvc.PushData = ^(NSString *date){
//        weakSelf.day.text = date;
//    };
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark-------菜单栏tableview的数据源和代理方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat rects = 216 - (KHEIGHT - 530*SHEIGHT_DCALE - 64);
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.linkTelField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    return YES;
}


@end
