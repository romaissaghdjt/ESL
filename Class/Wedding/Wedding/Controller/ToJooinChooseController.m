//
//  ToJooinChooseController.m
//  YY
//
//  Created by 赵洁 on 16/7/13.
//  Copyright © 2016年 徐恒. All rights reserved.
//公司上传

#import "ToJooinChooseController.h"

@interface ToJooinChooseController ()
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;

@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIButton *YinYButton;
@property (strong, nonatomic) IBOutlet UIButton *ZuZhiButton;
@property (strong, nonatomic) IBOutlet UIButton *XuKeButton;
@property (strong, nonatomic) IBOutlet UIButton *ShuiWuButton;

@property (strong, nonatomic) IBOutlet UIButton *ToJoinButton;

@end

@implementation ToJooinChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.title =@"公司加盟";
    [self DoView];
}
- (void)DoView
{
    _view1.layer.cornerRadius = 10;
    _view2.layer.cornerRadius = 10;
    
    _view3.layer.cornerRadius = 10;
    
    _view4.layer.cornerRadius = 10;
    _YinYButton.layer.cornerRadius = 10;
    _ZuZhiButton.layer.cornerRadius = 10;

    _ShuiWuButton.layer.cornerRadius = 10;

    _XuKeButton.layer.cornerRadius = 10;

}
- (IBAction)ToJoinClick:(id)sender {
    NSLog(@"jjjj");
}
- (IBAction)YinYeClick:(id)sender {
    NSLog(@"jjjj");

}
- (IBAction)JiGClick:(id)sender {
    NSLog(@"jjjj");

}
- (IBAction)XuKeClick:(id)sender {
    NSLog(@"jjjj");

}
- (IBAction)ShuiWuClick:(id)sender {
    NSLog(@"jjjj");

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
