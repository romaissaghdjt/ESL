//
//  XHCollectionCell.m
//  YY
//
//  Created by 徐恒 on 16/4/22.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHCollectionCell.h"

@implementation XHCollectionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int i = 0; i < 5; i++) {
            UIButton*bb = [[UIButton alloc]initWithFrame:CGRectMake(i*(KWIDTH-120)/5+20*(i+1), 20, (KWIDTH-120)/5, (KWIDTH-120)/5 + 20)];
            bb.contentMode = UIViewContentModeScaleAspectFit;
            bb.tag = 100+i;
            [self.contentView addSubview:bb];
        }
        self.XiYanBtn = [self.contentView viewWithTag:100];
        [self.XiYanBtn setBackgroundImage:[UIImage imageNamed:@"xiyan.png"] forState:(UIControlStateNormal)];
        self.ChuJuBtn = [self.contentView viewWithTag:101];
        [self.ChuJuBtn setBackgroundImage:[UIImage imageNamed:@"canju.png"] forState:(UIControlStateNormal)];
        
        self. HunQingBtn= [self.contentView viewWithTag:102];
        [self.HunQingBtn setBackgroundImage:[UIImage imageNamed:@"hunqing.png"] forState:(UIControlStateNormal)];
        
        self.XiShiTangBtn = [self.contentView viewWithTag:103];
        [self.XiShiTangBtn setBackgroundImage:[UIImage imageNamed:@"xishitang.png"] forState:(UIControlStateNormal)];
        
        self.AnLieBtn = [self.contentView viewWithTag:104];
        [self.AnLieBtn setBackgroundImage:[UIImage imageNamed:@"shili.png"] forState:(UIControlStateNormal)];

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%f%f",self.width,self.contentView.width);

}
@end
