//
//  TablewareController.m
//  YY
//
//  Created by 徐恒 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "TablewareController.h"
#import "TablewareRightCell.h"
#import "ClassificationModel.h"
//#import "ReserveViewController.h"
#import "LoginViewController.h"
#define kCONENTWIDTH  [UIScreen mainScreen].bounds.size.width / 3
#import "EMLBottmView.h"
//#define url @"http://emm.nbeykj.com/ashx/KitchenHandler.ashx?Action=getMune&id=1"//餐具

@interface TablewareController ()<UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
{
    NSInteger tag1;
}
@property (strong, nonatomic)UIView  *headerView;//顶部 View
@property (strong, nonatomic)UITableView *leftTabView;
@property (strong, nonatomic)UITableView *currentTabView;
@property (strong, nonatomic)UITableView *rightTabView;
@property (nonatomic, strong)NSMutableArray *leftArray;
@property (nonatomic, strong)NSMutableArray *currentArray;
@property (nonatomic, strong)NSMutableArray *rightArray;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (strong, nonatomic)UILabel *priceLabel;
@property (assign, nonatomic)NSInteger aa;
 @property (strong, nonatomic)UIButton *btn;
 @property (strong, nonatomic)EMLBottmView *bottmView;
//@property (strong, nonatomic) DropdownMenu *menu ;
@property (strong, nonatomic)UIButton *btn1;
@property (strong,nonatomic)NSString*price;
@property (nonatomic,assign)NSInteger a;
@property (nonatomic,strong)NSString*startCount;
@end

