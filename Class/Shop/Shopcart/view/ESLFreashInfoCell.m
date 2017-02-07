//
//  ESLFreashInfoCell.m
//  ESL
//
//  Created by eyou on 16/11/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLFreashInfoCell.h"

@implementation ESLFreashInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValueWithModel:(ShopCartContentModel *)model
{
    if ([model.ProductCgy isEqualToString:@"Freash"]) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:nil];
        self.mainName.text = model.Name;
        self.mainPrice.text = [NSString stringWithFormat:@"%.02lf", model.Price.floatValue];
        self.packageName.text = @"配菜:";
        NSMutableString *tempStr = [NSMutableString string];
        for (ShopCartContentGamishModel *gamishModel in model.Gamish) {
            NSLog(@"===%@", gamishModel.Name);
            [tempStr appendString:[NSString stringWithFormat:@"%@、",gamishModel.Name]];
        }
        self.subName.width = KWIDTH - self.packageName.x - self.packageName.width - self.subPrice.width - 20;
        
        if (tempStr.length != 0) {
            self.subName.text = [tempStr substringToIndex:tempStr.length - 1];
        }
        else
        {
            self.subName.text = @"无";
        }
        self.subPrice.text = [NSString stringWithFormat:@"%.02lf", model.GamishTotalPrice.floatValue];
        self.maiCount.text = model.TotalCount;
        self.bookTime.text = [NSString stringWithFormat:@"此商品需提前%@小时预定", model.MinRecvHour];
        self.signLabel.text = @"¥";
    }
    else
    {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:nil];
        self.mainName.text = @"";
        self.mainPrice.text = @"";
        self.packageName.text = model.Name;
        self.subName.text = @"";
        self.subPrice.text = [NSString stringWithFormat:@"%.02lf", model.Price.floatValue];
        self.maiCount.text = model.TotalCount;
        self.bookTime.text = @"";
        self.signLabel.text = @"";
    }
    self.selectBtn.selected = model.singleSelected;
    
    
}
-(void)drawRect:(CGRect)rect
{
    self.iconImage.layer.cornerRadius = 5;
    self.iconImage.layer.masksToBounds = YES;
}
@end
