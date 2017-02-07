//
//  ESLCookerInfoCell.m
//  ESL
//
//  Created by eyou on 16/11/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCookerInfoCell.h"

@implementation ESLCookerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImage.layer.cornerRadius = 50;
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImage.layer.borderWidth = 5;

    self.backgoundView.layer.cornerRadius = 55;
    self.backgoundView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