@implementation TablewareController
#pragma mark == 懒加载
-(NSMutableArray *)currentArray
{
    if (!_currentArray) {
        _currentArray = [NSMutableArray array];
    }
    return _currentArray;
}
-(NSMutableArray *)leftArray
{
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}
-(NSMutableArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}
-(UITableView *)leftTabView
{
    if (!_leftTabView) {
        _leftTabView = [[UITableView alloc]init];
    }
    return _leftTabView;
}
-(UITableView *)currentTabView
{
    if (!_currentTabView) {
        _currentTabView = [[UITableView alloc]init];
    }
    return _currentTabView;
}
-(UITableView *)rightTabView
{
    if (!_rightTabView) {
        _rightTabView = [[UITableView alloc]init];
    }
    return _rightTabView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.aa = 1;
    _a = 1;
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"餐具套餐";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    tag1 = 1003;
    
    [self requeatstartNum:@"3"];
    [self requeatstartNum:@"4"];
    [self requeatstartNum:@"5"];
    [self createHeaderView];
    [self createRightTableView];
    [self createDownView];
    [self createRightBtn];
    [self CreatbottmView];
    
    self.startCount = @"3";


}
- (void)CreatbottmView
{
    _bottmView = [[NSBundle mainBundle]loadNibNamed:@"EMLBottmView" owner:nil options:nil].lastObject;
    _bottmView.backgroundColor = ZXColor(210, 210, 210, 1);
    _bottmView.frame = CGRectMake(0, self.view.height-50, KWIDTH, 50);
    self.bottmView.PlusBnt.layer.borderWidth= 1;
    _bottmView.PlusBnt.layer.borderColor = ZXColor(198, 198, 198, 0.8).CGColor;
    _bottmView.MiunBnt.layer.borderWidth= 1;
    _bottmView.MiunBnt.layer.borderColor = ZXColor(198, 198, 198, 0.8).CGColor;
    _bottmView.Countlable.layer.borderWidth= 1;
    _bottmView.Countlable.layer.borderColor = ZXColor(198, 198, 198, 0.8).CGColor;
    [_bottmView.PlusBnt addTarget:self action:@selector(plus) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottmView.MiunBnt addTarget:self action:@selector(minus) forControlEvents:(UIControlEventTouchUpInside)];
    ;
    _bottmView.Countlable.text = @"1";
    [self.bottmView.JoinToOrdeBnt addTarget:self action:@selector(JoinToOrdeBnt) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_bottmView];
    
}
- (void)plus
{
    
    _a = _a+1;
    _bottmView.Countlable.text = [NSString stringWithFormat:@"%ld",(long)_a] ;
    
}
- (void)minus
{
    if (_a == 1) {
        return;
    }
    _a = _a-1;
    NSInteger s = 0;
    s = _a;
    _bottmView.Countlable.text = [NSString stringWithFormat:@"%ld",(long)s] ;
    
    
}
- (void)JoinToOrdeBnt
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=CoverBorrow&Function=HttpMoveToShoppingCart&UserTel=%@&UserPhyAdd=%@&ProID=%@&TotalCount=%@",us,KUUID,self.startCount,[NSString stringWithFormat:@"%ld",(long)self.a]]];
    NSLog(@"%@", url);
   
    [self requset:url];
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
//    self.btn1 = btn;
}
-(void)clickA{
//    _menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    //    messageC.view.userInteractionEnabled = YES;
//    messageC.deleagte = self;
//    _menu.contentController = messageC;
//    [_menu showFrom:self.btn1];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_menu dismiss];
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
- (void)click
{
//    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark  === 底部备注图  ==
- (void)createDownView{
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0 , KHEIGHT-100, KWIDTH, 50)];
    downView.backgroundColor = ZXColor(239, 239, 224, 1);
    [self.view addSubview:downView];
    
    UILabel *showLbel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 50)];
    NSString *str = @"*注:十公里内免费配送,十公里以上另行收费";
    NSString *str1 = @"图片仅供参考";
    showLbel.text = [NSString stringWithFormat:@"%@\n%@",str,str1];
    showLbel.numberOfLines = 0;
    showLbel.font = [UIFont systemFontOfSize:15];
    showLbel.textColor = [UIColor redColor];
    showLbel.textAlignment = NSTextAlignmentCenter;
    [downView addSubview:showLbel];
}
//- (void)createFooterView
//{
//    UIView *serviceView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT-44, KWIDTH, 44)];
//    serviceView.backgroundColor = ZXColor(245, 245, 245, 1);
//    [self.view addSubview:serviceView];
//    
//    UILabel *bb = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 125*SWIDTH_SCALE, serviceView.frame.size.height)];
//    bb.text = @"此星级总价格:";
////    bb.backgroundColor = [UIColor greenColor];
//    [serviceView addSubview:bb];
//    
//    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(125*SWIDTH_SCALE, 0, 82*SWIDTH_SCALE, serviceView.frame.size.height)];
//    priceLabel.text = @"700000";
////    priceLabel.backgroundColor = [UIColor orangeColor];
//    priceLabel.textAlignment = NSTextAlignmentRight;
//    [serviceView addSubview:priceLabel];
//    self.priceLabel = priceLabel;
//    
//    UILabel *mm = [[UILabel alloc]initWithFrame:CGRectMake(207*SWIDTH_SCALE, 0, 60*SWIDTH_SCALE, serviceView.frame.size.height)];
////    mm.backgroundColor = [UIColor blueColor];
//    mm.text = @"元/桌";
//    mm.textColor = [UIColor blackColor];
//    mm.textAlignment = NSTextAlignmentLeft;
//    [serviceView addSubview:mm];
//    
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn.frame = CGRectMake(265*SWIDTH_SCALE, 0,113*SWIDTH_SCALE, serviceView.frame.size.height);
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [btn addTarget:self action:@selector(appointment) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = ZXColor(125, 180, 43, 1);
//    [btn setTintColor:[UIColor whiteColor]];
//    [btn setTitle:@"加入订单" forState: UIControlStateNormal];
//    [serviceView addSubview:btn];
//}
- (void)requset:(NSString*)string
{
    [zJRequestManager requestWithUrl:string parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        [[HUDView sharedInstanceWithView:self.view]showOnlyTextHUD];
        [HUDView sharedInstanceWithView:self.view].text = @"添加成功,在购物车等亲";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        });
    } failedWithError:^(NSError *connectionError) {
        
        
    }];
}

