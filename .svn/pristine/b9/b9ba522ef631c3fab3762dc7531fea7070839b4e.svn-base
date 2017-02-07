//
//  FoodSeriesModel.m
//  YY
//
//  Created by 陈龙 on 16/6/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FoodSeriesModel.h"
#import "CLXiShiTangNetanager.h"

@implementation FoodSeriesModel
+(void)getFoodSeriesWithCompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"BookHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"bookPage";
    NSMutableArray *array = [NSMutableArray array];
    [CLXiShiTangNetanager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            
        }
        
    }];
    
}

@end
