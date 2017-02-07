//
//  ToJoinCookChooseController.m
//  YY
//
//  Created by 赵洁 on 16/7/13.
//  Copyright © 2016年 徐恒. All rights reserved.
//厨师加盟

#import "ToJoinCookChooseController.h"
#import "ToJoinCookController.h"
#import "CLCalendarViewController.h"
#import "ContractController.h"
#import "CookToJoinModel.h"
#import "ToJionInModel.h"
#import "XHTabBarController.h"
#import "LoginViewController.h"
//#import "UITextField+YBInputType.h"
#import "TextFilter.h"
#import "CookToJoinModel.h"

@interface ToJoinCookChooseController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,TextFilterDelegate,LoginViewControllerDelegate>
@property (nonatomic, strong) TextFilter *filterCH;

@property (strong, nonatomic) IBOutlet UIButton *JDButton;
@property (strong, nonatomic) IBOutlet UIButton *DuoXuanButton;
@property (strong, nonatomic) IBOutlet UIButton *QuButton;
@property (strong, nonatomic) IBOutlet UIButton *TuanDuiButton;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *ApplyTime;//申请时间
@property (weak, nonatomic) IBOutlet UITextField *SQtimeTF;
//@property (strong, nonatomic) IBOutlet UILabel *SQtimeLable;
@property (strong, nonatomic) IBOutlet UIButton *dayButton;
@property (strong, nonatomic) IBOutlet UIView *TuanDView;
@property (strong, nonatomic) IBOutlet UILabel *TuanDOrGLable;
@property (strong, nonatomic) IBOutlet UIView *QuView;
@property (strong, nonatomic) IBOutlet UILabel *QuLable;
@property (strong, nonatomic) IBOutlet UITextField *NameTextF;
@property (strong, nonatomic) IBOutlet UITextField *PhoneTextF;
@property (strong, nonatomic) IBOutlet UIView *CXView;
@property (strong, nonatomic) IBOutlet UILabel *CXLable;
@property (strong, nonatomic) IBOutlet UIView *JDView;
@property (strong, nonatomic) IBOutlet UILabel *JDNumberLable;
@property (strong, nonatomic) IBOutlet UIButton *NextButton;//下一个

