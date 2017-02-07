//
//  PictrueCell.m
//  YY
//
//  Created by 赵洁 on 16/6/22.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PictrueCell.h"

@implementation PictrueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DishModel *)model
{

    if (model.isChanged == YES) {
        [self.imga  sd_setImageWithURL:[NSURL URLWithString:model.ReplaceImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
        self.name.text = model.ReplaceName;
        //self.PriceLable.text = model.UnitPrice;
    }
    else
    {
        [self.imga  sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"meitu.jpg"]];
        self.name.text = model.DishName;
        //self.PriceLable.text = model.UnitPrice;
        
    }

}
@end
