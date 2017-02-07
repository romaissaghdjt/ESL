//
//  XiShiTangModel.m
//  YY
//
//  Created by 陈龙 on 16/7/1.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "XiShiTangModel.h"

@implementation XiShiTangModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Counties" : [CLCitiesModel class]};
}

@end
@implementation CLCitiesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Towns" : [CLTownsModel class]};
}

@end


@implementation CLTownsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Villages" : [CLVillageModel class]};
}

@end


@implementation CLVillageModel

@end


