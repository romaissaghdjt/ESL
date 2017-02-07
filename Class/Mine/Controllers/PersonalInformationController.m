//
//  PersonalInformationController.m
//  ESL
//
//  Created by 徐恒 on 16/9/27.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "PersonalInformationController.h"
@interface PersonalInformationController ()
@property (nonatomic,strong)UIButton*OutLoginButton;
@end

@implementation PersonalInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _OutLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT-120, KWIDTH, 50)];
    [_OutLoginButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    _OutLoginButton.backgroundColor = [UIColor redColor];
    [_OutLoginButton addTarget:self action:@selector(outloginClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_OutLoginButton];
}
//退出登录
- (void)outloginClick
{
       
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
