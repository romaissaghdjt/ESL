//
//  ZXFeastController.m
//  YY
//
//  Created by 赵洁 on 16/7/12.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ZXFeastController.h"
#import "BottmView.h"
#import "FeastDtiallleftCell.h"
#import "FeastDtiallRightCell.h"
#import "PictureController.h"
#import "CuisineModel.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
//#import "ReserveViewController.h
#import "EMLBottmView.h"
@interface ZXFeastController ()<UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
@property (strong, nonatomic)UITableView *LeftTableView;
@property (strong, nonatomic)UITableView *RightTableView;
@property (assign, nonatomic)BOOL isFirst;
@property (strong, nonatomic)NSString*stra;
@property (assign, nonatomic)NSInteger count;
@property (nonatomic, strong)NSMutableArray*buttonStautAry;
@property (nonatomic, strong)NSMutableArray*ary;
@property (nonatomic, strong)NSMutableArray*lefterAry;
//@property (nonatomic, strong)NSMutableArray*rightAry;
@property (nonatomic,strong)NSMutableArray*array;
@property (nonatomic,strong)CuisineModel *Cmodel;
@property (nonatomic,assign)NSInteger sum;
@property (nonatomic, strong)NSMutableArray*chooseCoolArray;
@property (nonatomic, strong)NSMutableArray*chooseHotArray;
@property (nonatomic,strong)NSMutableArray*Larray;

@property (nonatomic)BOOL isClose;
@property (strong, nonatomic)EMLBottmView *bottmView;

@property (assign, nonatomic)NSInteger a;

