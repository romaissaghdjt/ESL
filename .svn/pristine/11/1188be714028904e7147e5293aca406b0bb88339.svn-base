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
@interface XHXiShiTangController ()
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
    ///    [self.view showBusyHUD];
    self.navigationController.navigationBar.hidden = NO;
//    [CLXiShiTangNetanager getAllDistrictDateWithCompletionHandler:^(XiShiTangModel *xiShiTangModel, NSError *error) {
//        if (error) {
//            [UIViewController showMessage:@"网络错误" ViewController:self];
//        }
//        else
//        {
//            weakSelf.xiShiTangModel = xiShiTangModel;
//            weakSelf.areaArray = weakSelf.xiShiTangModel.cities;
//            weakSelf.townList = weakSelf.xiShiTangModel.cities.firstObject.Towns;
//            weakSelf.townModel = weakSelf.townList.firstObject;
//            weakSelf.villageList = ((CLTownsModel *)weakSelf.townList.firstObject).Names; 
//        }
//        [self.view hideBusyHUD];
//       
//    }];
//    
//    
//    [CLXiShiTangNetanager getXiShiTangInfoWithID:@"1" CompletionHandler:^(CLVillageModel *model, NSError *error) {
//        weakSelf.villageModel = model;
//        [_mapBottomView setValueForVillageModel:weakSelf.villageModel];
//    }];  
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    self.title = @"喜事堂";
    self.tabBarController.tabBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark --  第一行
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 160*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    label.text = @"请选择所在区域：";
    //   label. backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    
    UIButton *districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    districtBtn.frame = CGRectMake(165*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 90*SWIDTH_SCALE, 30*SHEIGHT_DCALE);
    [districtBtn setTitle:@"鄞州区" forState:UIControlStateNormal];
    [districtBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [districtBtn addTarget:self action:@selector(pushDistrictView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    districtBtn.layer.cornerRadius = 5;
    districtBtn.layer.masksToBounds = YES;
    districtBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    districtBtn.layer.borderWidth = 1;
    [self.view addSubview:districtBtn];
    [districtBtn setImage:[UIImage imageNamed:@"drop_down.png"] forState:UIControlStateNormal];
    districtBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    districtBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -50);
    districtBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    
    UIView *townView = [[UIView alloc]initWithFrame:CGRectMake(260*SWIDTH_SCALE, 100*SHEIGHT_DCALE, 105*SWIDTH_SCALE, 30*SHEIGHT_DCALE)];
    townView.layer.cornerRadius = 5;
    townView.layer.masksToBounds = YES;
    townView.layer.borderColor = [[UIColor grayColor] CGColor];
    townView.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushTownView)];
    [townView addGestureRecognizer:tap];
    townView.tag = 49;
    
    
    UILabel *townLabel = [[UILabel alloc]init];
    townLabel.frame = CGRectMake(0*SWIDTH_SCALE, 5*SHEIGHT_DCALE, 80*SWIDTH_SCALE, 20*SHEIGHT_DCALE);
    
    townLabel.text = @"咸祥镇";
    townLabel.font = [UIFont systemFontOfSize:16];
    townLabel.textColor = [UIColor blueColor];
    [townView addSubview:townLabel];
    townLabel.tag = 50;
    townLabel.textAlignment = NSTextAlignmentCenter;
    
    
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
    
    UILabel *villageLabel = [[UILabel alloc]init];
    villageLabel.frame = CGRectMake(0, 5*SHEIGHT_DCALE, 165*SWIDTH_SCALE, 20*SHEIGHT_DCALE);
    villageLabel.textColor = [UIColor blueColor];
    villageLabel.text = @"南头村";
    villageLabel.font = [UIFont systemFontOfSize:15];
    villageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:villageView];
    
    [villageView addSubview:villageLabel];
    villageLabel.tag = 51;
    
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
    [self createRightBtn];
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
-(void)confirmBtnClick
{
    self.confirmBlock(self.villageModel);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushDistrictView:(UIButton *)sender
{
    WK(weakSelf)
    DistrictAlertViewController *vc = [[DistrictAlertViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(100*SWIDTH_SCALE, 230) Array:self.xiShiTangModel.cities];

    vc.chooseBlock = ^(CLCitiesModel *citiesModel){
        weakSelf.townList = citiesModel.Towns;
        weakSelf.townModel = weakSelf.townList.firstObject;
        weakSelf.villageList = ((CLTownsModel *)weakSelf.townList.firstObject).Names;
        [sender setTitle:citiesModel.CountyName forState:UIControlStateNormal];
        ((UILabel *)[weakSelf.view viewWithTag:50]).text = citiesModel.Towns.firstObject.TownName;
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = citiesModel.Towns.firstObject.Names.firstObject.Name;
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
        ((UILabel *)[weakSelf.view viewWithTag:51]).text = townModel.Names.firstObject.Name;
        weakSelf.villageList = townModel.Names;
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


@end
