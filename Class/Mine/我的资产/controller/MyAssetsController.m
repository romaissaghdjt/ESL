//
//  MyAssetsController.m
//  ESL
//
//  Created by 徐恒 on 16/9/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyAssetsController.h"
#import "ESLAccountDetailViewController.h"
#import "ESLMyNetworkingManager.h"
#import "ESLMyPayViewController.h"
#import "ESLWithdrawViewController.h"

@interface MyAssetsController ()
@property (nonatomic, strong)UILabel *balanceNum;
@end

@implementation MyAssetsController

-(void)viewWillAppear:(BOOL)animated
{
    [ESLMyNetworkingManager getAccountBalanceWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSDictionary *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.balanceNum.text = [NSString stringWithFormat:@"%.02lf",[result[@"AccountValue"] floatValue]];
        }
    }];
}

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
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 150)];
    headerView.backgroundColor = ZXColor(60, 170, 40, 1);
    [self.view addSubview:headerView];
    
    UILabel *balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, KWIDTH, 20)];
    balanceLabel.textColor = [UIColor whiteColor];
    balanceLabel.text = @"余额账户（元）";
    [headerView addSubview:balanceLabel];
    
    self.balanceNum = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KWIDTH, 100)];
    self.balanceNum.textColor = [UIColor whiteColor];
    self.balanceNum.font = [UIFont boldSystemFontOfSize:60];
    [headerView addSubview:self.balanceNum];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, KWIDTH, 10)];
    grayView.backgroundColor = ZXColor(236, 236, 236, 1);
    [headerView addSubview:grayView];
}

-(void)creatBodyView
{
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 160 + 64, KWIDTH, 83)];
    bodyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bodyView];

    UIView *payView = [self creatViewWithFrame:CGRectMake(0, 0, KWIDTH, 40) Title:@"充值" UIImage:[UIImage imageNamed:@"充值"]];
    UITapGestureRecognizer *payTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payClick)];
    [payView addGestureRecognizer:payTap];
    [bodyView addSubview:payView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KWIDTH, 1)];
    
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [bodyView addSubview:lineView1];
    
    UIView *withdrawView = [self creatViewWithFrame:CGRectMake(0, 41, KWIDTH, 40) Title:@"提现" UIImage:[UIImage imageNamed:@"提现"]];
    UITapGestureRecognizer *withdrawTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(withdrawClick)];
    [withdrawView addGestureRecognizer:withdrawTap];
    [bodyView addSubview:withdrawView];
    
}
-(UIView *)creatViewWithFrame:(CGRect)frame Title:(NSString *)title UIImage:(UIImage *)image
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 50, 30)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 50, 40)];
    nameLabel.text = title;
    [view addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(KWIDTH - 38, 5, 30, 30)];
    arrowImage.image = [UIImage imageNamed:@"arrow_right"];
    arrowImage.contentMode = UIViewContentModeCenter;
    [view addSubview:arrowImage];
    return view;
}

-(void)detailsClick
{
    ESLAccountDetailViewController *advc = [[ESLAccountDetailViewController alloc]init];
    [self.navigationController pushViewController:advc animated:YES];
}
//充值
-(void)payClick
{
    ESLMyPayViewController *mpvc = [[ESLMyPayViewController alloc]init];
    [self.navigationController pushViewController:mpvc animated:YES];
}
//提现
-(void)withdrawClick
{
    ESLWithdrawViewController *wvc = [[ESLWithdrawViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

@end
