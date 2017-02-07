//
//  FaestShowHeaderView.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FaestShowHeaderView.h"
#define Magin 10
@implementation FaestShowHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self inintView];
        self.backgroundColor = ZXColor(204, 204, 203, 1);
    }
    return self;
}
- (void)inintView
{
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(4, 10, 80, 30)];
    lable.text = @"订单编号:";
    lable.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    lable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lable];
    _RecLable = [[UILabel alloc]initWithFrame:CGRectMake(lable.right-5, 10, 160, 30)];
    _RecLable.font = [UIFont systemFontOfSize:13];
    _RecLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_RecLable];
    
    
    _sate = [[UILabel alloc]initWithFrame:CGRectMake(self.right-70, _RecLable.y, _RecLable.width-Magin*2, _RecLable.height)];
    _sate.textColor = [UIColor orangeColor];
    _sate.font = [UIFont systemFontOfSize:13];
    [self addSubview:_sate];
    
    
    
}
@end
