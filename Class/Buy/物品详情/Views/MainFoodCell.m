//
//  MainFoodCell.m
//  ESL
//
//  Created by eyou on 16/10/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MainFoodCell.h"


@implementation MainFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.unitLabel.layer.cornerRadius = 8;
    self.unitLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subBtn:(UIButton *)sender {
    if ([self.countNum.text intValue] == 1) {
        return;
    }
    self.countNum.text = [NSString stringWithFormat:@"%d", [self.countNum.text intValue] - 1];
    sender.tag = 100;
    [self.delegate buttonClickWithButton:sender Type:@"sub"];
}

- (IBAction)addBtn:(UIButton *)sender {
    self.countNum.text = [NSString stringWithFormat:@"%d", [self.countNum.text intValue] + 1];
    sender.tag = 100;
    [self.delegate buttonClickWithButton:sender Type:@"add"];
}

@end
