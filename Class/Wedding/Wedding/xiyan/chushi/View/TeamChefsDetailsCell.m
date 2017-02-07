//
//  TeamChefsDetailsCell.m
//  YY
//
//  Created by 徐恒 on 16/6/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "TeamChefsDetailsCell.h"

@implementation TeamChefsDetailsCell
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.imgView.layer.cornerRadius = 50;
    self.imgView.layer.masksToBounds = YES;
    
    self.imgView.layer.borderWidth= 2;
    self.imgView.layer.borderColor = ZXColor(115, 177, 0, 1).CGColor;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
