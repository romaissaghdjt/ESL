//
//  TwoImageTableViewCell.m
//  ESL
//
//  Created by eyou on 16/9/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "TwoImageTableViewCell.h"

@implementation TwoImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.height = 120;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initContentWithStr:(NSString *)string
{
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 8, KWIDTH*0.5 , KWIDTH * 0.25 - 8)];
    self.btn1.tag = 11;
    [self.btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH*0.5, 8, KWIDTH*0.5 , KWIDTH * 0.25 - 8)];
    self.btn2.tag = 12;
    [self.btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btn1];
    [self.contentView addSubview:self.btn2];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 8)];
    view1.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH*0.5 - 1, 0, 2, KWIDTH * 0.25)];
    view2.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view2];
}
-(void)setBaseModel:(ESLBaseModel *)model
{
    [self.btn1 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl1] forState:UIControlStateNormal];
    [self.btn2 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl2] forState:UIControlStateNormal];
}

-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 11) {
        [self.delegate clickButtonWithType:@"newFood"];
    }
    else
    {
        [self.delegate clickButtonWithType:@"hotFood"];
    }
    
}

@end
