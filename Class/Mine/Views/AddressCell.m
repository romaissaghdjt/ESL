//
//  AddressCell.m
//  ESL
//
//  Created by 赵洁 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "AddressCell.h"


@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AddressMolde *)model
{
    self.NameLable.text = model.RecvName;
    self.PhoneNumLable.text = model.RecvTel;
    self.AddressLable.text = [NSString stringWithFormat:@"%@%@%@%@",model.ProvinceName,model.DistrictName,model.CountyName,model.Details];;
    if ([model.isDefault isEqualToString:@"true"]) {
        [self.ChooseButton setImage:[UIImage imageNamed:@"choose.png"] forState:(UIControlStateNormal)];
    }else
    {
        [self.ChooseButton setImage:[UIImage imageNamed:@"unChoose.png"] forState:(UIControlStateNormal)];
    }
}

@end
