//
//  NSDate+Calendar.h
//  test
//
//  Created by 陈龙 on 16/5/24.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSDate*)nextMonth:(NSDate *)date;

+(NSDate *)local:(NSDate *)date;
@end
