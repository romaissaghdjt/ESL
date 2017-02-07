//
//  CLStyleViewController.h
//  YY
//
//  Created by 陈龙 on 16/7/13.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"

@interface CLStyleViewController : CLAlertViewController
@property (nonatomic, copy) void(^chooseBlock)(NSString *style);
@end
