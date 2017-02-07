//
//  NSDate+Calendar.m
//  test
//
//  Created by 陈龙 on 16/5/24.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "NSDate+Calendar.h"
#import <UIKit/UIKit.h>

@implementation NSDate (Calendar)

+(NSDate *)local:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger integer = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *localDate = [date dateByAddingTimeInterval:integer];
    return localDate;
}
@end
