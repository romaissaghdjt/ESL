//
//  FeastDitallCell.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastDitallCell.h"

@implementation FeastDitallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellAoutoHigeht:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return rect.size.height +38;
}
@end
