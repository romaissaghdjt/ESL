//
//  SingleHandle.m
//  SixPassValue_single
//
//  Created by zhangwei on 15/11/13.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "SingleHandle.h"
//静态指针变量
static SingleHandle *single = nil;
@implementation SingleHandle
+ (SingleHandle *)shareSingleHandle {
    //gcd创建单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[SingleHandle alloc] init];
    });
    return single;
}


@end
