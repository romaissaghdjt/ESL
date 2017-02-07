//
//  UIViewController+ShowMessage.m
//  YY
//
//  Created by 陈龙 on 16/7/25.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "UIViewController+ShowMessage.h"

@implementation UIViewController (ShowMessage)
+ (void)showMessage:(NSString *)message ViewController:(UIViewController *)viewController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [viewController presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
}
@end
