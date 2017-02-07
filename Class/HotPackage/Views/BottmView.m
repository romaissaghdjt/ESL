//
//  BottmView.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "BottmView.h"

@implementation BottmView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
- (void)layoutSubviews
{
    

}
- (void)initView
{
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;

    _JoinShopCarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W/2, H)];
    _JoinShopCarButton.backgroundColor = ZXColor(55, 178, 34, 1);
    [_JoinShopCarButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    [self addSubview:_JoinShopCarButton];
    _BuyNowBuuton = [[UIButton alloc]initWithFrame:CGRectMake(_JoinShopCarButton.right, 0, W-_JoinShopCarButton.width, H)];
    _BuyNowBuuton.backgroundColor = ZXColor(255, 148, 3, 1);
    [_BuyNowBuuton setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [self addSubview:_BuyNowBuuton];
    //[UIFont familyNames];
    
}
@end
