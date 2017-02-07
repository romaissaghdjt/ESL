//
//  ContentCell.m
//  ESL
//
//  Created by 徐恒 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

-(void)setSmodel:(ESLSureModel *)Smodel
{
    self.consignee.text = Smodel.RecvName;
    self.tel.text = Smodel.RecvTel;
//    self.ProvinceName = Smodel.ProvinceName;
//    self.DistrictName = Smodel.DistrictName;
//    self.CountyName = Smodel.CountyName;
    NSString *str = @"";
    self.address.text = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@%@%@",Smodel.ProvinceName,Smodel.DistrictName,Smodel.CountyName,Smodel.Details]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
