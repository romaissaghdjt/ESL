//
//  MyAssetsController.m
//  ESL
//
//  Created by 徐恒 on 16/9/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyAssetsController.h"
#import "ESLAccountDetailViewController.h"

@interface MyAssetsController ()

@end

@implementation MyAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的资产";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = ZXColor(236, 236, 236, 1);
    [self creatHeaderView];
    [self creatBodyView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(detailsClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 150)];
    headerView.backgroundColor = ZXColor(60, 170, 40, 1);
    [self.view addSubview:headerView];
    
    UILabel *balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, KWIDTH, 20)];
    balanceLabel.textColor = [UIColor whiteColor];
    balanceLabel.text = @"余额账户（元）";
    [headerView addSubview:balanceLabel];
    
    UILabel *balanceNum = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KWIDTH, 100)];
    balanceNum.textColor = [UIColor whiteColor];
    balanceNum.text = @"6823.88";
    balanceNum.font = [UIFont boldSystemFontOfSize:60];
    [headerView addSubview:balanceNum];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, KWIDTH, 10)];
    grayView.backgroundColor = ZXColor(236, 236, 236, 1);
    [headerView addSubview:grayView];
}

-(void)creatBodyView
{
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, KWIDTH, 83)];
    bodyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bodyView];

    UIView *payView = [self creatViewWithFrame:CGRectMake(0, 0, KWIDTH, 40) Title:@"充值"];
    [bodyView addSubview:payView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KWIDTH, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [bodyView addSubview:lineView1];
    
    UIView *withdrawView = [self creatViewWithFrame:CGRectMake(0, 41, KWIDTH, 40) Title:@"提现"];
    [bodyView addSubview:withdrawView];
    
}
-(UIView *)creatViewWithFrame:(CGRect)frame Title:(NSString *)title
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 50, 30)];
    imageView.backgroundColor = [UIColor redColor];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 50, 40)];
    nameLabel.text = title;
    [view addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(KWIDTH - 38, 5, 30, 30)];
    arrowImage.backgroundColor = [UIColor redColor];
    [view addSubview:arrowImage];
    return view;
}

-(void)detailsClick
{
    ESLAccountDetailViewController *advc = [[ESLAccountDetailViewController alloc]init];
    [self.navigationController pushViewController:advc animated:YES];
}

@end
