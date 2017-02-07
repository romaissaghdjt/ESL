//
//  ESLBagHeaderCell.m
//  ESL
//
//  Created by eyou on 17/1/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLBagHeaderCell.h"

@implementation ESLBagHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _unitLabel.text = @"1盒";
    double width = self.view1.width + self.view2.width + self.view3.width +self.view4.width;
    self.imageConstraint1.constant = self.imageConstraint2.constant = self.imageConstraint3.constant = self.imageConstraint4.constant = (KWIDTH - width)/5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadCellInfo:(FreashModel *)model
{
    _nameLabel.text = model.BaseData.Name;
    _priceLabel.text = [NSString stringWithFormat:@"%.02lf",[model.BaseData.Price doubleValue]];
    
}

@end
