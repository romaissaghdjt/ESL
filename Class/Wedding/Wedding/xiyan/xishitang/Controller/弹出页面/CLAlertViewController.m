//
//  CLAlertViewController.m
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"

@interface CLAlertViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation CLAlertViewController
//要让弹出效果在iPhone下生效
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection{
    return UIModalPresentationNone;
}


- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize Array:(NSArray *)array{
    self = [super init];
    if (self) {
        _sourceRect = sourceRect;
        _contentSize = contentSize;
        _sourceView = sourceView;
        _array = array;
        //设置当前控制器的弹出方式是popover
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.sourceView = _sourceView;
        self.popoverPresentationController.sourceRect = _sourceRect;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置self.view弹出后的大小
    self.preferredContentSize = _contentSize;
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

