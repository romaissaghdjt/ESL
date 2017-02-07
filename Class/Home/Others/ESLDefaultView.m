//
//  ESLDefaultView.m
//  ESL
//
//  Created by eyou on 16/12/15.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLDefaultView.h"

@implementation ESLDefaultView

+(ESLDefaultView * )getDefaultView
{
    static dispatch_once_t pred;
    static ESLDefaultView *defaultView;
    dispatch_once(&pred, ^{
        defaultView = [[ESLDefaultView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        defaultView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KWIDTH - 210*SWIDTH_SCALE)/2.0,(KHEIGHT - 220*SHEIGHT_DCALE)/3.0, 210*SWIDTH_SCALE, 220*SHEIGHT_DCALE)];
        imageView.image = [UIImage imageNamed:@"404"];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((KWIDTH - 100 * SWIDTH_SCALE)/2.0, imageView.y+imageView.height + 60 * SHEIGHT_DCALE, 100 * SWIDTH_SCALE, 40 *SHEIGHT_DCALE)];
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        btn.layer.borderColor = ZXColor(60, 170, 40, 1).CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [btn setTitleColor:ZXColor(60, 170, 40, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickReloadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [defaultView addSubview:btn];
        [defaultView addSubview:imageView];
        
    });
    return defaultView;
}

-(void)clickReloadBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(defaultViewBtnClick)]) {
        [self.delegate defaultViewBtnClick];
    }
}
@end
