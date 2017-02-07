//
//  NSString+Verify.m
//  LRPDemo
//
//  Created by zhangwei on 15/8/28.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)
- (BOOL)verityEmailAddress
{
    NSString  *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)verityTelepone{
NSString *pattern = @"^1+[34578]+[0-9]{9}";
NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
BOOL isMatch = [pred evaluateWithObject:self];
return isMatch;
}
@end
