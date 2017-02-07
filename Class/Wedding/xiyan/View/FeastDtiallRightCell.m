//
//  FeastDtiallRightCell.m
//  YY
//
//  Created by 赵洁 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastDtiallRightCell.h"

@implementation FeastDtiallRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DishModel *)model
{
    if (model.isSelect == YES) {
        self.ChooseButton.selected = YES;
    }
    if (model.isChanged == YES) {
        [self.FeastImg  sd_setImageWithURL:[NSURL URLWithString:model.ReplaceImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
        self.FeastNameLable.text = model.ReplaceName;
        //self.PriceLable.text = model.UnitPrice;
    }
    else
    {
        [self.FeastImg  sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
        self.FeastNameLable.text = model.DishName;
        //self.PriceLable.text = model.UnitPrice;

    }
    self.FeastImg.layer.cornerRadius = 6;
    self.FeastImg.layer.masksToBounds = YES;
    if ([model.Norm isEqualToString:@""]) {
        self.ZLLable.text = @"";
    }else
    {
        self.ZLLable.text = [NSString stringWithFormat:@"约%@",model.Norm];

        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
