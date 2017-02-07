//
//  ESLDishesCell.m
//  ESL
//
//  Created by eyou on 16/11/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLDishesCell.h"

@implementation ESLDishesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layoutConstraint1.constant = self.layoutConstraint2.constant = self.layoutConstraint3.constant = self.layoutConstraint4.constant = (KWIDTH - 4*74)/5.0;
    self.numLabel1.layer.cornerRadius = 10;
    self.numLabel1.layer.masksToBounds = YES;
    self.numLabel2.layer.cornerRadius = 10;
    self.numLabel2.layer.masksToBounds = YES;
    self.numLabel3.layer.cornerRadius = 10;
    self.numLabel3.layer.masksToBounds = YES;
    self.numLabel4.layer.cornerRadius = 10;
    self.numLabel4.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
