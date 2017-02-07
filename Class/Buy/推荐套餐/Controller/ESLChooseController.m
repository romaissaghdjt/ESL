//
//  ESLTuiJianController.m
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLChooseController.h"
#import "ChooseFasetCell.h"
#import "FoodShowCell.h"
#import "ChooseFoodCell.h"
#import "ChooseBottmView.h"
#import "ChooseShowHeaderView.h"

@interface ESLChooseController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *LeftTableView;
@property (strong, nonatomic)UITableView *RightTableView;
@property (strong, nonatomic)ChooseShowHeaderView *FaestShowView;
@property (strong, nonatomic)ChooseBottmView *bottmView;
@end

@implementation ESLChooseController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人气套餐";
    
    [self createleftTableView];
    [self createrightTableView];
    [self CreatBottmView];
}
- (void)CreatBottmView
{
    _bottmView = [[ChooseBottmView alloc]initWithFrame:CGRectMake(0,KHEIGHT-50, KWIDTH, 50)];
    [_bottmView.JoinShopCarButton addTarget:self action:@selector(JoinShopCarButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottmView.BuyNowBuuton addTarget:self action:@selector(BuyNowBuuton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottmView];
}
- (void)createleftTableView{
    //**在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, KHEIGHT) style:UITableViewStylePlain];
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.backgroundColor = [UIColor whiteColor];
    //分割线的颜色
    [_LeftTableView setSeparatorColor:[UIColor lightGrayColor ]];
    /**隐藏滚动条*/
    _LeftTableView.showsVerticalScrollIndicator = NO;
    //去掉多余的分割线
    [_LeftTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:_LeftTableView];
}
- (void)createrightTableView{
    _RightTableView = [[UITableView alloc]initWithFrame:CGRectMake(120,64, KWIDTH- 120, KHEIGHT- 114) style:UITableViewStylePlain];
    _RightTableView.delegate = self;
    _RightTableView.dataSource = self;
    //分割线的颜色
    [_RightTableView setSeparatorColor:[UIColor grayColor ]];
    
    //隐藏滚动条
    _RightTableView.showsVerticalScrollIndicator = NO;
    //_RightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _RightTableView.backgroundColor = [UIColor whiteColor];
    //去掉多余的分割线
    [_RightTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_RightTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        if (indexPath.row == 0) {
            return 180;
        }else
        {
            return 44;
        }
        
    }else if ([tableView isEqual:_RightTableView]){
        return 80;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_LeftTableView]) {
        return 0;
    }else{
        return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_LeftTableView]) {
        return 6;
    }else if ([tableView isEqual:_RightTableView]){
        
        return 10;
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"RFcell";
            ChooseFoodCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"ChooseFoodCell" owner:nil options:nil].lastObject;
            }
            return cell;
        }else{
            static NSString *identifier = @"RFcell";
            ChooseFasetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"ChooseFasetCell" owner:nil options:nil].lastObject;
            }
            return cell;
            
        }
    }
    
    else
    {
        static NSString *identifier = @"FScell";
        FoodShowCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"FoodShowCell" owner:nil options:nil].lastObject;
        }
        [cell.ReplaceButton addTarget:self action:@selector(ReplaceButton) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
        
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _FaestShowView = [[ChooseShowHeaderView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH-120, 100)];
    return _FaestShowView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_RightTableView]) {
        NSLog(@"-=================");
    }
}
- (void)JoinShopCarButton:(UIButton*)Join
{
    //加入购物车
}
- (void)BuyNowBuuton
{
    //立即购买
}
- (void)ReplaceButton
{
    //替换
}

@end
