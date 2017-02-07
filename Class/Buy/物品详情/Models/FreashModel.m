//
//  FreashModel.m
//  ESL
//
//  Created by eyou on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FreashModel.h"

@implementation FreashModel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"BaseData" : [Basedata class],
             @"EvaluateOverView" : [Evaluateoverview class],
             @"RecommendFreash" : [RecommendFreash class] };
}

@end


@implementation Basedata

@end


@implementation Evaluateoverview
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Details" : [Details class]};
}

@end


@implementation Details

@end


@implementation RecommendFreash

@end