@property (nonatomic, strong)UIButton*DuoXbutton;
@property (nonatomic,strong)NSMutableArray*arr;//多选
@property (nonatomic,strong)NSMutableArray*IDArr;//菜系ID
@property (nonatomic, strong)NSMutableArray*statusarray;//cell状态
@property (strong, nonatomic) UIImageView *dropdownMenu;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *areaArray;
@property (strong, nonatomic) NSMutableArray *Array;
@property(strong , nonatomic)UITextField*textField;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) IBOutlet UIButton *chooseButton;
@property (assign, nonatomic) NSInteger a;//子列表当前选中的行
@property (strong, nonatomic) IBOutlet UIButton *ToJoinContract;//厨师协议
@property (nonatomic, assign) NSInteger i;
@property (nonatomic,strong)NSString*ID;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation ToJoinCookChooseController
- (NSMutableArray *)statusarray{
    if (!_statusarray) {
        _statusarray = [NSMutableArray array];
    }
    return _statusarray;
}
- (NSMutableArray *)IDArr{
    if (!_IDArr) {
        _IDArr = [NSMutableArray array];
    }
    return _IDArr;
}
- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (NSMutableArray *)Array
{
    if (!_Array) {
        _Array = [NSMutableArray array];
    }
    return _Array;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    //[super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    

    // 判断是否登录过
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
       
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    else
    {
        
        self.PhoneTextF.text = us;
        self.PhoneTextF.enabled = NO;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chanage) name:@"TY" object:nil];
}
//登陆返回代理
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)chanage
{
    [_chooseButton setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
    _chooseButton.selected = YES;
    self.NextButton.enabled = YES;
    self.NextButton.backgroundColor = ZXColor(4, 140, 0, 1);

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.dayButton.hidden = YES;
    self.title = @"我要加盟";
    self.count = 0;
    self.i = 0;
    self.a = 0;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    self.SQtimeTF.text = [formatter stringFromDate:date];//
//    self.SQtimeTF.enabled = NO;
    self.statusarray = [NSMutableArray array];
    self.TuanDuiButton.tag = 100;
    self.QuButton.tag = 101;
    self.DuoXuanButton.tag = 102;
    self.TuanDView.layer.cornerRadius = 6;
    self.QuView.layer.cornerRadius = 6;
    self.CXView.layer.cornerRadius = 6;
    self.JDView.layer.cornerRadius = 6;
    self.tabBarController.tabBar.hidden = YES;
//    [_chooseButton
//     setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
    self.NextButton.layer.cornerRadius = 8;
    self.NextButton.layer.masksToBounds = YES;
    self.NextButton.enabled = NO;
    self.NextButton.backgroundColor = ZXColor(99, 172, 66, 1);
    self.TuanDOrGLable.text = @"个人";
//    self.ApplyTime.text =@"出生年月";
    self.QuLable.text = @"鄞州区";
    self.JDNumberLable.text = @"5桌";
    _filterCH = [[TextFilter alloc]init];
    [_filterCH SetFilter:_NameTextF
                delegate:self
                maxCHLen:30
                allowNum:NO
                 allowCH:YES
             allowLetter:YES
             allowLETTER:YES
             allowSymbol:YES
             allowOthers:@"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～"];
    
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
#define 日历
- (IBAction)dayClick:(id)sender {
    [self.dropdownMenu removeFromSuperview];
    WK(weakSelf)
    CLCalendarViewController *cvc= [[CLCalendarViewController alloc]init];
    cvc.isFromOther = YES;
    cvc.isFromJoin = YES;
    cvc.PushData = ^(NSString *date){
        weakSelf.SQtimeTF.text = date;////
    };
    [self.navigationController pushViewController:cvc animated:YES];
}
#define 选择团队或个人
- (IBAction)ChooseTDClick:(id)sender {
//    self.TuanDuiButton.enabled = NO;
//    self.DuoXuanButton.enabled = NO;
//    self.QuButton.enabled = NO;
//    self.JDButton.enabled = NO;
//    [_textField resignFirstResponder];
//
//    self.DuoXuanButton.backgroundColor= [UIColor lightGrayColor];
//    self.JDButton.enabled = YES;
////    self.dropdownMenu = [[UIImageView alloc]init];
////    self.dropdownMenu.userInteractionEnabled = YES;//开启交互功能
////    self.dropdownMenu.image = [UIImage imageNamed:@"喜事堂_03(2).png"];
////    self.dropdownMenu.frame = CGRectMake(150*SWIDTH_SCALE,self.TuanDView.frame.origin.y+95, 130*SWIDTH_SCALE, 150*SHEIGHT_DCALE);
////    self.dropdownMenu.backgroundColor = [UIColor whiteColor];
////    self.dropdownMenu.layer.cornerRadius= 15;
////    self.dropdownMenu.layer.masksToBounds = YES;
////    self.dropdownMenu.layer.borderWidth = 2;
////    self.dropdownMenu.layer.borderColor = [UIColor grayColor].CGColor;
////    
////    [self.view addSubview:self.dropdownMenu];
////    
////    [self addbtn];
//    self.DuoXbutton.hidden = YES;
}
#define 选择范围
- (IBAction)ChooseQuClick:(id)sender {
    [_textField resignFirstResponder];

    _i = 0;
    self.TuanDuiButton.enabled = NO;
    self.QuButton.enabled = NO;
    self.JDButton.enabled = NO;
    self.areaArray = [NSMutableArray array];
    [self request: [PREURL stringByAppendingPathComponent:@"Other.ashx?Function=GetAllCounty"] str:@"区"];
    [self creatView:@"其他" view:_QuView];
    self.DuoXbutton.hidden = YES;
}
#define 选择菜系
- (IBAction)ChooseCXClick:(id)sender {
    [_textField resignFirstResponder];
   
    _i = 1;
    self.QuButton.enabled = NO;
    self.DuoXuanButton.enabled = NO;
    [_textField resignFirstResponder];
    self.TuanDuiButton.enabled = NO;
    self.areaArray = [NSMutableArray array];
    [self request:[PREURL stringByAppendingString: @"Other.ashx?Function=HttpQueryCuisine"] str:@"series"];
    
    self.dropdownMenu = [[UIImageView alloc]init];
    self.dropdownMenu.userInteractionEnabled = YES;//开启交互功能
    self.dropdownMenu.image = [UIImage imageNamed:@"喜事堂_03(2).png"];
    self.dropdownMenu.frame = CGRectMake(0,0, KWIDTH,KHEIGHT);
    self.dropdownMenu.backgroundColor = [UIColor whiteColor];
    
    self.DuoXbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT-50, KWIDTH, 50)];
    [self.DuoXbutton setTitle:@"确定" forState:(UIControlStateNormal)];
    self.DuoXbutton.backgroundColor = ZXColor(80, 172, 66, 1);
    [self.DuoXbutton addTarget:self action:@selector(DuoXbutton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 64, KWIDTH, KHEIGHT-100);
    [self.dropdownMenu addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    self.tableView = tableView;
    [self.dropdownMenu addSubview: self.DuoXbutton];
    [self.view addSubview:self.dropdownMenu];
}
#define 接单能力
- (IBAction)JDClick:(id)sender {
    [_textField resignFirstResponder];

    _i =2;
    self.DuoXuanButton.enabled = NO;
    self.JDButton.enabled = NO;
    self.QuButton.enabled = NO;
    self.TuanDuiButton.enabled = NO;
    [self.dropdownMenu removeFromSuperview];
    self.areaArray = [NSMutableArray array];
    NSString*url =[PREURL stringByAppendingString: @"ServerManager.ashx?ServerModule=CookServer&Function=HttpQueryRecvNums"];
    //NSLog(@"%@",url);
    [self request:url str:@"接单能力"];
    [self creatView:@"其他" view:_JDView];
    self.DuoXbutton.hidden = YES;

}
- (IBAction)NextClick:(id)sender {
    if ([self.TuanDOrGLable.text isEqualToString:@""]) {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([self.QuLable.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([self.NameTextF.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([self.CXLable.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([self.JDNumberLable.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([self.SQtimeTF.text isEqualToString:@""])
    {
        [self showMessage:@"时间信息不完整"];
        return;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9\\u4e00-\\u9fa5]+$" options:0 error:nil];
    
    NSTextCheckingResult *result2 = [regex firstMatchInString:self.NameTextF.text options:0 range:NSMakeRange(0, self.NameTextF.text.length)];
    
    if (!result2) {
        [self showMessage:@"负责人名称不能含有特殊符号"];
        return;
    }
   
    ToJoinCookController*ToJoinVC = [[ToJoinCookController alloc]init];
    
    ToJoinVC.SetUpDt = self.SQtimeTF.text;///
//    ToJoinVC.str = @"";
    ToJoinVC.Fanwei = [NSString stringWithFormat:@"[%@]",self.QuLable.text];
    ToJoinVC.name = self.NameTextF.text;
    ToJoinVC.tel = self.PhoneTextF.text;
    NSString*str = @"";
    for (int i = 0; i < _IDArr.count; i++) {
        
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",_IDArr[i]]];
    }
    NSString*ss = [NSString stringWithFormat:@"[%@]",[str substringToIndex:str.length-1]];
    ToJoinVC.caiXI = ss;
    ToJoinVC.power = [self.JDNumberLable.text stringByReplacingOccurrencesOfString:@"桌" withString:@""];
    
    [self.navigationController pushViewController:ToJoinVC animated:YES];
}
#define 勾选
- (IBAction)ChooseGXClick:(id)sender {
    //_chooseButton.selected = !_chooseButton.selected;
    if (_chooseButton.selected == YES) {
        [_chooseButton
         setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
        _chooseButton.selected = NO;
        self.NextButton.enabled = NO;
        self.NextButton.backgroundColor = ZXColor(99, 172, 66, 1);

        return;
    }
        if (_count %2 != 0) {
        
        [_chooseButton
         setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
        self.NextButton.enabled = NO;
            self.NextButton.backgroundColor = ZXColor(99, 172, 66, 1);

    }else
    {
        
        [_chooseButton setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
        self.NextButton.enabled = YES;
        self.NextButton.backgroundColor = ZXColor(4, 140, 0, 1);
        
    }
    _count++;
    
}
- (void)request:(NSString*)url str:(NSString*)str
{
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        [self JsonPrea:data str:str];
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)JsonPrea:(NSData*)data str:(NSString*)str
{
    if ([str isEqualToString:@"区"]) {
         NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        for (NSDictionary*dic in array) {
            NSArray*ar = dic[@"Data"];
            for (NSDictionary*dics in ar) {
                NSArray*arra = dics[@"Data"];
                for (NSDictionary*dica in arra) {
                    ToJionInModel*model = [[ToJionInModel alloc]init];
                    [model setValuesForKeysWithDictionary:dica];
                    [self.areaArray addObject:model];
                }
            }
        }
        [self.tableView reloadData];

        
    }else if ([str isEqualToString:@"series"])
    {
        NSArray*array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        for (NSDictionary*dic in array) {
            ToJionInModel*model= [[ToJionInModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.areaArray  addObject: model];

        }
        
        [self.tableView reloadData];
    }else
    {
        NSDictionary*dic =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray*arr = dic[@"接单能力"];
        for (NSDictionary*disc in arr) {
            ToJionInModel*model = [[ToJionInModel alloc]init];
            [model setValuesForKeysWithDictionary:disc];
            [self.areaArray addObject:model];
        }
        [self.tableView reloadData];
    }
    
}
- (void)creatView:(NSString*)str view:(UIView*)view
{
    self.dropdownMenu = [[UIImageView alloc]init];
    self.dropdownMenu.userInteractionEnabled = YES;//开启交互功能
    self.dropdownMenu.image = [UIImage imageNamed:@"喜事堂_03(2).png"];
    self.dropdownMenu.frame = CGRectMake(100*SWIDTH_SCALE,view.frame.origin.y+45, 260*SWIDTH_SCALE, 200*SHEIGHT_DCALE);
    self.dropdownMenu.backgroundColor = [UIColor whiteColor];
    self.dropdownMenu.layer.cornerRadius= 15;
    self.dropdownMenu.layer.masksToBounds = YES;
    self.dropdownMenu.layer.borderWidth = 2;
    self.dropdownMenu.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.view addSubview:self.dropdownMenu];
    
    if ([str isEqualToString:@"其他"])
    {
        [self addTableView];
    }else
    {
        [self addbtn];
    }
    
    
}
- (void)DuoXbutton:(UIButton*)bnt

{
    [_textField resignFirstResponder];

    self.QuButton.enabled = YES;
    self.TuanDuiButton.enabled = YES;
    self.DuoXuanButton.enabled = YES;
    NSString*str  = @"";
    for (int i = 0; i < _arr.count; i++) {
        str= [NSString stringWithFormat:@" %@,",[str stringByAppendingString:_arr[i]]];
        ;
        
    }
    self.CXLable.text = str;
    [self.dropdownMenu removeFromSuperview];
    [self.arr removeAllObjects];
    //取消状态
    [_statusarray removeAllObjects];
    
}
- (void)addTableView
{
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 0, 260*SWIDTH_SCALE, 200*SHEIGHT_DCALE);
    [self.dropdownMenu addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 67;
    self.tableView = tableView;
}
- (void)addbtn
{
//    //UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, 9,self.dropdownMenu.width, 1)];
//    line0.backgroundColor = [UIColor lightGrayColor];
//    [self.dropdownMenu addSubview:line0];
    UIButton *b1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, self.dropdownMenu.width, 50)];
    [b1 setTitle:@"个人" forState:(UIControlStateNormal)];
    b1.backgroundColor = [UIColor whiteColor];
    [b1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.dropdownMenu addSubview:b1];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, b1.bottom,b1.width, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.dropdownMenu addSubview:line];
    UIButton *b2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 71, self.dropdownMenu.width, 50)];
    [b2 setTitle:@"团队" forState:(UIControlStateNormal)];
    b2.backgroundColor = [UIColor whiteColor];
    [b2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, b2.bottom,b1.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.dropdownMenu addSubview:line1];
    [self.dropdownMenu addSubview:b2];
    [b2 addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];
    [b1 addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)bb:(UIButton*)sender
{
    [_textField resignFirstResponder];

    self.TuanDuiButton.enabled = YES;
    self.QuButton.enabled = YES;
    self.DuoXuanButton.enabled = YES;
    self.DuoXuanButton.backgroundColor = [UIColor grayColor];
    self.JDButton.enabled = YES;
    self.str = sender.titleLabel.text;
    self.TuanDOrGLable.text = self.str;
    if ([self.TuanDOrGLable.text isEqualToString:@"个人"]) {
        self.ApplyTime.text = @"出生年月";
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy/MM/dd";
        self.SQtimeTF.text = [formatter stringFromDate:date];
    }else
    {
        self.ApplyTime.text = @"创办时间";
        self.SQtimeTF.text = @"";
        self.SQtimeTF.placeholder = @"请选择创办时间";
    }
    [self.dropdownMenu removeFromSuperview];
}

#pragma 加盟合同点击事件
- (IBAction)ToJoinButtonClick:(id)sender {
    
    ContractController *contractVC = [[ContractController alloc]init];
    contractVC.titles = self.ToJoinContract.titleLabel.text;
    [self.navigationController pushViewController:contractVC animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.areaArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    if (_i == 0) {
        ToJionInModel*model = self.areaArray[indexPath.row];
        cell.textLabel.text = model.Name;
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
    }else if(_i == 1)
    {
        //ToJionInModel*model = self.areaArray[indexPath.row];
        if ([_statusarray containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ToJionInModel*model = self.areaArray[indexPath.row];

        cell.textLabel.text = model.Name;
        
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
    }else{
        ToJionInModel*model = self.areaArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@桌",model.Name];
        
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_i == 0) {
         self.QuButton.enabled = YES;
         self.TuanDuiButton.enabled = YES;
         self.JDButton.enabled = YES;
         ToJionInModel*model = self.areaArray[indexPath.row];
         self.QuLable.text = model.Name;
         [self.dropdownMenu removeFromSuperview];
    }else if(_i == 1){
        
         NSString*  selectRow  = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
         //判断数组中有没有被选中行的行号,
        ToJionInModel*model =self.areaArray[indexPath.row];
         if ([_statusarray containsObject:selectRow]) {
            [_statusarray removeObject:selectRow];
            [self.arr removeObject:model.Name];
            [self.IDArr removeObject:model.ID];
            
         }else{
            [_statusarray addObject:selectRow];
             [self.arr addObject:model.Name];
             [self.IDArr addObject:model.Name];
         }
         [tableView reloadData];
 
    }else{
           self.JDButton.enabled = YES;

           self.DuoXuanButton.enabled = YES;
           self.QuButton.enabled = YES;
           self.TuanDuiButton.enabled = YES;
           ToJionInModel*model = self.areaArray[indexPath.row];
           self.str = [NSString stringWithFormat:@"%@桌",model.Name];
           self.ID = model.ID;
           self.JDNumberLable.text = self.str;
           [self.dropdownMenu removeFromSuperview];
    }
    
}

#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //实例变量存储当前操作的输入框对象
   
    _textField = textField;
    [self.dropdownMenu removeFromSuperview];
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +400);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    
    return YES;
    
}
/***
 记住上一次输入的
 
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([_NameTextF.text length] > 10) {
//        _NameTextF.text = [textField.text substringToIndex:6];
//        //[self showMessage:@"超出限制"];
//        return ;
//    }
    if ([textField isEqual:self.PhoneTextF]) {
        [[NSUserDefaults standardUserDefaults]setObject:textField.text forKey:@"PH"];
    }
    
}
//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +400);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 64;
            self.view.frame = frame;
        }];
    }
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.DuoXuanButton.enabled = YES;
    self.QuButton.enabled = YES;
    self.TuanDuiButton.enabled = YES;
    self.JDButton.enabled = YES;

    [self.dropdownMenu removeFromSuperview];
    [_textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +400);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 64;
            self.view.frame = frame;
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.NameTextF == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            //[self showMessage:@"号码只有十一位"];
            return NO;
        }
    }
    
        return YES;
}

- (void)showLoginMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"登录" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
        //RegisterViewController
        [self presentViewController:navVC animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回首页" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.view.window.rootViewController = [[XHTabBarController alloc]init];
    }];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
}

@end
