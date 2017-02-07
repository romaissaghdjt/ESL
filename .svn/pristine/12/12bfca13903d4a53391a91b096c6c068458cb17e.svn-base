//
//  PrtiveTableViewCell.m
//  YY
//
//  Created by 赵洁 on 16/7/25.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PrtiveTableViewCell.h"

@implementation PrtiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellAoutoHigeht:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height +1;
}
@end
