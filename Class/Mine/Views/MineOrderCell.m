//
//  MineOrderCell.m
//  ESL
//
//  Created by 赵洁 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MineOrderCell.h"

#import "ESLGamishModel.h"
@implementation MineOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setSmodel:(MyOrederSubModel *)smodel
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:smodel.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    self.productNameLable.text = smodel.Name;
    self.producTotalPriceLable.text = [NSString stringWithFormat:@"¥%.1f元",smodel.TotalPrice.floatValue];
    self.productCountLable.text = [NSString stringWithFormat:@"x%@",smodel.TotalCount];
    
    if ([smodel.ProductCgy isEqualToString:@"FreashSetMeal"]||[smodel.ProductCgy isEqualToString:@"FeastSetMeal"]) {
        self.PeCLable.hidden = YES;
        self.peCaNameLable.hidden = YES;
        self.PecaTotalPriceLable.hidden = YES;
    }else if(smodel.CookName != nil)
    {
        self.productNameLable.text = smodel.CookName;
        self.PeCLable.text = @"电话";
        self.peCaNameLable.text = smodel.CookTel;
        self.PecaTotalPriceLable.hidden = YES;
        
    }else if([smodel.Name isEqualToString:@"厨师服务"])
    {
        self.PeCLable.hidden = YES;
        self.peCaNameLable.hidden = YES;
        self.PecaTotalPriceLable.hidden = YES;
    }else
    {
        self.PeCLable.hidden = NO;
        self.peCaNameLable.hidden = NO;
        self.PecaTotalPriceLable.hidden = NO;
        NSString*aa = @"";
        if (smodel.GamishArr.count == 0) {
            self.peCaNameLable.text = @"无";
            self.PecaTotalPriceLable.text = @"";
            return;
        }else
        {
            for (ESLGamishModel*model in smodel.GamishArr) {
                aa = [aa stringByAppendingString:[NSString stringWithFormat:@"%@,",model.GamishName]];
            }
            
            NSString*as = [NSString stringWithFormat:@"%@",[aa substringToIndex:aa.length-1]];
            
            self.peCaNameLable.text = as;
            //
            self.PecaTotalPriceLable.text =[NSString stringWithFormat:@"¥%.1f元",smodel.GamishTotalPrice.floatValue];
        }
       
        
    }
    
    
}

@end
