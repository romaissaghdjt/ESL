//
//  CLChooseViewController.m
//  YY
//
//  Created by 陈龙 on 16/7/14.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLChooseViewController.h"
#import "CLLotteryViewController.h"
#import "CLParticipateViewController.h"

@interface CLChooseViewController ()

@end

@implementation CLChooseViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(40*SCREEN_SCALE, 120*SCREEN_DCALE, 60, 30)];
    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    //发起抽奖按钮
    UIButton *launchButton = [[UIButton alloc]initWithFrame:CGRectMake(95*SCREEN_SCALE, 210*SCREEN_DCALE, 185*SCREEN_SCALE, 60*SCREEN_DCALE)];
    [launchButton addTarget:self action:@selector(startLottery:) forControlEvents:UIControlEventTouchUpInside];
    [launchButton setImage:[UIImage imageNamed:@"发起抽奖"] forState:UIControlStateNormal];
    [self.view addSubview:launchButton];
    //我要报名按钮
    UIButton *applyButton = [[UIButton alloc]initWithFrame:CGRectMake(95*SCREEN_SCALE, 330*SCREEN_DCALE, 185*SCREEN_SCALE, 60*SCREEN_DCALE)];
    [applyButton addTarget:self action:@selector(joinLottery:) forControlEvents:UIControlEventTouchUpInside];
    [applyButton setImage:[UIImage imageNamed:@"我要报名"] forState:UIControlStateNormal];
    [self.view addSubview:applyButton];
    
    //说明
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 * SCREEN_SCALE, 460*SCREEN_DCALE, 355*SCREEN_SCALE, 130*SCREEN_DCALE)];
    imageView.image = [UIImage imageNamed:@"说明"];
    [self.view addSubview:imageView];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发起抽奖
- (void)startLottery:(id)sender {
    CLLotteryViewController *lvc = [[CLLotteryViewController alloc]initWithNibName:@"CLLotteryViewController" bundle:nil];
    [self presentViewController:lvc animated:YES completion:nil];
}
//参与抽奖
- (void)joinLottery:(id)sender {
    CLParticipateViewController *pvc = [[CLParticipateViewController alloc]initWithNibName:@"CLParticipateViewController" bundle:nil];
    [self presentViewController:pvc animated:YES completion:nil];
}

- (void)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
