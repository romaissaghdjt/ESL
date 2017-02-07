//
//  AppDelegate.h
//  ESL
//
//  Created by eyou on 16/9/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString *appKey = @"1e3d7f38cd8e3c824fbfa4c5";
static NSString *channel = @"App Store";
static BOOL isProduction = NO;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

