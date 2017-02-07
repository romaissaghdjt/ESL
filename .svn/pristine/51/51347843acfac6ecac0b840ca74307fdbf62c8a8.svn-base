//
//  ToJoinChooseController.m
//  YY
//
//  Created by 赵洁 on 16/7/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ToJoinChooseController.h"
#import "ToJoinInController.h"
#import "ToJoinCookChooseController.h"
@interface ToJoinChooseController ()
@property (strong, nonatomic) IBOutlet UIButton *CompnyButton;
@property (strong, nonatomic) IBOutlet UIButton *CookButton;

@end

@implementation ToJoinChooseController
-(void)dealloc
{
    self.CompnyButton = nil;
    self.CookButton = nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    
   self.title = @"加盟";
    self.tabBarController.tabBar.hidden = YES;
    self.CompnyButton.layer.borderWidth= 4;
    self.CompnyButton.layer.cornerRadius = 8;
    self.CompnyButton.layer.masksToBounds = YES;
    self.CompnyButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.CookButton.layer.borderWidth= 4;
    self.CookButton.layer.cornerRadius = 8;
    self.CookButton.layer.masksToBounds = YES;
    self.CookButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
}
- (IBAction)CompnyClick:(id)sender {
    ToJoinInController*compnyVC = [[ToJoinInController alloc]init];
    compnyVC.string = @"公司加盟";
    [self.navigationController pushViewController:compnyVC animated:YES];
    
}
- (IBAction)CookClick:(id)sender {
    ToJoinCookChooseController *CookVC = [[ToJoinCookChooseController alloc]init];
    CookVC.str = @"厨师加盟";
    [self.navigationController pushViewController:CookVC animated:YES];
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
