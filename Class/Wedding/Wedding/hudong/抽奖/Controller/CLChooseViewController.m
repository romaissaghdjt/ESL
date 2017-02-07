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
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发起抽奖
- (IBAction)startLottery:(id)sender {
    CLLotteryViewController *lvc = [[CLLotteryViewController alloc]initWithNibName:@"CLLotteryViewController" bundle:nil];
    [self.navigationController pushViewController:lvc animated:YES];
}
//参与抽奖
- (IBAction)joinLottery:(id)sender {
    CLParticipateViewController *pvc = [[CLParticipateViewController alloc]initWithNibName:@"CLParticipateViewController" bundle:nil];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
