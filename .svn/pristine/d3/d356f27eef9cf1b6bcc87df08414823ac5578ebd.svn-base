//
//  NSString+MD5HexDigest.m
//  EML
//
//  Created by eyou on 16/4/19.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "NSString+MD5HexDigest.h"

@implementation NSString (MD5HexDigest)
-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
@end
