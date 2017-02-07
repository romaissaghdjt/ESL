//
//  BuyBodyCell.m
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "BuyBodyCell.h"

@implementation BuyBodyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bugBtn.layer.cornerRadius = 5;
    self.bugBtn.layer.masksToBounds = YES;
    
    self.iconImage.layer.cornerRadius = 10;
    self.iconImage.layer.masksToBounds = YES;
    
    self.hiddenImage.layer.cornerRadius = self.hiddenImage.width/2.0;
    self.hiddenImage.layer.masksToBounds = YES;
    
    self.buyNumLabel.layer.borderWidth = 1;
    self.buyNumLabel.layer.borderColor = ZXColor(212, 0, 27, 0.5).CGColor;
    self.buyNumLabel.layer.cornerRadius = 5;
    self.buyNumLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValueWithModel:(ESLBuyModel *)model
{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"1(1242_2208)"]];
    _headerLabel.text = model.reMark;
    _newsPriceLabel.text = [NSString stringWithFormat:@"%.01f/",[model.currentPrice floatValue]];
    
    _ordPriceLabel.text = [NSString stringWithFormat:@"¥%.01f",[model.originalPrice floatValue]];
    NSDictionary *dict = @{ NSStrikethroughStyleAttributeName:[NSNumber           numberWithInteger:NSUnderlineStyleThick]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_ordPriceLabel.text];
    [attribtStr addAttributes:dict range:NSMakeRange(0, _ordPriceLabel.text.length)];
    _ordPriceLabel.attributedText = attribtStr;
    
    _weightLabel.text = model.norm;
    _buyNumLabel.text = [NSString stringWithFormat:@"已抢%@份",model.sales];
    _remainNum.text = [NSString stringWithFormat:@"剩%@份",model.surplusCount];
    
//    NSLog(@"++++%lf", [model.sales floatValue]);
//    NSLog(@"----%lf", [model.sales floatValue] + [model.surplusCount floatValue]);
//    NSLog(@"====%lf", progress);

    if (model.sales.integerValue >= ([model.sales floatValue] + [model.surplusCount floatValue])) {
        _hiddenImage.hidden = NO;
        
        self.bugBtn.backgroundColor = ZXColor(189, 189, 189, 1);
        self.userInteractionEnabled = NO;
    }
    else
    {
        _hiddenImage.hidden = YES;
        self.bugBtn.backgroundColor = ZXColor(228, 145, 35, 1);
        self.userInteractionEnabled = YES;
    }
}

@end
