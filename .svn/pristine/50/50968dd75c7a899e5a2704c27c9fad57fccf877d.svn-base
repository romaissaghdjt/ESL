//
//  ZJButton.m
//  YY
//
//  Created by 赵洁 on 16/7/6.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ZJButton.h"

@implementation ZJButton
+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title image:(UIImage *)image textcolor:(UIColor*)textcolor click:(ClickBnt)click
{
    ZJButton *button = [super buttonWithType:buttonType];
    button.frame = frame;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:textcolor forState:(UIControlStateNormal)];
    button.imageView.contentMode = UIViewContentModeCenter;
    [button setTitle:title forState:(UIControlStateNormal)];
    button.click = click;
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}

- (void)buttonClick:(UIButton*)sender
{
    if (self.click) {
        self.click(sender);
    }
}
@end
