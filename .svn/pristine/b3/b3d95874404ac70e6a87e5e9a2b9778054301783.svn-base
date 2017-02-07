//
//  TablewareRightCell.m
//  YY
//
//  Created by 徐恒 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "TablewareRightCell.h"

@implementation TablewareRightCell

- (void)setModel:(ClassificationModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    self.name.text = model.Name;
//    self.price.text = [NSString stringWithFormat:@"¥%@",model.Price];
    self.StarLevel = model.StarLevel;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
