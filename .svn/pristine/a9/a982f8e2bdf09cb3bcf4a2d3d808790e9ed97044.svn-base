

#import "UIView+HUD.h"
//自己写的宏定义要用小k开头,以区分系统级别的宏
#define kShowWarningDelayDuration   1
#define kTimeoutDuration 15

@implementation UIView (HUD)

- (void)showWarning:(NSString *)words{
    //为使用者考虑, 如果子线程执行此方法会崩溃, 我们要把方法做成线程安全的.
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = words;
        hud.label.textColor = [UIColor whiteColor];
        hud.color = [UIColor blackColor];
        hud.alpha = 1;
        [hud hideAnimated:YES afterDelay:kShowWarningDelayDuration];
    });
}
- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [[MBProgressHUD showHUDAddedTo:self animated:YES] hideAnimated:YES afterDelay:kTimeoutDuration];
    });
}
- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    });

}

@end