-(void)createHeaderView{
    _headerView = [[UIView alloc] init];
    _headerView.frame = CGRectMake(0, 64, KWIDTH, 44);
    _headerView.backgroundColor = [UIColor whiteColor];
    
    NSArray *ary = @[@"三星级",@"四星级",@"五星级"];
    for (int i = 3; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(kCONENTWIDTH *(i-3), 0, kCONENTWIDTH, _headerView.frame.size.height);
        btn.tag = 1000+i;
        btn.tintColor = ZXColor(160, 206, 85, 1);

        [btn setTitle:ary[i - 3] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:btn];
    }
    
    UIButton *btn1 = (UIButton *)[_headerView viewWithTag:1003];
    btn1.tintColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
}
- (void)click:(UIButton *)sender
{
    if (tag1 != sender.tag) {
        UIButton *btn = (UIButton *)[_headerView viewWithTag:tag1];
        btn.tintColor = ZXColor(160, 206, 85, 1);
        tag1 = sender.tag;
    }
    switch (sender.tag) {
        case 1003:
            [self getPriceWithI:1];
            self.startCount = @"3";

            self.aa  = 1;
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(0, 0)animated:NO];
//            [self.leftTabView reloadData];
            break;
        case 1004:
            [self getPriceWithI:2];
            self.startCount = @"4";
            self.aa = 2;
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(KWIDTH, 0)animated:NO];
//             [self.currentTabView reloadData];
            break;
        case 1005:
            [self getPriceWithI:3];
            self.startCount = @"5";

            self.aa = 3;
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(KWIDTH*2, 0)animated:NO];
//            [self.rightTabView reloadData];
            break;
        default:
            break;
    }
}
- (void)createRightTableView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, KWIDTH,KHEIGHT-110)];
    _scrollView.bounces = YES;
    _scrollView.contentSize = CGSizeMake(KWIDTH * 3, KHEIGHT-110);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    self.leftTabView = [self setTableViewWithRect:CGRectMake(0,0,KWIDTH,KHEIGHT-110)];
//    self.leftTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.scrollView addSubview:_leftTabView];
    
    self.currentTabView = [self setTableViewWithRect:CGRectMake(KWIDTH,0,KWIDTH,KHEIGHT-110)];
//    self.currentTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.scrollView addSubview:_currentTabView];
    
    self.rightTabView = [self setTableViewWithRect:CGRectMake(KWIDTH * 2,0,KWIDTH,KHEIGHT-198)];
    
    [self.scrollView addSubview:_rightTabView];
    
}
#pragma mark == 根据星级获取厨具列表 ==
-(void)requeatstartNum:(NSString*)str{
    [self.view showBusyHUD];
    //http://emm.nbeykj.com/ashx/WaresHandle.ashx?Action=GetDetail
    NSString *url = [PREURL stringByAppendingString:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=CoverBorrow&Function=HttpGetEntitysMainPage&StarLevel=%@",str]];
     [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
         if (!dic) {
             return ;
         }else{
             NSArray *key = dic[@"Content"];
             NSLog(@"%@",key);
            
             for (NSDictionary *dica in key) {
                 ; ClassificationModel *model = [[ClassificationModel alloc]init];
                 model.Price = dic[@"Price"];
                 [model setValuesForKeysWithDictionary:dica];
                 if ([str isEqualToString:@"3"]){
                     [self.leftArray addObject:model];
                     self.price = dic[@"Price"];
                     _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",self.price.floatValue];
                     //self.startCount = str;

                 }
                 else if ([str isEqualToString:@"4"]){
                     [self.currentArray addObject:model];
                     self.price = dic[@"Price"];
                     _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",self.price.floatValue];
                    // self.startCount = str;

                 }
                 else{
                     [self.rightArray addObject:model];
                     self.price = dic[@"Price"];
                     _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",self.price.floatValue];
                     //self.startCount = str;

                 }
                

             }
             
             [self.leftTabView reloadData];
             [self.currentTabView reloadData];
             [self.rightTabView reloadData];
         }
         [self.view hideBusyHUD];
     } failedWithError:^(NSError *connectionError) {
     }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        if (tableView == self.leftTabView) {
            return self.leftArray.count;
        }
        else if (tableView == self.currentTabView)
        {
            return self.currentArray.count;
        }
        else{
            return self.rightArray.count;
        }
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *big = @"cella";
        TablewareRightCell *cell = [tableView dequeueReusableCellWithIdentifier:big];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"TablewareRightCell" owner:nil options:nil].firstObject;
            //去掉多余的分割线
            [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
            if (tableView == self.leftTabView) {
                ClassificationModel *model = self.leftArray[indexPath.row];
                cell.model = model;
            }
            else if (tableView == self.currentTabView)
            {
                ClassificationModel *model = self.currentArray[indexPath.row];
                cell.model = model;
                
            }
            else{
                ClassificationModel *model = self.rightArray[indexPath.row];
                cell.model = model;
            }
        }
        return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(UITableView *)setTableViewWithRect:(CGRect)rect
{
    UITableView *tableView  = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        [[_headerView viewWithTag:1003] setTintColor:ZXColor(160, 206, 85, 1)];
        
        [[_headerView viewWithTag:1004] setTintColor:ZXColor(160, 206, 85, 1)];
        [[_headerView viewWithTag:1005] setTintColor:ZXColor(160, 206, 85, 1)];
        NSInteger tag = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width) + 1003;
        [[_headerView viewWithTag:tag] setTintColor:[UIColor blackColor]];
        if (tag==1003) {
//            _aa = 1;
            [self getPriceWithI:1];
            self.startCount = @"3";

//            [self.leftTabView reloadData];
        }else if (tag==1004){
            [self getPriceWithI:2];
            self.startCount = @"4";
//            _aa = 2;
//            [self.currentTabView reloadData];

            
        }else if (tag==1005){
            self.startCount = @"5";
//            _aa = 3;
            [self getPriceWithI:3];
//            [self.rightTabView reloadData];

            
        }
        
        if (self.scrollView.contentOffset.x <=KWIDTH) {
            self.aa = 2;
        }else if (self.scrollView.contentOffset.x > KWIDTH)
        {
            self.aa = 3;
        }
    }
    
    
}

