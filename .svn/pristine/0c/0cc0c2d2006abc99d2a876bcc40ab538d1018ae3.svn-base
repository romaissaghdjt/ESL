//
//  zJRequestManager.h
//
//  Created by 赵洁 on 15/12/22.
//  Copyright (c) 2015年 zj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Finish) (NSData *data);
typedef void(^Error) (NSError *error);
typedef NS_ENUM(NSInteger, RequsetType)
{
    POST1,
    GET1


};
@interface zJRequestManager : NSObject<NSURLSessionDelegate>
+ (void)requestWithUrl:(NSString *)urlstring parmDic:(NSDictionary *)parmDic method:(RequsetType)method succeedWithData:(void(^)(NSData *data))block
       failedWithError:(void(^)(NSError *Error))failblock;
@end
