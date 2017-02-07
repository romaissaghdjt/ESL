//
//  CarController.m
//  YY
//
//  Created by 赵洁 on 16/7/19.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CarController.h"
#import "CarCompanyViewController.h"
#import "CarInformationViewController.h"
#import "MarriageCarController.h"
#import "AdornViewController.h"

@interface CarController ()
@property (nonatomic,strong)AdornViewController *CarCVC;
@end

@implementation CarController
- (void)dealloc
{
    self.carDuibutton = nil;
    self.bgimg = nil;
    self.zhuangshibutton = nil;
    self.CarCVC = nil;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
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
    self.title = @"婚车";
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    self.compnybutton.layer.borderWidth = 5;
    self.compnybutton.layer.cornerRadius = 10;
    self.compnybutton.layer.masksToBounds = YES;
    self.compnybutton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.carDuibutton.layer.borderWidth = 5;
    self.carDuibutton.layer.cornerRadius = 10;
    self.carDuibutton.layer.masksToBounds = YES;
    self.carDuibutton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.zhuangshibutton.layer.borderWidth = 5;
    self.zhuangshibutton.layer.cornerRadius = 10;
    self.zhuangshibutton.layer.masksToBounds = YES;
    self.zhuangshibutton.layer.borderColor = [UIColor whiteColor].CGColor;

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)comCilck:(id)sender {
//    CarInformationViewController *carInFor= [[CarInformationViewController alloc]init];
//    [self.navigationController pushViewController:carInFor animated:YES];
}
- (IBAction)carduicilck:(id)sender {
    MarriageCarController *CarCVC = [[MarriageCarController alloc]init];
    [self.navigationController pushViewController:CarCVC animated:YES];
}
- (IBAction)zhuangshiClick:(id)sender {
    _CarCVC = [[AdornViewController alloc]init];
    [self.navigationController pushViewController:_CarCVC animated:YES];
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
