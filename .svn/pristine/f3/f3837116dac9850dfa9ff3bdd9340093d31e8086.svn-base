//
//  StarChoiceController.m
//  YY
//
//  Created by 徐恒 on 16/6/13.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "StarChoiceController.h"
#import "CookChooseController.h"
#import "CookRightCell.h"
#import "CookChooseController.h"
#import "TeamChefsDetailsViewController.h"
#import "StarController.h"
#import "CategoryController.h"
#import "PriceRangeController.h"
#import "StarModel.h"
#import "LoginViewController.h"
#import "HWDropdownMenu.h"

@interface StarChoiceController ()<UITableViewDelegate,UITableViewDataSource,StarControllerDelegeta>
@property (strong, nonatomic)UITableView *rightTableView;
@property (strong, nonatomic) HWDropdownMenu *menu ;
/**存放数据*/
@property (nonatomic,strong)NSMutableArray *dataArray;
/*星级数组*/
@property (strong, nonatomic)NSMutableArray *ary;
@property (strong, nonatomic)UIButton *btn;
@property (strong, nonatomic)UIButton *btn1;
@property (strong, nonatomic)UIButton *btn2;

//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *butn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation StarChoiceController

#pragma mark == 懒加载
- (NSMutableArray *)ary {
    if (!_ary) {
        _ary = [[NSMutableArray array]init];
    }
    return _ary;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray array]init];
    }
    return _dataArray;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(20, 94, KWIDTH*0.5-40, 30);
        [_btn setTitle:@"三星级" forState: UIControlStateNormal];
        [_btn setTitleColor:ZXColor(160, 206, 85, 1) forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 3;
        _btn.layer.masksToBounds = YES;
        _btn.layer.borderColor = ZXColor(160, 206, 85, 1).CGColor;
        _btn.layer.borderWidth = 1;
        [_btn setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(StarClick) forControlEvents:UIControlEventTouchUpInside];
        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
        _btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50*SWIDTH_SCALE, 0, -120*SWIDTH_SCALE);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20*SWIDTH_SCALE, 0, 30*SWIDTH_SCALE);
    }
    return _btn;
}
- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(_btn.frame.size.width+60, 94, KWIDTH*0.5-40, 30);
        [_btn1 setTitle:@"团队" forState: UIControlStateNormal];
        [_btn1 setTitleColor:ZXColor(160, 206, 85, 1) forState:UIControlStateNormal];
        _btn1.layer.cornerRadius = 3;
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.borderColor = ZXColor(160, 206, 85, 1).CGColor;
        _btn1.layer.borderWidth = 1;
        [_btn1 setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(CategoryClick) forControlEvents:UIControlEventTouchUpInside];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:18];
        _btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 50*SWIDTH_SCALE, 0, -100*SWIDTH_SCALE);
        _btn1.titleEdgeInsets = UIEdgeInsetsMake(0, -20*SWIDTH_SCALE, 0, 30*SWIDTH_SCALE);
    }
    return _btn1;
}
- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(20, 144, KWIDTH-40, 30);
        [_btn2 setTitle:@"厨师价格表" forState: UIControlStateNormal];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn2 setTitleColor:ZXColor(160, 206, 85, 1) forState:UIControlStateNormal];
        _btn2.layer.cornerRadius = 3;
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.borderColor = ZXColor(160, 206, 85, 1).CGColor;
        _btn2.layer.borderWidth = 1;
        [_btn2 addTarget:self action:@selector(PriceRangeClick) forControlEvents:UIControlEventTouchUpInside];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:18];

    }
    return _btn2;
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        CGRect rect = CGRectMake(0, 190,KWIDTH, KHEIGHT-190);
        _rightTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _rightTableView.tableFooterView =UIView.new;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 60;
    }
    return _rightTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"厨师";
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.rightTableView];
    [self request];
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
-(void)clickA{
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
//        _butn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_butn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [_butn setTintColor:ZXColor(83, 162, 38, 1)];
//        _butn.frame = CGRectMake(0, 0, 20, 20);
//        _butn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [_butn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_butn];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //[super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
//星级点击事件
- (void)StarClick
{
     _menu = [HWDropdownMenu menu];
    StarController *starBC = [[StarController alloc]init];
    starBC.view.height = 34*3;
    starBC.view.width = KWIDTH*0.5-45;
    starBC.type=StarsType;
    starBC.view.layer.cornerRadius = 5;
    starBC.view.layer.masksToBounds = YES;
    _menu.contentController = starBC;
    [_menu showFrom:self.btn];
    //方法一:block
//    WK(weakSelf);
//    starBC.block = ^(NSString *name){
//        NSLog(@"%@",name);
//        [weakSelf.menu dismiss];
//        [weakSelf.btn setTitle:name forState:UIControlStateNormal];
//    };
    //二.代理
    starBC.delegeta = self;
     [self.rightTableView reloadData];
}
#pragma mark --StarControllerDlegeta
-(void)starControllerWithTapName:(NSString *)name type:(StarType)type{
    [self.menu dismiss];
    if (type == TeamType) {
        [self.btn1 setTitle:name forState:UIControlStateNormal];
    }else if (type==StarsType){
        [self.btn setTitle:name forState:UIControlStateNormal];
    }
//    else if (type==PriceType){
//        [self.btn2 setTitle:name forState:UIControlStateNormal];
//    }
    [self reloadData];
}
//类别点击事件
- (void)CategoryClick
{
//    _menu = [HWDropdownMenu menu];
//    CategoryController *categoryC = [[CategoryController alloc]init];
//    categoryC.view.height = 44*2;
//    categoryC.view.width = myWidth1*0.5-40;
//    _menu.contentController = categoryC;
//    [_menu showFrom:self.btn1];
    //block
//    WK(weakSelf);
//    categoryC.block1=^(NSString *name){
//        [weakSelf.menu dismiss];
//        [weakSelf.btn1 setTitle:name forState:UIControlStateNormal];
//    };
    _menu = [HWDropdownMenu menu];
    StarController *starBC = [[StarController alloc]init];
    starBC.view.height = 34*2;
    starBC.view.width = KWIDTH*0.5-45;
    starBC.type=TeamType;
    starBC.view.layer.cornerRadius = 5;
    starBC.view.layer.masksToBounds = YES;
    _menu.contentController = starBC;
    [_menu showFrom:self.btn1];
    starBC.delegeta=self;
    [self.rightTableView reloadData];
}
//价格范围点击事件
-(void)PriceRangeClick
{
    PriceRangeController *priceRC = [[PriceRangeController alloc]init];
    [self.navigationController pushViewController:priceRC animated:YES];
}
#pragma mark 网络请求
- (void)request{
    [self.view showBusyHUD];
    NSString *url = [PREURL stringByAppendingString:@"CooksHandler.ashx?Action=GroupAndSingleInfo"];
    WK(weakSelf);
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"%@",dic);
        if (dic) {
            NSDictionary *teamDic =dic[@"团队"];
            [weakSelf.dataArray addObject:[weakSelf dicConversionModel:teamDic]];
            NSDictionary *personalDic =dic[@"个人"];
            [weakSelf.dataArray addObject:[weakSelf dicConversionModel:personalDic]];
           [ weakSelf reloadData];
        }
        [self.view hideBusyHUD];
    } failedWithError:^(NSError *connectionError) {
    }];
}
-(NSMutableArray *)dicConversionModel:(NSDictionary *)dic{
    
    NSMutableArray *arraAyy =[NSMutableArray array];
    for (int i =0; i<dic.count; i++) {
        if (i==0) {
            NSArray *threeArray =dic[@"三星级"];
            NSMutableArray *arr =[NSMutableArray array];
            for (NSDictionary *dic in threeArray) {
                StarModel *model =[[StarModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                NSLog(@"---%@", model.ServiceArea);
                [arr addObject:model];
            }
            [arraAyy addObject:arr];
        }else if (i==1){
            NSArray *fourArray =dic[@"四星级"];
            NSMutableArray *arr =[NSMutableArray array];
            for (NSDictionary *dic in fourArray) {
                StarModel *model =[[StarModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                  NSLog(@"===%@", model.ServiceArea);
                [arr addObject:model];
            }
            [arraAyy addObject:arr];
            
        }else if (i==2){
            NSArray *fiveArray =dic[@"五星级"];
            NSMutableArray *arr =[NSMutableArray array];
            for (NSDictionary *dic in fiveArray) {
                StarModel *model =[[StarModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                NSLog(@"+++%@", model.ServiceArea);
                [arr addObject:model];
            }
            [arraAyy addObject:arr];
        }
    }
    return arraAyy;
}
-(void)reloadData{
    NSLog(@"%s %@",__func__,self.btn1.currentTitle);
    NSMutableArray *oneArray =nil;
    NSMutableArray *twoArray =nil;
    if ([self.btn1.currentTitle isEqualToString:@"团队"] ) {
        oneArray =self.dataArray.firstObject;
    }else if ([self.btn1.currentTitle isEqualToString:@"个人"]){
        oneArray =self.dataArray.lastObject;
    }
    if ([self.btn.currentTitle isEqualToString:@"三星级"]) {
        twoArray =oneArray[0];
    }else if ([self.btn.currentTitle isEqualToString:@"四星级"]){
        twoArray =oneArray[1];
    }else if ([self.btn.currentTitle isEqualToString:@"五星级"]){
        twoArray =oneArray[2];
    }
    
//    降序
    if ([self.btn1.currentTitle isEqualToString:@"团队"]) {
        NSArray *arr1 = [twoArray sortedArrayUsingComparator:^NSComparisonResult(StarModel *model1, StarModel *model2) {
            
            NSInteger data1 = [model1.StarNumGrp integerValue];
            NSInteger data2 = [model2.StarNumGrp integerValue];
            if (data1>data2) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            if (data1<data2) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        self.ary = (NSMutableArray *)arr1;
    }else if ([self.btn1.currentTitle isEqualToString:@"个人"]){
        NSArray *arr2 = [twoArray sortedArrayUsingComparator:^NSComparisonResult(StarModel *model1, StarModel *model2) {
                NSInteger data1 = [model1.StarNum integerValue ];
                NSInteger data2 = [model2.StarNum integerValue];
                if (data1>data2) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                if (data1<data2) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
           
            return (NSComparisonResult)NSOrderedSame;
        }];
        self.ary = (NSMutableArray *)arr2;
    }
    [self.rightTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.ary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *big = @"cella";
    CookRightCell *cell = [tableView dequeueReusableCellWithIdentifier:big];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CookRightCell" owner:nil options:nil].lastObject;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StarModel *model =self.ary[indexPath.row];
    if ([self.btn1.titleLabel.text isEqualToString:@"团队"]) {
        cell.name.text = model.NameGrp;
        [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.ImageUrlGrp] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
    }else if ([self.btn1.titleLabel.text isEqualToString:@"个人"]){
        cell.name.text = model.RealName;
        [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.btn1.titleLabel.text isEqualToString:@"团队"]) {
        TeamChefsDetailsViewController *teamCD = [[TeamChefsDetailsViewController alloc]init];
        StarModel *model =self.ary[indexPath.row];
        teamCD.Model = model;
        [self.navigationController pushViewController:teamCD animated:YES];
    }else if ([self.btn1.titleLabel.text isEqualToString:@"个人"]){
        CookChooseController *cookChooseC = [[CookChooseController alloc]init];
        StarModel *model =self.ary[indexPath.row];
        cookChooseC.Model1 = model;
        [self.navigationController pushViewController:cookChooseC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}
@end
