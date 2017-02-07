//
//  ESLHelpCell.m
//  ESL
//
//  Created by 赵洁 on 17/1/16.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLHelpCell.h"

@implementation ESLHelpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setImgarray:(NSArray *)imgarray
{
    if (imgarray.count == 0) {
        self.noDateLabel.hidden = NO;
        self.fristBnt.userInteractionEnabled = NO;
        self.secondBnt.userInteractionEnabled = NO;
        self.thridBnt.userInteractionEnabled = NO;
        return;
    }
    else
    {
        self.fristBnt.userInteractionEnabled = YES;
        self.secondBnt.userInteractionEnabled = YES;
        self.thridBnt.userInteractionEnabled = YES;
        self.noDateLabel.hidden = YES;
        _imgarray = imgarray;
        FeastAllModel*model= [[FeastAllModel alloc]init];
        model = imgarray[0];
        [_fristBnt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.ImageUrl] forState:(UIControlStateNormal)];
        model = imgarray[1];
        [_secondBnt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.ImageUrl] forState:(UIControlStateNormal)];
        model = imgarray[2];
        [_thridBnt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.ImageUrl] forState:(UIControlStateNormal)];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
