//
//  ESLCuisineCell.m
//  ESL
//
//  Created by 徐恒 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCuisineCell.h"
//#define W self.ImgView.frame.size.height*0.5+self.ImgView.y-self.Name.y*0.5;
@implementation ESLCuisineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPmodel:(ESLSingleProModel *)Pmodel{
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:Pmodel.ImageUrl]];
    self.Name.text = Pmodel.mainName;
    self.Price.text = [NSString stringWithFormat:@"¥%@",Pmodel.mainPrice];
    self.Count.text = [NSString stringWithFormat:@"x%@",Pmodel.mainCount];
    self.proID = Pmodel.proID;
    self.countA = Pmodel.count;
    for (SingleSubModel *model in Pmodel.subArray) {
        self.ID = model.ID;
        self.sunCount = model.subNum;
    }
    if (Pmodel.subArray.count == 0) {
        self.Reproduction.hidden = YES;
    }else{
        NSString *str = @"";
        for (int i = 0 ;i < Pmodel.subArray.count; i ++ ) {
            if (Pmodel.subArray.count==0) {
                self.Name.y = 30;
                self.Price.y = self.ImgView.y * 0.5;
                self.Count.y  = self.ImgView.y * 0.5;
            }
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@ ",Pmodel.subArray[i].subName]];
            self.DishesName.text = str;
            self.SubPrice.text = [NSString stringWithFormat:@"¥%.2f",Pmodel.gamishTotalPrice.floatValue];
        }
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
