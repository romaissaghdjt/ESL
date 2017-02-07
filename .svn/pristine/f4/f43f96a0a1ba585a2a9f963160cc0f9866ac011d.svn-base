//
//  PrsonFeastCell.m
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "PrsonFeastCell.h"

@implementation PrsonFeastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(FeastAllModel *)model
{
    _model = model;
    
    [self.FeastImage sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
