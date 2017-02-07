//
//  ESLBagListViewController.m
//  ESL
//
//  Created by eyou on 17/1/16.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLBagListViewController.h"
#import "ESLBagNetManager.h"
#import "ESLSingleFoodCell.h"
#import "ESLBagViewController.h"

@interface ESLBagListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *bagArray;

@end

@implementation ESLBagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"海鲜大礼包";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self creatHeaderView];
    [ESLBagNetManager getBagWithCompletionHandler:^(NSArray *bagArray, NSError *error) {
        if (error) {
            [self.view showWarning:@"服务器繁忙"];
        }
        else
        {
            self.bagArray = bagArray;
            [self.tableView reloadData];
        }
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatHeaderView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 120* SCREEN_DCALE + 8)];
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 120* SCREEN_DCALE)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:nil];
    [view addSubview:headerView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 120* SCREEN_DCALE, KWIDTH, 8)];
    lineView.backgroundColor = ZXColor(241, 241, 241, 1);
    [view addSubview:lineView];
    self.tableView.tableHeaderView = view;
}

-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bagArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLBagModel *bagModel = self.bagArray[indexPath.row];
    ESLSingleFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singleFoodCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ESLSingleFoodCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setValueWithModel:bagModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLBagModel *bagModel = self.bagArray[indexPath.row];
    ESLBagViewController *fivc = [[ESLBagViewController alloc]init];
    fivc.ID = bagModel.BaseDate.ID;
    [self.navigationController pushViewController:fivc animated:YES];
}

@end
