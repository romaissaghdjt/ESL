//
//  FaestShowHeaderView.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ChooseShowHeaderView.h"
#define Magin 10
@implementation ChooseShowHeaderView

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
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;


    _RecLable = [[UILabel alloc]initWithFrame:CGRectMake(Magin, 10, 50, 30)];
    _RecLable.text = @"推荐";
    _RecLable.layer.cornerRadius = 5;
    _RecLable.font = [UIFont systemFontOfSize:14];

    _RecLable.textAlignment = NSTextAlignmentCenter;
    _RecLable.layer.masksToBounds = YES;
    _RecLable.backgroundColor = ZXColor(255, 224, 66, 1);
    [self addSubview:_RecLable];
    
    _NameLable= [[UILabel alloc]initWithFrame:CGRectMake(_RecLable.right+Magin*2, _RecLable.y, W-_RecLable.width+Magin, Magin*3)];
    _NameLable.text = @"四人A套餐";
    _NameLable.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
//    _NameLable.backgroundColor = [UIColor redColor];
    [self addSubview:_NameLable];
    
    _PriceLable = [[UILabel alloc]initWithFrame:CGRectMake(_RecLable.x, _RecLable.bottom+Magin, _NameLable.width/3, _NameLable.height)];
    _PriceLable.textColor = [UIColor orangeColor];
//    _PriceLable.backgroundColor =[UIColor redColor];
    _PriceLable.text = @"¥1000";
    _SaValueLable.font = [UIFont systemFontOfSize:15];

    [self addSubview:_PriceLable];
    
    _SaValueLable = [[UILabel alloc]initWithFrame:CGRectMake(_PriceLable.right+Magin*2, _PriceLable.y, W-_PriceLable.width-Magin, _PriceLable.height)];
    _SaValueLable.textColor = [UIColor grayColor];
    _SaValueLable.text = @"月销量2272单";
    _SaValueLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:_SaValueLable];
    UIView*line = [[UIView alloc]initWithFrame:CGRectMake(0, H-1, W, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}
@end
