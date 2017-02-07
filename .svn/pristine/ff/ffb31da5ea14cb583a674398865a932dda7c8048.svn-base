//
//  ESLShopCartHeaderCell.m
//  ESL
//
//  Created by eyou on 16/11/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLShopCartHeaderCell.h"

@implementation ESLShopCartHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selecetBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerCellSelectBtnClick:Button:)]) {
        [self.delegate headerCellSelectBtnClick:self.indexPathSection Button:sender];
    }
}

@end
