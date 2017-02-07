//
//  FeastDtiallController.m
//  YY
//
//  Created by 赵洁 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastDtiallController.h"
#import "FeastDtiallleftCell.h"
#import "FeastDtiallRightCell.h"
#import "BottmView.h"
#import "DishModel.h"
#import "CuisineModel.h"
#import "PictureController.h"
#import "LoginViewController.h"
#import "SectionView.h"
#import "RegisterViewController.h"
#import "EMLBottmView.h"
#import "ESLReplaceViewController.h"
@interface FeastDtiallController ()<UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate,ESLReplaceViewDelegate>
@property (strong, nonatomic)UITableView *LeftTableView;
@property (strong, nonatomic)UITableView *RightTableView;
//@property (strong, nonatomic) BottmView*bottmView;
@property (strong, nonatomic)NSMutableArray *array;
@property (strong, nonatomic)NSMutableArray *ary;
//@property (strong, nonatomic)NSMutableArray *dataArray;
@property (assign, nonatomic)BOOL isFirst;
@property (nonatomic, strong)DishModel*Dmodel;
//@property (nonatomic, strong)CuisineModel*cmodel;
@property (assign, nonatomic)NSInteger count;
@property (strong, nonatomic)UIView *muenView;
@property (strong, nonatomic)UIView *cover;
@property (strong, nonatomic)NSMutableArray*isOpen;
@property (strong, nonatomic)SectionView*sectionView;
@property (assign, nonatomic)BOOL isChanage;
@property (strong, nonatomic)NSMutableArray*replaArray;
@property (nonatomic) BOOL isSelect;
@property (nonatomic,strong)NSMutableArray*selectArray;
@property (nonatomic, strong)NSMutableArray *hotArray;
@property (nonatomic, strong)NSMutableArray *coolArray;
@property (nonatomic, assign)BOOL isCoolFood;
//@property (strong, nonatomic) DropdownMenu *menu ;
@property (strong, nonatomic) UIImageView *dropdownMenu;
@property (strong, nonatomic)UIButton *btn;
@property (strong, nonatomic)EMLBottmView *bottmView;
@property (strong, nonatomic)NSMutableArray *countArray;
@property (assign, nonatomic)NSInteger a;
@property (strong, nonatomic)ESLReplaceViewController*cv;
@property (strong, nonatomic)UIView*vv;

@end

@implementation FeastDtiallController
-(NSMutableArray *)hotArray
{
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}
-(NSMutableArray *)coolArray
{
    if (!_coolArray) {
        _coolArray = [NSMutableArray array];
    }
    return _coolArray;
}
- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
- (void)dealloc
{
//    self.menu = nil;
    self.sectionView = nil;
    NSLog(@"%s",__func__
          );
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.isFirst = YES;
    self.title = @"套餐详情";
    _isChanage = NO;
    _isCoolFood = YES;
    _countArray = [NSMutableArray array];
    _a = 1;
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithTitle:@"菜单" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItem)]];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    [self CreatbottmView];

    [self createleftTableView];
    [self createrightTableView];
    [self request];
    self.replaArray = [NSMutableArray array];
}
- (void)Click:(UIBarButtonItem*)item
{
//    
//    _menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.isPop = YES;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    messageC.deleagte = self;
//    _menu.contentController = messageC;
//    [_menu showBFrom:self.view];
    
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        
//    }else if (indexPath.row==1){
//    
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
//        
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
- (void)rightBarButtonItem
{
    PictureController *pp = [[PictureController alloc]init];
    pp.ary = _ary;
    pp.coolFoodArray = self.coolArray;
    pp.hotFoodArray = self.hotArray;


    [self.navigationController pushViewController:pp animated:YES];
}
- (void)CreatbottmView
{
    _bottmView = [[NSBundle mainBundle]loadNibNamed:@"EMLBottmView" owner:nil options:nil].lastObject;
    _bottmView.backgroundColor = ZXColor(241, 241, 241, 0.7);
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
//加入购物车
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
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FeastSetMeal&Function=HttpMoveToShoppingCart&UserTel=%@&UserPhyAdd=%@&ProID=%@&TotalCount=%@",us,KUUID,self.model.SetMealID,[NSString stringWithFormat:@"%ld",(long)self.a]]];
    NSLog(@"%@",url);
    [self requset:url];

}
//登陆返回代理
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)requset:(NSString*)string
{
    [[HUDView sharedInstanceWithView:self.view]showOnlyTextHUD];

    [zJRequestManager requestWithUrl:string parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary*dic  = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString*sss = dic[@"提示"];
        if ([sss isEqualToString:@"添加成功"]) {
            [HUDView sharedInstanceWithView:self.view].text = @"添加成功,在购物车等亲";

        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

           [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
            [self.navigationController popToRootViewControllerAnimated:YES ];
        });
        
    } failedWithError:^(NSError *connectionError) {
        

    }];
}

