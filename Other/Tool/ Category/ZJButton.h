//
//  ZJButton.h
//  YY
//
//  Created by 赵洁 on 16/7/6.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义block
typedef void(^ClickBnt)(UIButton*sender);
@interface ZJButton : UIButton
@property (nonatomic, copy)ClickBnt click;
+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString*)title image:(UIImage*)image textcolor:(UIColor*)textcolor click:(ClickBnt)click;
@end
