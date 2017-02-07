//
//  ESLCookerDescriptionCell.m
//  ESL
//
//  Created by eyou on 16/11/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCookerDescriptionCell.h"

@implementation ESLCookerDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)downArrowClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(downArrowBtnClick:Button:)]) {
        [self.delegate downArrowBtnClick:self Button:sender];
    }
    
}

@end
