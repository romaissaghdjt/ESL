//
//  CarCompanyViewController.m
//  YY
//
//  Created by 陈龙 on 16/5/31.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CarCompanyViewController.h"
#import "LicenseCell.h"
#import "LoginViewController.h"
@interface CarCompanyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *leftTableView;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UIView *changeView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation CarCompanyViewController

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.dict[@"Name"]);
    self.title = @"车队展示";
    [self createleftTableView];
    UIButton *bookBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT- 50, KWIDTH, 50)];
    [bookBtn setBackgroundImage:[UIImage imageNamed:@"jiaru.png"] forState:UIControlStateNormal];
    [bookBtn addTarget:self action:@selector(bookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookBtn];
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
-(void)bookBtnClick:(UIButton *)sender
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
        presentationLabel.text = @"预租提示";
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

-(void)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://400-8216-707"]];
}
-(void)callCancel:(UIButton *)sender
{
    self.changeView.hidden = YES;
    self.hiddenView.hidden = YES;
}

- (void)createleftTableView{
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-10) style:(UITableViewStyleGrouped)];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = NO;
    _leftTableView.backgroundColor = [UIColor whiteColor];
    _leftTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_leftTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ((NSArray *)self.dict[@"Url"]).count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *rightCell = @"CarCell";
    LicenseCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell];
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"LicenseCell" owner:nil options:nil].firstObject;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.img.layer.cornerRadius = 10;
    cell.img.layer.masksToBounds = YES;

    [cell.img sd_setImageWithURL:[NSURL URLWithString:self.dict[@"Url"][indexPath.section]]];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        //        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 15, 2, 24)];
        //line.backgroundColor = [UIColor orangeColor];
        
        UILabel *Dlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KWIDTH, 44)];
        Dlable.text = self.dict[@"Name"];
        Dlable.font = [UIFont systemFontOfSize:18];
        //[Dlable addSubview:line];
        return Dlable;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else
    {
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        return 5;
    }
}@end
