//
//  ESLTuiJianController.m
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLTuiJianController.h"
#import "recFasetCell.h"
#import "FasetShowCell.h"
#import "SinglFaestCell.h"
#import "FaestShowHeaderView.h"
#import "BottmView.h"
#import "AllEvaluateCell.h"
#import "FeastAllViewModel.h"
@interface ESLTuiJianController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *LeftTableView;
@property (strong, nonatomic)UITableView *RightTableView;
//@property (strong, nonatomic)FaestShowHeaderView*FaestShowView;
@property (strong, nonatomic)BottmView*bottmView;
@property (nonatomic,strong)FeastAllViewModel*ViewModel;
@property (nonatomic,strong)NSMutableArray*array;
@property (nonatomic,assign)BOOL isDid;
@end

@implementation ESLTuiJianController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self getEvaluate];
    NSLog(@"%@",self.ID);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createleftTableView];
}
- (void)getEvaluate
{
    WK(weakSelf);
    self.array = [NSMutableArray array];
    _ViewModel = [[FeastAllViewModel alloc]init];
    _ViewModel.FeastEvaluateBlock = ^(id EvaluateSource){
        weakSelf.array = EvaluateSource;
        if (weakSelf.array.count == 0) {
            UILabel *ll = [[UILabel alloc]initWithFrame:CGRectMake(KWIDTH/2-70, 50, 150, 30)];
            ll.font = [UIFont systemFontOfSize:14];
            ll.text = @"此商品还没评价哦!!";
            [weakSelf.view addSubview:ll];
        }
        [weakSelf.LeftTableView reloadData];
    };
    
    [_ViewModel getFeastEvaluateDataWihtstr:self.ID];
}


- (void)createleftTableView{
    //**在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, self.view.height-225) style:UITableViewStylePlain];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 100;

  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        
        return self.array.count;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        static NSString *identifier = @"RFcell";
        SinglFaestCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"SinglFaestCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.array[indexPath.row];
        return cell;

    
    
}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    _FaestShowView = [[FaestShowHeaderView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH-120, 60)];
//    return _FaestShowView;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
