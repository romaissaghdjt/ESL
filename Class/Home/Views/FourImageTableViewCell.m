//
//  FourImageTableViewCell.m
//  ESL
//
//  Created by eyou on 16/9/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FourImageTableViewCell.h"

@implementation FourImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.height = 80;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initContentWithStr:(NSString *)string
{
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KWIDTH * 0.25, (KWIDTH - 25) * 0.25)];
    self.btn1.tag = 11;
    [self.btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH * 0.25, 0, KWIDTH * 0.25, (KWIDTH - 25) * 0.25)];
    self.btn2.tag = 12;
    [self.btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH * 0.5, 0, KWIDTH * 0.25, (KWIDTH - 25) * 0.25)];
    self.btn3.tag = 13;
    [self.btn3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn4 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH * 0.75, 0, KWIDTH * 0.25, (KWIDTH - 25) * 0.25)];
    self.btn4.tag = 14;
    [self.btn4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.btn1];
    [self.contentView addSubview:self.btn2];
    [self.contentView addSubview:self.btn3];
    [self.contentView addSubview:self.btn4];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 5)];
    view1.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, (KWIDTH - 25) * 0.25)];
    view2.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH * 0.25 - 2.5, 0, 5, (KWIDTH - 25) * 0.25)];
    view3.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH * 0.5 - 2.5, 0, 5, (KWIDTH - 25) * 0.25)];
    view4.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH * 0.75 - 2.5, 0, 5, (KWIDTH - 25) * 0.25)];
    view5.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view5];
    
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH - 5, 0, 5, (KWIDTH - 25) * 0.25)];
    view6.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view6];
}

-(void)setBaseModel:(ESLBaseModel *)model
{
    [self.btn1 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl1] forState:UIControlStateNormal];
    [self.btn2 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl2] forState:UIControlStateNormal];
    [self.btn3 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl3] forState:UIControlStateNormal];
    [self.btn4 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl4] forState:UIControlStateNormal];
}

-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 11) {
        [self.delegate clickButtonWithType:@"wedding"];
    }
    else if(sender.tag == 12)
    {
        [self.delegate clickButtonWithType:@"private"];
    }
    else if(sender.tag == 13)
    {
        [self.delegate clickButtonWithType:@"help"];
    }
    else
    {
        [self.delegate clickButtonWithType:@"transport"];
    }
    
}
@end