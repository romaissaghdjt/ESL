//
//  CookerCell.m
//  YY
//
//  Created by eyou on 16/4/27.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CookerCell.h"
#import "UIImageView+WebCache.h"
@implementation CookerCell
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.image1.layer.cornerRadius = 50;
    self.image1.layer.masksToBounds = YES;
    
    self.image1.layer.borderWidth= 2;
    self.image1.layer.borderColor = ZXColor(115, 177, 0, 1).CGColor;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
