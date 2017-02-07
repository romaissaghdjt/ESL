
//
//  ToEvaluateController.m
//  ESL
//
//  Created by 徐恒 on 16/9/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ToEvaluateController.h"

@interface ToEvaluateController ()

@end

@implementation ToEvaluateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"待评价";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
