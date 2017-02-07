//
//  ShowMessageTools.h
//  ShowMessageTools
//
//  Created by 赵洁 on 16/9/19.
//  Copyright © 2016年 jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DoClcik)();
typedef void(^CanclClcik)();

@interface ShowMessageTools : NSObject
@property (nonatomic,strong) DoClcik block;
@property (nonatomic,strong) CanclClcik canclblock;


+ (ShowMessageTools*)sharedInstance;
/**
 一个确定按钮
 */
- (void)showSimplMessage:(NSString*)message  controller:(UIViewController*)co;
/**
 需要对弹出框操作的用block这个方法
 */
- (void)showMessage:(NSString*)message controller:(UIViewController*)co block:(DoClcik)block canclblock:(CanclClcik)canclblock;
/**
 确定按钮*/
- (void)showMessageBack:(NSString*)message controller:(UIViewController*)co block:(DoClcik)block ;
@end
