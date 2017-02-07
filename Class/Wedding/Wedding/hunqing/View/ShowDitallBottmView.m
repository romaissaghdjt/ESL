//
//  ShowDitallBottmView.m
//  YY
//
//  Created by 赵洁 on 16/6/24.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ShowDitallBottmView.h"

@implementation ShowDitallBottmView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}
- (void)loadView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 30)];
    lable.text = @"套餐价格:";
    [self addSubview:lable];
    self.PriceLable = [[UILabel alloc]initWithFrame:CGRectMake(lable.right, lable.y, lable.width+20, lable.height)];
    self.PriceLable.text = @"你还没有选哦!";
    self.PriceLable.font = [UIFont systemFontOfSize:14];
    self.PriceLable.textColor = [UIColor orangeColor];
    [self addSubview:self.PriceLable];
    self.YDButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.YDButton.frame = CGRectMake(self.width-110,0, 110, self.height);
    self.YDButton.backgroundColor = ZXColor(217, 91, 115, 1);
    [self.YDButton setTitle:@"我要预约" forState:(UIControlStateNormal)];
    [self.YDButton addTarget:self action:@selector(reservationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.YDButton];
}

//点击日历按钮
-(void)reservationClick:(UIButton *)sender
{
    if ([_delgate respondsToSelector:@selector(reservationClick)]) {
        [_delgate reservationClick];
    }
}

@end
