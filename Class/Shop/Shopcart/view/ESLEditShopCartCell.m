//
//  ESLEditShopCartCell.m
//  ESL
//
//  Created by eyou on 16/11/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLEditShopCartCell.h"

@implementation ESLEditShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)subBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editCellWithIndex:EditType:Cell:)]) {
        [self.delegate editCellWithIndex:self.indexPath EditType:SUBEDIT Cell:self];
    }
}

- (IBAction)addBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editCellWithIndex:EditType:Cell:)]) {
        [self.delegate editCellWithIndex:self.indexPath EditType:ADDEDIT Cell:self];
    }
}

-(void)setValueWithModel:(ShopCartContentModel *)model index:(NSIndexPath *)indexPath
{
    [self.iconName sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:nil];
    self.countNum.text = model.TotalCount;
    self.nameLabel.text = model.Name;
    self.selectBtn.selected = model.singleSelected;
    self.indexPath = indexPath;
}
-(void)drawRect:(CGRect)rect
{
    self.iconName.layer.cornerRadius = 5;
    self.iconName.layer.masksToBounds = YES;
}
@end
