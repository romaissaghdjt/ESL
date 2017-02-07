//
//  OrderCell.m
//  ESL
//
//  Created by eyou on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.constraint1.constant = self.constraint2.constant = (KWIDTH - 300)/3.0;
    self.infoButton.backgroundColor = [UIColor whiteColor];
    self.infoButton.layer.cornerRadius = 7;
    self.infoButton.layer.masksToBounds = YES;
    self.infoButton.layer.borderColor = ZXColor(87, 169, 0, 1).CGColor;
    self.infoButton.layer.borderWidth = 1;
    
    self.getItButton.backgroundColor = ZXColor(87, 169, 0, 1);
    self.getItButton.layer.cornerRadius = 7;
    self.getItButton.layer.masksToBounds = YES;
    
    self.GPSBtn.backgroundColor = [UIColor whiteColor];
    self.GPSBtn.layer.cornerRadius = 7;
    self.GPSBtn.layer.masksToBounds = YES;
    self.GPSBtn.layer.borderColor = ZXColor(87, 169, 0, 1).CGColor;
    self.GPSBtn.layer.borderWidth = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
