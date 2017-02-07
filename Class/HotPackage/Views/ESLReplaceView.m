//
//  ESLReplaceView.m
//  ESL
//
//  Created by eyou on 17/2/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLReplaceView.h"

@implementation ESLReplaceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *hiddenView = [[UIView alloc]initWithFrame:frame];
        hiddenView.backgroundColor = [UIColor blackColor];
        [self addSubview:hiddenView];
        UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenClick)];
        [hiddenView addGestureRecognizer:hiddenTap];
        hiddenView.alpha = 0.5;
        
        UIView *replaceView = [[UIView alloc]initWithFrame:CGRectMake((KWIDTH-250*SCREEN_SCALE)/2.0, (KHEIGHT-300*SCREEN_DCALE)/2.0, 250*SCREEN_SCALE, 300*SCREEN_DCALE)];
        replaceView.layer.cornerRadius = 20*SCREEN_SCALE;
        replaceView.layer.masksToBounds = YES;
        replaceView.backgroundColor = [UIColor whiteColor];
        [self addSubview:replaceView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250*SCREEN_SCALE, 40*SCREEN_DCALE)];
        titleLabel.text = @"替换菜品";
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.backgroundColor = ZXColor(206, 206, 206, 1);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [replaceView addSubview:titleLabel];
        for (int i = 0; i < 3; i++) {
            UIView *optionView = [self creatOptionViewWithFrame:CGRectMake(30*SCREEN_SCALE, 50*SCREEN_DCALE+i*60*SCREEN_DCALE, 250*SCREEN_SCALE, 60*SCREEN_DCALE) index:i];
            [replaceView addSubview:optionView];
        }
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake((250*SCREEN_SCALE-180*SCREEN_SCALE)/2.0, 300*SCREEN_DCALE-60*SCREEN_DCALE, 180*SCREEN_SCALE, 40*SCREEN_DCALE)];
        [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = ZXColor(55, 178, 34, 1);
        _nextBtn.layer.cornerRadius = 5*SCREEN_DCALE;
        _nextBtn.layer.masksToBounds = YES;
        [replaceView addSubview:_nextBtn];
        
    }
    return self;
}

-(UIView *)creatOptionViewWithFrame:(CGRect)frame index:(NSInteger)index
{
    UIView *optionView = [[UIView alloc]initWithFrame:frame];
    
    UIButton *optionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15*SCREEN_DCALE, 30*SCREEN_SCALE, 30*SCREEN_DCALE)];
    [optionBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
    [optionBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [optionView addSubview:optionBtn];
    [optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    optionBtn.tag = index + 100;
    if (index == 0) {
        optionBtn.selected = YES;
    }
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(40*SCREEN_SCALE, 5*SCREEN_DCALE, 50*SCREEN_SCALE, 50*SCREEN_DCALE)];
    iconImage.backgroundColor = [UIColor redColor];
    [optionView addSubview:iconImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*SCREEN_SCALE, 5*SCREEN_DCALE, 250*SCREEN_SCALE - 100*SCREEN_SCALE, 25*SCREEN_DCALE)];
    nameLabel.text = @"特级海蜇";
    [optionView addSubview:nameLabel];
    
    UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*SCREEN_SCALE, 30*SCREEN_DCALE, 250*SCREEN_SCALE - 100*SCREEN_SCALE, 25*SCREEN_DCALE)];
    weightLabel.text = @"约350克";
    weightLabel.textColor = ZXColor(230, 146, 35, 1);
    [optionView addSubview:weightLabel];
    
    return optionView;
    
}

-(void)hiddenClick
{
    self.hidden = YES;
}

-(void)optionBtnClick:(UIButton *)sender
{
    for (int i = 100; i < 103; i++) {
        UIButton *btn = [self viewWithTag:i];
        btn.selected = NO;
    }
    sender.selected = YES;
}

@end
