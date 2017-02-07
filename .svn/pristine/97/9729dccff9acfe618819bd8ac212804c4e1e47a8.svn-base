//
//  ESLCookerViewController.m
//  ESL
//
//  Created by eyou on 16/9/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCookerViewController.h"
#import "ESLCookerNetworkingManager.h"
#import "ESLCookerListInfoCell.h"
#import "ESLSingleCookerModel.h"
#import "ESLCookerInfoViewController.h"

@interface ESLCookerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSArray *cookerList;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ESLCookerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"厨师列表";
    self.tabBarController.tabBar.hidden = YES;
    
    //导航条的颜色
//    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    [self creatTableView];
    [ESLCookerNetworkingManager getCookerListCompletionHandler:^(NSArray *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.cookerList = result;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cookerList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLSingleCookerModel *model = self.cookerList[indexPath.row];
    ESLCookerListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cookerListInfoCell"];
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ESLCookerListInfoCell" owner:nil options:nil].firstObject;
    }
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = model.name;
    cell.foodTypeLabel.text = model.goodAt;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KWIDTH*4/7.0 + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLSingleCookerModel *model = self.cookerList[indexPath.row];
    ESLCookerInfoViewController *civc = [[ESLCookerInfoViewController alloc]init];
    civc.cookerName = model.name;
    civc.cookID = model.ID;
    civc.isRecommend = NO;
    if ([model.isRecommend isEqualToString:@"是"]) {
        civc.isRecommend = YES;
    }
    [self.navigationController pushViewController:civc animated:YES];
}

@end
