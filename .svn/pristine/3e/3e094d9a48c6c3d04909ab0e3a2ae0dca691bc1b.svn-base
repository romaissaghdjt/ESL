//
//  StarFeastController.m
//  YY
//
//  Created by 赵洁 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "StarFeastController.h"
#import "StarCell.h"
#import "FeastNameCell.h"
#import "FeastDtiallController.h"
#import "StartFeastModel.h"
#import "StartModel.h"
#import "ZXFeastController.h"

@interface StarFeastController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *LeftTableView;
@property (strong, nonatomic)UITableView *RightTableView;
@property (strong, nonatomic)NSMutableArray* aray;
@property (strong, nonatomic)NSMutableArray *dataAarray;
@property (nonatomic, assign)BOOL isFirst;
@property (nonatomic)BOOL select;
@end

@implementation StarFeastController
-(void)dealloc
{
    self.LeftTableView.delegate = nil;
    self.RightTableView.delegate = nil;
    self.LeftTableView.dataSource = nil;
    self.RightTableView.dataSource = nil;
}
- (NSMutableArray *)aray
{
    if (!_aray) {
        _aray = [NSMutableArray array];
    }
    return _aray;
}
- (NSMutableArray *)dataAarray
{
    if (!_dataAarray) {
        _dataAarray = [NSMutableArray array];
    }
    return _dataAarray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = YES;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.select = YES;
    self.isFirst = YES;
    self.title = @"喜宴套餐";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    [self creatView];
    [self createleftTableView];
    [self createrightTableView];
    //[self requestLeft];
    [self request:3];

    //********************************************
    NSInteger topCellSection = [[[self.LeftTableView indexPathsForVisibleRows]firstObject]section];
    [self.LeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //*******************************************
    

}
- (void)creatView
{
    UILabel *LgreenLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, KWIDTH/2, 40)];
    LgreenLable.backgroundColor = [UIColor whiteColor];
    LgreenLable.text = @"星级";
    LgreenLable.textColor = ZXColor(83, 162, 38, 1);
    LgreenLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LgreenLable];
    UILabel *RgreenLable = [[UILabel alloc]initWithFrame:CGRectMake(KWIDTH/2, 64, KWIDTH/2, 40)];
    RgreenLable.backgroundColor = [UIColor whiteColor];
    RgreenLable.text = @"套餐名称";
    RgreenLable.textColor = ZXColor(83, 162, 38, 1);
    RgreenLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:RgreenLable];
    UIView*line = [[UIView alloc]initWithFrame:CGRectMake(0, 102, KWIDTH, 1)];
    line.backgroundColor = ZXColor(236, 236, 236, 1);
    [self.view addSubview:line];
    
}
- (void)createleftTableView{
    //**在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 120*SWIDTH_SCALE, KHEIGHT-104) style:UITableViewStylePlain];
    
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.backgroundColor = [UIColor whiteColor];
    //分割线的颜色
    [_LeftTableView setSeparatorColor:[UIColor grayColor ]];
    /**隐藏滚动条*/
    _LeftTableView.showsVerticalScrollIndicator = NO;
    //去掉多余的分割线
    [_LeftTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:_LeftTableView];
}
- (void)createrightTableView{
    _RightTableView = [[UITableView alloc]initWithFrame:CGRectMake(115,106, 250*SWIDTH_SCALE, KHEIGHT-106) style:UITableViewStylePlain];
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
- (void)requestLeft
{
   
    [zJRequestManager requestWithUrl:[WeddURL stringByAppendingString: @"MenuHandler.ashx?Action=getStarLevels"] parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        NSArray *key = dic[@"星级"];
        
        for (NSDictionary*dics in key) {
            StartModel *model = [[StartModel alloc]init];
            [model setValuesForKeysWithDictionary:dics];
            [self.dataAarray addObject:model];
        }
//        [self.view hideBusyHUD];
        [self.LeftTableView reloadData];
        if (self.isFirst) {
            NSInteger topCellSection = [[[self.LeftTableView indexPathsForVisibleRows]firstObject]section];
            [self.LeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
#define 数据请求
- (void)request:(NSInteger)count
{
    
    NSString *Url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FeastSetMeal&Function=HttpQueryAllEntitys&StarLevel=%ld"],count];
    NSLog(@"%@",Url);
    [zJRequestManager requestWithUrl:Url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (array.count == 0) {
            NSLog(@"为空===================================");
            return ;
        }
        self.aray = [NSMutableArray array];
        for (NSDictionary*dic in array) {
            StartFeastModel *model = [[StartFeastModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.aray addObject:model];
        }
        [self.RightTableView reloadData];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        return 120;
    }else if ([tableView isEqual:_RightTableView]){
        return 70;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_LeftTableView]) {
        return 4;
    }else if ([tableView isEqual:_RightTableView]){

        
        if (self.select == NO) {
            return 1;
        }
        if (_aray.count == 0) {
            return 0;
        }else{
            return _aray.count;
        }
        
    }
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_LeftTableView]) {
        
        static NSString *identifier = @"mycell";
        StarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"StarCell" owner:nil options:nil].firstObject;
            //改变cell被点击时候的颜色*************************
            cell.backgroundColor = ZXColor(240, 240, 240,1);
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectedBackgroundView;
            //****************************************
            // 左侧示意条
            UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 6, 120)];
            liner.backgroundColor = [UIColor orangeColor];
            [selectedBackgroundView addSubview:liner];            
        }
        if (indexPath.row == 0) {
            cell.StarLable.text = @"三星级";
            cell.StarImg.image = [UIImage imageNamed:@"three_start_select.png"];
        }else if (indexPath.row == 1)
        {
            cell.StarLable.text = @"四星级";
            cell.StarImg.image = [UIImage imageNamed:@"four_start_select.png"];
        }else if (indexPath.row == 2)
        {
            cell.StarLable.text = @"五星级";
            cell.StarImg.image = [UIImage imageNamed:@"five_start_select.png"];
        }else
        {
            cell.StarLable.text = @"自选套餐";
        }
        return cell;
    }
    
    else 
    {
        static NSString *identifier = @"mycell";
        FeastNameCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[NSBundle mainBundle]loadNibNamed:@"FeastNameCell" owner:nil options:nil].firstObject;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        cell.img.layer.cornerRadius = 6;
        cell.img.layer.masksToBounds = YES;
        if (self.select == NO) {
            cell.img.image = [UIImage imageNamed:@"zixuantaocan.jpg"];
            cell.TitleLable.text = @"自选套餐";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.isFirst = NO;
           
            
        }else{
            StartFeastModel *model = _aray[indexPath.row];
            [cell.img sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
            //cell.img.layer.cornerRadius = 20;
            cell.TitleLable.text = model.Name;
            self.isFirst = YES;

            
        }
       return cell;
    }
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_LeftTableView]) {
        if (indexPath.row <3 ) {
            [self request:indexPath.row+3];
            [self.RightTableView reloadData];
            self.select = YES;
        }else{
            self.select = NO;
            
            [self.RightTableView reloadData];
            
        }
        
    }else
    {
        if (self.isFirst == YES) {
            FeastDtiallController *FDVC = [[FeastDtiallController alloc]init];
            StartFeastModel *model = _aray[indexPath.row];
            FDVC.model =model;
            [self.navigationController pushViewController:FDVC animated:YES];
        }else{
            ZXFeastController *FDVC = [[ZXFeastController alloc]init];
            
            [self.navigationController pushViewController:FDVC animated:YES];
        }
    }
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
