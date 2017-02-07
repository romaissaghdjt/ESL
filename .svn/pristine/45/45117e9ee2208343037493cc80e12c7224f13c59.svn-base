//
//  ESLCategoryFoodCell.m
//  ESL
//
//  Created by eyou on 16/12/15.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCategoryFoodCell.h"

@implementation ESLCategoryFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)homeCategoryBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(clickCategoryButtonWithCellTag:BtnTag:)]) {
        [self.delegate clickCategoryButtonWithCellTag:self.tag BtnTag:sender.tag];
    }
}

@end
