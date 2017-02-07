//
//  ESLHotViewController.m
//  ESL
//
//  Created by eyou on 16/9/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLHotViewController.h"
#import "PrsonFeastCell.h"
#import "ESLFeastDetailViewController.h"
#import "FeastAllModel.h"
#import "FeastAllViewModel.h"
@interface ESLHotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray*DataArray;
@property (nonatomic,strong)FeastAllViewModel*ViewModel;
@end

@implementation ESLHotViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人气套餐";
    [self createleftTableView];
    WK(weakSelf);
    
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    _ViewModel = [[FeastAllViewModel alloc]init];
    //开线程让耗时操作在后台操作
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    _ViewModel.DataSourceBlock = ^(id  DataSource){
    
        _DataArray =DataSource;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
            // 更新界面
            [weakSelf.tableView reloadData];

        });
    };
     });
    [_ViewModel getFeastAllData];
}

- (void)createleftTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT+50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ZXColor(230, 230, 232, 1);
    //分割线的颜色
    //[_tableView setSeparatorColor:[UIColor lightGrayColor ]];
    /**隐藏滚动条*/
    _tableView.showsVerticalScrollIndicator = NO;
    //去掉多余的分割线
    //[_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _DataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID = @"FasetCell";
    PrsonFeastCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"PrsonFeastCell" owner:nil options:nil].lastObject;
        
    }
          
    FeastAllModel*model = self.DataArray[indexPath.section];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLFeastDetailViewController*FDVC = [[ESLFeastDetailViewController alloc]init];
    FeastAllModel *model = self.DataArray[indexPath.section];
    FDVC.Allmodel = model;
    [self.navigationController pushViewController:FDVC animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];

}

@end
