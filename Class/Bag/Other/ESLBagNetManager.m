//
//  ESLBagNetManager.m
//  ESL
//
//  Created by eyou on 17/1/18.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLBagNetManager.h"

@implementation ESLBagNetManager

//获取所有礼包
+(void)getBagWithCompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"FreashPackage";
    parameters[@"Function"] = @"HttpQueryAllEntitys";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *bagArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObj) {
                [bagArray addObject:[ESLBagModel yy_modelWithJSON:dict]];
            }
            completionHandler(bagArray, nil);
        }
    }
     ];
}

@end
