//
//  FasetShowCell.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FasetShowCell.h"

@implementation FasetShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FeastSubModel *)model
{
    _model = model;
    self.FeastName.text = model.Name;
   
    self.FeastNormLable.text = model.Norm;
    
    
    [self.FeastImage sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
}
- (void)setDmodel:(DishModel *)Dmodel
{
    
    self.FeastName.text = Dmodel.DishName;
    
    self.FeastNormLable.text = Dmodel.Norm;
    
    
    [self.FeastImage sd_setImageWithURL:[NSURL URLWithString:Dmodel.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
}
@end
