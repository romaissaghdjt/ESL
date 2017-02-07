//
//  SectionView.m
//  YY
//
//  Created by 赵洁 on 16/7/11.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (KWIDTH)/6, 50)];
        //self.img.backgroundColor = [UIColor redColor];
        [self addSubview:self.img];
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(self.img.right+5, self.img.y+10,(KWIDTH-90)/5+20, 30)];
//      self.lable.backgroundColor = [UIColor grayColor];
        self.lable.font = [UIFont systemFontOfSize:13.7];
        
        [self addSubview:self.lable];
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(self.lable.right, self.lable.y, self.lable.width-18, self.lable.height)];
        self.price.font = [UIFont systemFontOfSize:14];
//        self.price.backgroundColor = [UIColor redColor];
        self.price.textColor = [UIColor orangeColor];
        
        [self addSubview:self.price];
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH-100-(KWIDTH/8), self.price.y, (KWIDTH-100)/6, 30)];
        [self.button setTitle:@"替换" forState:(UIControlStateNormal)];
        self.button.titleLabel.font = [UIFont systemFontOfSize:15];
       // self.button.backgroundColor = [UIColor orangeColor];
        [self.button setTitleColor:ZXColor(85, 172, 56, 1) forState:(UIControlStateNormal)];
        [self addSubview:self.button];
    }
    return self;
}
@end
