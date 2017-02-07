//
//  CLAlertViewController.h
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAlertViewController : UIViewController
//弹出的控制器需要知道从哪个视图,哪个位置弹出来,弹出的内容多大.
- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize Array:(NSArray *)array;
/** <#属性#> */
@property (nonatomic, readonly) CGSize contentSize;
/** <#属性#> */
@property (nonatomic, readonly) CGRect sourceRect;
/** <#属性#> */
@property (nonatomic, readonly) UIView *sourceView;

@property (nonatomic, strong)NSArray *array;

@end
