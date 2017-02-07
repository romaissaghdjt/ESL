//
//  WeddingModel.m
//  YY
//
//  Created by 徐恒 on 16/5/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "WeddingModel.h"

@implementation WeddingModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (id)weddingWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
