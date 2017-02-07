//
//  InformationCell.m
//  ESL
//
//  Created by 徐恒 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFmodel:(FeastAllModel *)Fmodel{
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:Fmodel.ImageUrl]];
    self.Package.text = Fmodel.Name;
    self.Number.text = [NSString stringWithFormat:@"x%ld",Fmodel.totalCount.integerValue];
    if (self.price == nil) {
        return;
    }else{
    self.price.text = [NSString stringWithFormat:@"%.2f",(Fmodel.Price.floatValue)*(Fmodel.totalCount.integerValue)];
    }
   
}
-(void)drawRect:(CGRect)rect
{
    self.ImgView.layer.cornerRadius = 5;
    self.ImgView.layer.masksToBounds = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
