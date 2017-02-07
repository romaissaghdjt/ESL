//
//  ShowMessageTools.m
//  ShowMessageTools
//
//  Created by 赵洁 on 16/9/19.
//  Copyright © 2016年 jie. All rights reserved.
//

#import "ShowMessageTools.h"

@implementation ShowMessageTools

+(ShowMessageTools *)sharedInstance
{
    static ShowMessageTools*tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[ShowMessageTools alloc]init];
        
    });
    return tools;
}
-(void)showSimplMessage:(NSString *)message controller:(UIViewController*)co
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [co presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
}
-(void)showMessage:(NSString *)message controller:(UIViewController*)co block:(DoClcik)block canclblock:(CanclClcik)canclblock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
     [co presentViewController:alert animated:YES completion:nil];
    self.block = block;
    self.canclblock = canclblock;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        block();
    }];
    [alert addAction:cancelAction];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        canclblock();
    }];
    [alert addAction:cancelAction1];
}
- (void)showMessageBack:(NSString *)message controller:(UIViewController *)co block:(DoClcik)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [co presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        block();
    }];
    
    [alert addAction:cancelAction];
}
@end