#pragma mark === 底部价格赋值====
- (void)getPriceWithI:(NSInteger)i{
    NSLog(@"%ld",_aa);

    if (i==1) {
        for (int i = 0; i < _leftArray.count; i ++) {
            ClassificationModel *model = _leftArray[i];
            _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",model.Price.floatValue];
//            [self.leftTabView reloadData];
        }
    }else if (i==2){
        
        for (int i = 0; i < _currentArray.count; i ++) {
            ClassificationModel *model = _currentArray[i];
            _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",model.Price.floatValue];
        }
        
        
    }else if (i==3){
        
        for (int i = 0; i < _rightArray.count; i ++) {
            ClassificationModel *model = _rightArray[i];
            _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2f",model.Price.floatValue];
        }
        
    }
}
-(void)appointment{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"success"]) {
        [self showLoginMessage:@"您还没有登陆快去登录吧!"];
        return;
    }
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
    //http://120.27.141.95:8083/ashx/BookHandler.ashx?Action=AddIntoOrder&Type=Type_TableWare&StarLevel=3&fkCusTel=15558793823
    NSString*start = @"";
    
    if (self.aa == 1) {
        start = @"3";
    }else if (self.aa == 2)
    {
        start = @"4";
    }else if (self.aa == 3)
    {
        start = @"5";
    }
    NSString *url =[NSString
                    stringWithFormat:[PREURL stringByAppendingPathComponent:@"BookHandler.ashx?Action=AddIntoOrder&Type=Type_TableWare&StarLevel=%@&fkCusTel=%@&CustPhyAddr=%@"]
                    ,start,str,KUUID];
    NSLog(@"%@",url);
    [self requset:url];
}
- (void)showmessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:cancelAction];
}
- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        ReserveViewController *ReserveVC = [[ReserveViewController alloc]init];
//        ReserveVC.isOther = YES;
//        [self.navigationController pushViewController:ReserveVC animated:YES];
    }];
    [alert addAction:cancelAction];
}
- (void)showLoginMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
        
        [self presentViewController:navVC animated:YES completion:nil];
    }];
    
    [alert addAction:cancelAction];
}
#define 使cell 右边的缺失部分补齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}




@end
