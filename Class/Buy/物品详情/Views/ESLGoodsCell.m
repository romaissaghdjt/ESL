//
//  ESLGoodsCell.m
//  ESL
//
//  Created by eyou on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLGoodsCell.h"

@implementation ESLGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    double width = self.view1.width + self.view2.width + self.view3.width +self.view4.width;
    self.imageConstraint1.constant = self.imageConstraint2.constant = self.imageConstraint3.constant = self.imageConstraint4.constant = (KWIDTH - width)/5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setValueWithModel:(FreashModel *)model From:(BOOL)isFromRob
{
    _nameLabel.text = model.BaseData.Name;
    _describeLabel.text = model.BaseData.Remark;
    if (isFromRob == YES) {
        _priceLabel.text = [NSString stringWithFormat:@"%.02lf",[model.RobData doubleValue]];
    }
    else
    {
        _priceLabel.text = [NSString stringWithFormat:@"%.02lf",[model.BaseData.Price doubleValue]];
    }
    if ([model.BaseData.IsSeasonal isEqualToString:@"1"]) {
        _describeLabel.text = @"该商品为时令价商品,实际价格以当日价格为准,实行多退少补";
        _describeLabel.textColor = [UIColor darkGrayColor];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_describeLabel.text];
        NSRange r = NSMakeRange(4, 5);
        NSRange r2 = NSMakeRange(24, 4);
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:r];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:r2];
        [_describeLabel setAttributedText:attributedString];
    }
    _unitLabel.text = [NSString stringWithFormat:@"%@%@",model.BaseData.Number, model.BaseData.NormUnit];
    _oldPriceLabel.text = [NSString stringWithFormat:@"%.02lf",[model.BaseData.Price doubleValue]];
    _countLabel.text = model.BaseData.Sales;
}
@end