- (void)createleftTableView{
    
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 100, KHEIGHT-114) style:UITableViewStylePlain];
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.backgroundColor = [UIColor whiteColor];
    //分割线的颜色
   // [_LeftTableView setSeparatorColor:[UIColor grayColor ]];
    //分割线的样式
    //    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    /**隐藏滚动条*/ 
    _LeftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_LeftTableView];
}
- (void)createrightTableView{
    
    _RightTableView = [[UITableView alloc]                             initWithFrame:
                                      CGRectMake(100,27, KWIDTH-100, KHEIGHT-77) style:UITableViewStyleGrouped];
    _RightTableView.delegate = self;
    _RightTableView.dataSource = self;
    _RightTableView.pagingEnabled = NO;
    //分割线的颜色
    [_RightTableView setSeparatorColor:[UIColor grayColor ]];
    //隐藏滚动条
    _RightTableView.showsVerticalScrollIndicator = NO;
    _RightTableView.backgroundColor = [UIColor whiteColor];
    //_RightTableView.bounces = YES;
    [self.view addSubview:_RightTableView];
}
#define 左数据请求
- (void)request
{
    NSString *Url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FeastSetMeal&Function=HttpGetEntitysMainPage&ProID=%@"],self.model.SetMealID];
    NSLog(@"%@",Url);
    [zJRequestManager requestWithUrl:Url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (dic.count == 0) {
            NSLog(@"为空===================================");
            return ;
        }else{
            self.model.TotalPrice = dic[@"Price"];
            _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.1f元",self.model.TotalPrice.floatValue];

            NSDictionary*dica = dic[@"Content"];
            NSArray*hotarray = dica[@"recai"];
            self.hotArray = [NSMutableArray array];
            for (NSDictionary*dics in hotarray) {
                DishModel*Dmodel = [[DishModel alloc]init];
                Dmodel.isReplac = NO;
                [Dmodel setValuesForKeysWithDictionary:dics];
                [self.hotArray addObject:Dmodel];
            }
            NSArray*coolarray = dica[@"lengcai"];
            self.coolArray = [NSMutableArray array];
            for (NSDictionary*dicf in coolarray) {
                DishModel*Dmodel = [[DishModel alloc]init];
                Dmodel.isReplac = NO;

                [Dmodel setValuesForKeysWithDictionary:dicf];
                [self.coolArray addObject:Dmodel];
            }
        }
        [self.RightTableView reloadData];
        [self.LeftTableView reloadData];
        if (self.isFirst) {
            NSInteger topCellSection = [[[self.LeftTableView indexPathsForVisibleRows]firstObject]section];
            [self.LeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            self.isFirst = NO;
        }
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        return 50;
    }else if ([tableView isEqual:_RightTableView]){
        return 80;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_LeftTableView]) {
        
        return 2;
        
    }else if ([tableView isEqual:_RightTableView]){
        
            if (_coolArray.count == 0) {
                return 0;
            }else{
                if (self.isCoolFood == YES) {
                    return self.coolArray.count;
                }
                else
                {
                    return self.hotArray.count;
                }
            }
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_LeftTableView]) {
        
        static NSString *identifier = @"mycell";//这里随便写  最好别和cell类名一样
        FeastDtiallleftCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDtiallleftCell" owner:nil options:nil].firstObject;
            //去掉多余的分割线
            [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
            //改变cell被点击时候的颜色*************************
            cell.backgroundColor = ZXColor(240, 240, 240,1);
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectedBackgroundView;
            // 左侧示意条
            UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 6, 50)];
            liner.backgroundColor = [UIColor orangeColor];
            [selectedBackgroundView addSubview:liner];
            
        }
        
        if (indexPath.row == 0) {
            cell.NameLable.text= @"冷菜";
        }else
        {
            cell.NameLable.text = @"热菜";
        }
            return cell;
        
    }else 
    {
        static NSString *identifier = @"mycell";
        FeastDtiallRightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDtiallRightCell" owner:nil options:nil].firstObject;
           
        }

        DishModel *model = self.isCoolFood ? self.coolArray[indexPath.row] : self.hotArray[indexPath.row];
        cell.model = model;
        cell.ChooseButton.hidden = YES;
        cell.ChooseButton.tag= indexPath.row+10;
        [cell.ChooseButton addTarget:self action:@selector(replace:) forControlEvents:(UIControlEventTouchUpInside)];
        if (model.isReplac == YES) {

        }
            return cell;
    }
    
}

//替换
- (void)replace:(UIButton*)bb
{
    UIView*vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    vv.backgroundColor = [UIColor lightGrayColor];
    vv.alpha = 0.5;
    [self.view addSubview:vv];
    self.vv = vv;
    
    _cv = [[ESLReplaceViewController alloc]init];
    _cv.view.frame = CGRectMake((KWIDTH-280)/2 , (KHEIGHT-280)/2, 280, 280);
    _cv.delegate = self;
    _cv.CilckIndex = bb.tag - 10;
    [self.view addSubview:_cv.view];
    [self addChildViewController:_cv];
}
//替换代理
- (void)getdata:(NSInteger)row CilckIndex:(NSInteger)CilckIndex
{
    NSLog(@"%ld %ld",(long)row,CilckIndex);
    DishModel *model = self.isCoolFood ? self.coolArray[CilckIndex] : self.hotArray[CilckIndex];
    model.isReplac = YES;
    model.ImageUrl = @"";
    model.DishName = @"hhhhhhh";
    [self.vv removeFromSuperview];
    [_cv.view removeFromSuperview];
    [_cv removeFromParentViewController];
    [self.RightTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView])
    {
        if (indexPath.row == 0) {
            self.isCoolFood = YES;
            self.RightTableView.contentOffset = CGPointMake(0, 0);
        }
        else
        {
            self.isCoolFood = NO;
            self.RightTableView.contentOffset = CGPointMake(0, 0);
        }

        [self.RightTableView reloadData];
   }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.muenView removeFromSuperview];
    [self.cover removeFromSuperview];
}

#pragma mark == cell 将要显示的时候就会调用此方法  使cell分割线右边的缺失部分补齐 ==
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
