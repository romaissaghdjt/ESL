//
//  ESLSearchViewCell.m
//  ESL
//
//  Created by 徐恒 on 2016/12/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLSearchViewCell.h"

@implementation ESLSearchViewCell

- (void)setESLSearchModel:(ESLSearchModel *)ESLSearchModel
{
    [self.ImageUrl sd_setImageWithURL:[NSURL URLWithString:ESLSearchModel.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    self.Name.text = ESLSearchModel.Name;
    self.Price.text = [NSString stringWithFormat:@"¥%.2f",ESLSearchModel.Price.floatValue];
    self.Remark.text = ESLSearchModel.Remark;
}
- (void)drawRect:(CGRect)rect
{
    self.ImageUrl.layer.cornerRadius = 5;
    self.ImageUrl.layer.masksToBounds = YES;
    self.content.layer.cornerRadius = 5;
    self.content.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
