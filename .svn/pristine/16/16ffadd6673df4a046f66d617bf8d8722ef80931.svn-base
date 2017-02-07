//
//  SinglFaestCell.m
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "SinglFaestCell.h"

@implementation SinglFaestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FeastSubModel *)model
{
   // NSLog(@"%d",model.StarCount.intValue);
    for (int i = 0; i < model.StarCount.intValue; i++) {
        UIImageView*img = [[UIImageView alloc]initWithFrame:CGRectMake(i*15+8, 13, 15, 15)];
        img.image = [UIImage imageNamed:@"starFore.png"];
        [self.contentView addSubview:img];
    }
    self.phoneLable.text = model.EvaluateTel;
    self.timelable.text = model.EvaluateDt;
    self.summerLable.text = model.Remark;
}
@end
