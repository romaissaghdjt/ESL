//
//  ESLSingleFoodCell.m
//  ESL
//
//  Created by eyou on 16/12/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLSingleFoodCell.h"

@implementation ESLSingleFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValueWithModel:(ESLBagModel *)model
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.BaseDate.ImageUrl] placeholderImage:nil];
    self.nameLabel.text = model.BaseDate.Name;
    self.describeLabel.text = model.BaseDate.Feature;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", [model.BaseDate.Price doubleValue]];
    self.unitLabel.text = @"元/盒";
}

@end