@property (nonatomic, strong)NSMutableArray *coolArray;
@property (nonatomic, strong)NSMutableArray *hotArray;
@property (nonatomic, assign)BOOL isCoolFood;
//@property (strong, nonatomic) DropdownMenu *menu ;
@property (nonatomic, strong)UILabel*Llable;
@property (nonatomic, strong)UILabel*Rlable;
@property (strong, nonatomic)UIButton *btn;
//@property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation ZXFeastController
-(NSMutableArray *)coolArray
{
    if (!_coolArray) {
        _coolArray = [NSMutableArray array];
    }
    return _coolArray;
}
-(NSMutableArray *)hotArray
{
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}
- (NSMutableArray *)Larray
{
    if (!_Larray) {
        _Larray = [NSMutableArray array];
    }
    return _Larray;
}
- (NSMutableArray *)chooseCoolArray
{
    if (!_chooseCoolArray) {
        _chooseCoolArray = [NSMutableArray array];
    }
    return _chooseCoolArray;
}
- (NSMutableArray *)chooseHotArray
{
    if (!_chooseHotArray) {
        _chooseHotArray = [NSMutableArray array];
    }
    return _chooseHotArray;
}
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSMutableArray *)ary
{
    if (!_ary) {
        _ary = [NSMutableArray array];
    }
    return _ary;
}
-(NSMutableArray *)lefterAry
{
    if (!_lefterAry) {
        _lefterAry = [NSMutableArray array];
    }
    return _lefterAry;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCoolFood = YES;
    self.isFirst = YES;
    self.isClose = NO;
    self.title = @"套餐详情";
    _sum = 0;
    _a = 1;
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithTitle:@"菜单" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItem)]];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    [self createleftTableView];
    [self createrightTableView];
    [self CreatbottmView];
    _buttonStautAry = [NSMutableArray array];
    [self request];
}
- (void)request
{

    NSString*url1 =[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FeastSingle&Function=HttpQueryAllEntitys"];
    NSLog(@"%@",url1);
    [zJRequestManager requestWithUrl:url1 parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (dic.count == 0) {
            NSLog(@"为空===================================");
            return ;
        }
        
        NSArray*arry = dic[@"热菜"];
        for (NSDictionary*dics in arry) {
            DishModel *model = [[DishModel alloc]init];
            [model setValuesForKeysWithDictionary:dics];
            [self.hotArray addObject:model];
        }
        NSArray*coolarry = dic[@"冷菜"];

        for (NSDictionary*dics in coolarry) {
            DishModel *model = [[DishModel alloc]init];
            [model setValuesForKeysWithDictionary:dics];
            [self.coolArray addObject:model];
           
        }
        
        [self.RightTableView reloadData];
        if (self.isFirst) {
            NSInteger topCellSection = [[[self.LeftTableView indexPathsForVisibleRows]firstObject]section];
            [self.LeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            self.isFirst = NO;
        }
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
//- (void)Click
//{
//    _menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    messageC.deleagte = self;
//    _menu.contentController = messageC;
//    [_menu showBFrom:self.view];
//    
//}
//- (void)dismiss:(NSIndexPath *)indexPath
//{
////    [_menu dismiss];
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
//       // XHIndetController*XHindetC = [[XHIndetController alloc]init];
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
//}
- (void)click
{
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)rightBarButtonItem
{
    if (self.chooseCoolArray.count == 0 &&self.chooseHotArray.count == 0) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"菜单还没有东西" controller:self];
        return;
    }
    
    PictureController *pp = [[PictureController alloc]init];
    pp.ary = _lefterAry;
    pp.coolFoodArray = self.chooseCoolArray;
    pp.hotFoodArray = self.chooseHotArray;
    [self.navigationController pushViewController:pp animated:YES];
}
- (void)CreatbottmView
{
    _bottmView = [[NSBundle mainBundle]loadNibNamed:@"EMLBottmView" owner:nil options:nil].lastObject;
    _bottmView.backgroundColor = ZXColor(241, 241, 241, 0.7);
    _bottmView.frame = CGRectMake(0, self.view.height-50, KWIDTH, 50);
        _bottmView.PlusBnt.hidden = YES;
    _bottmView.MiunBnt.hidden= YES;
    _bottmView.Countlable.hidden = YES;
    _bottmView.totalPriceLable.text = @"还没有选";
    _bottmView.totalPriceLable.textColor = [UIColor grayColor];
    _bottmView.lable.text = @"总计:";
    [self.bottmView.JoinToOrdeBnt addTarget:self action:@selector(JoinToOrdeBnt) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_bottmView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        return 50;
    }else if ([tableView isEqual:_RightTableView]){
        return 70;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_LeftTableView]) {
        
    return 2;
            
    }else {
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

}
- (void)createleftTableView{
    //**在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, KHEIGHT-50) style:UITableViewStylePlain];
    
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.backgroundColor = [UIColor whiteColor];
    /**隐藏滚动条*/
    _LeftTableView.showsVerticalScrollIndicator = NO;
    
    self.Llable = [self creatTipView:CGRectMake(75, 5, 22, 22) color:[UIColor orangeColor]];
    [_LeftTableView addSubview:self.Llable];
    self.Rlable = [self creatTipView:CGRectMake(75, 55, 22, 22) color:[UIColor lightGrayColor]];
    //去掉多余的分割线
    [_LeftTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [_LeftTableView addSubview:self.Rlable];
    [self.view addSubview:_LeftTableView];
}

- (void)createrightTableView{
    _RightTableView = [[UITableView alloc]initWithFrame:CGRectMake(100,28, KWIDTH-100, KHEIGHT-78) style:UITableViewStyleGrouped];
    _RightTableView.backgroundColor = [UIColor whiteColor];
    _RightTableView.delegate = self;
    _RightTableView.dataSource = self;
    _RightTableView.pagingEnabled = NO;
    //去掉多余的分割线
    [_RightTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    //隐藏滚动条
    _RightTableView.showsVerticalScrollIndicator = NO;
//    _RightTableView.backgroundColor = [UIColor whiteColor];
    //_RightTableView.bounces = YES;
    [self.view addSubview:_RightTableView];
}
- (UILabel*)creatTipView:(CGRect)frame color:(UIColor*)color
{
    UILabel*lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = color;
    lable.font = [UIFont systemFontOfSize:12];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.text = @"0";
    lable.layer.cornerRadius = 11;
    lable.layer.masksToBounds = YES;
    return lable;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if ([tableView isEqual:_LeftTableView]) {
            /**
             以下方法
             在创建cell时候选择第几个cell被选中
             *
             */
//            //********************************************
//            NSInteger topCellSection = [[[self.LeftTableView indexPathsForVisibleRows]firstObject]section];
//            [self.LeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            //*******************************************
            static NSString *identifier = @"mycell";//这里随便写  最好别和cell类名一样
            FeastDtiallleftCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDtiallleftCell" owner:nil options:nil].firstObject;
                
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
                cell.NameLable.text= @"热菜";
            }else
            {
                cell.NameLable.text = @"冷菜";
            }
            
                return cell;
            
            
        }else
        {
            static NSString *identifier = @"mycell";
            FeastDtiallRightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDtiallRightCell" owner:nil options:nil].firstObject;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
                cell.FeastImg.layer.cornerRadius = 6;
                cell.FeastImg.layer.masksToBounds = YES;
            
            cell.ChooseButton.tag = 100 + indexPath.row;
            
            [cell.ChooseButton addTarget:self action:@selector(ChooseButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            if ([_buttonStautAry containsObject:[NSString stringWithFormat:@"%ld", 100+indexPath.row]])
            {
                
                cell.ChooseButton.selected = YES;
                [cell.ChooseButton setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
                
            }else
            {
                
                [cell.ChooseButton setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
            }
            
            DishModel*model = self.isCoolFood ? self.coolArray[indexPath.row] : self.hotArray[indexPath.row];
                if (model.isSelect == YES) {
                    cell.ChooseButton.selected = YES;
                    [cell.ChooseButton setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
                }else
                {
                    [cell.ChooseButton setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
                }
                if (self.isClose == YES) {
                    [cell.ChooseButton setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
                }
                [cell.FeastImg  sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
                cell.FeastNameLable.text = model.DishName;
                //cell.PriceLable.text = [NSString stringWithFormat:@"¥%.2f元/",model.UnitPrice. floatValue] ;
            if ([model.Norm isEqualToString:@""]) {
                cell.ZLLable.text = [NSString stringWithFormat:@"%ld元",(long)model.UnitPrice.integerValue];
            }else{
              cell.ZLLable.text = [NSString stringWithFormat:@"%@约%@",[NSString stringWithFormat:@"%ld元/",(long)model.UnitPrice. integerValue],model.Norm];
            }
            
                return cell;
//            }
    }
    
}

- (void)ChooseButton:(UIButton*)bnt
{      bnt.selected =!bnt.selected;
    DishModel *model = self.isCoolFood ? self.coolArray[bnt.tag-100]:self.hotArray[bnt.tag-100];
    model.isSelect = !model.isSelect;
    if (bnt.selected == YES) {
        
        [_buttonStautAry addObject:[NSString stringWithFormat:@"%ld",(long)bnt.tag]];
        _sum +=model.UnitPrice.integerValue;
        _bottmView.totalPriceLable.text  = [NSString stringWithFormat:@"%ld元",(long)_sum];
        _bottmView.totalPriceLable.textColor = [UIColor orangeColor];

        [bnt setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
        
        [self.array addObject:model.DishID];
        
        [self.isCoolFood ? self.chooseCoolArray:self.chooseHotArray addObject:model];
        self.Llable.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.chooseCoolArray.count];
        self.Rlable.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.chooseHotArray.count];

    }else{
       
        [_buttonStautAry removeObject:[NSString stringWithFormat:@"%ld",(long)bnt.tag]];
         _sum-=model.UnitPrice.integerValue;
                    _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"%.2ld",(long)_sum];
        [bnt setImage:[UIImage imageNamed:@"gray_icon.png"]
             forState:(UIControlStateNormal)];
        [_array removeObject:model.DishID];
        [self.isCoolFood ? self.chooseCoolArray:self.chooseHotArray removeObject:model];
        self.Llable.text = [NSString stringWithFormat:@"%ld",self.chooseCoolArray.count];
        self.Rlable.text = [NSString stringWithFormat:@"%ld",self.chooseHotArray.count];
        if (_sum <1) {
            _bottmView.totalPriceLable.text =@"还没有选";
                _bottmView.totalPriceLable.textColor = [UIColor grayColor];
        }
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_LeftTableView])
    {
        if (indexPath.row == 0) {
            self.isCoolFood = YES;
            self.RightTableView.contentOffset = CGPointMake(0, 0);
            self.Rlable.backgroundColor = [UIColor lightGrayColor];
            self.Llable.backgroundColor = [UIColor orangeColor];
            _buttonStautAry = [NSMutableArray array];
            [_buttonStautAry addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
            

            [self.RightTableView reloadData];
        }
        else
        {
            self.RightTableView.contentOffset = CGPointMake(0, 0);
            self.Rlable.backgroundColor = [UIColor orangeColor];
            self.Llable.backgroundColor = [UIColor lightGrayColor];
            _buttonStautAry = [NSMutableArray array];
            [_buttonStautAry addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

            self.isCoolFood = NO;
            [self.RightTableView reloadData];
        }
       
        
        
    }
        
}
#pragma mark == cell 将要显示的时候就会调用此方法  使cell分割线右边的缺失部分补齐 ==
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma 赋值底部视图价格
//- (void)SumBottmPrice
//{
//    CGFloat sum = 0;
//    for (int i = 0; i < _rightAry.count; i++) {
//        DishModel*model = _rightAry[i];
//        
//        sum = sum +model.UnitPrice.floatValue*1.1;
//    }
//    _bottmView.totalPriceLable.textColor = [UIColor orangeColor];
//    _bottmView.totalPriceLable.text = [NSString stringWithFormat:@"¥%.2f",sum];
//}
//加入购物车
- (void)JoinToOrdeBnt
{
    NSString*aa =@"";
    if (_array.count == 0) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"你还没选哦" controller:self];
    }else{
        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
        if (![info boolForKey:Login_Suc]) {
            LoginViewController*login = [[LoginViewController alloc] init];
            login.delegate = self;
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
            
            [self presentViewController:navVC animated:NO completion:nil];
            return;
        }
        for (NSString*dd in _array) {
            
            aa=[aa stringByAppendingString:[NSString stringWithFormat:@"%@,",dd]];
        }
        
        NSString*as = [NSString stringWithFormat:@"[%@]",[aa substringToIndex:aa.length-1]];
        
        NSString*ssurls = [NSString stringWithFormat:[PREURL stringByAppendingPathComponent:@"Shopping.ashx?Component=Product&ProModule=FeastSingle&Function=HttpMoveMultipleToShoppingCart&UserTel=%@&UserPhyAdd=%@&ProInfo=%@"],us,KUUID,as];
        NSLog(@"%@",ssurls);
        
        [zJRequestManager requestWithUrl:ssurls parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
            NSDictionary*aa = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];;
            NSLog(@"%@",ssurls);
            NSString*str1 = aa[@"提示"];
            NSLog(@"%@",str1);
        if ([str1 isEqualToString:@"添加成功"])
            {
                self.isClose = YES;
                [self.chooseHotArray removeAllObjects];
                [self.chooseCoolArray removeAllObjects];
                [self.buttonStautAry removeAllObjects];
                [self.RightTableView reloadData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
            }else
            {
                NSLog(@"添加失败");
            }
            
        } failedWithError:^(NSError *connectionError) {
            
        }];

        
    }
    
}

- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
