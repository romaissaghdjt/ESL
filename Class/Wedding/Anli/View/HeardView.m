//
//  HeardView.m
//  YY
//
//  Created by 赵洁 on 16/8/6.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "HeardView.h"

@implementation HeardView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}
- (void)loadView
{
//    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 2, 20)];
//    colorLabel.backgroundColor =[UIColor greenColor];
//    [self addSubview:colorLabel];
//    UILabel *mLabe = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 40, 20)];
//    mLabe.text = @"描述";
//    [self addSubview:mLabe];
//    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.width, 100)];
//    contentLabel.numberOfLines = 0;
//    [self addSubview:contentLabel];
   // contentLabel.text = @"hkhj" ;
//    self.RemarkLable = contentLabel;
//    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, self.width, 20)];
//    //priceLabel.text = @"总价为58888元.";
//    [self addSubview:priceLabel];
//    self.PriceLable = priceLabel;
//    //priceLabel.text = @"khhkh" ;
//    
//    UILabel *gLbale = [[UILabel alloc]initWithFrame:CGRectMake(10, 135, 2, 20)];
//    gLbale.backgroundColor = [UIColor greenColor];
//    [self addSubview:gLbale];
    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 70,30)];
    aLabel.text = @"图片展示";
    aLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:aLabel];
}

@end
