//
//  recFasetCell.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "recFasetCell.h"

@implementation recFasetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FeastAllModel *)model
{
    self.FeastNameLable.text = model.Name;
}
@end
