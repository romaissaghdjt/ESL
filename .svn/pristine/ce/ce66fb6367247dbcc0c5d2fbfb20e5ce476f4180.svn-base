//
//  ESLFreashNetworkingManager.m
//  ESL
//
//  Created by eyou on 16/11/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLFreashNetworkingManager.h"

@implementation ESLFreashNetworkingManager
//获取生鲜分类名称
+(void)getFreashTypeWithCompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"Freash";
    parameters[@"Function"] = @"HttpQueryFreashCgy";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj, nil);
        }
    }
     ];
}

//根据类型获取单品信息
+(void)getSingleFreashWithClassName:(NSString *)className CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"Freash";
    parameters[@"Function"] = @"HttpQueryEntitysByCgy";
    parameters[@"ClassName"] = className;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                ESLSingleFreashModel *model = [[ESLSingleFreashModel alloc]init];
                model.ID = dict[@"ID"];
                model.name = dict[@"Name"];
                model.imageUrl = dict[@"ImageUrl"];
                model.norm = dict[@"Norm"];
                model.proUnit = dict[@"ProUnit"];
                model.price = dict[@"Price"];
                model.robberable = dict[@"Robberable"];
                model.isSeasonal = dict[@"IsSeasonal"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
    ];
}

//单品直接加入购物车
+(void)getJoinShopCartWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"Freash";
    parameters[@"Function"] = @"HttpMoveToShoppingCart";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"ProID"] = proID;
    parameters[@"GamishInfo"] = @"[]";
    parameters[@"TotalCount"] = @"1";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"提示"], nil);
        }
    }
    ];
}

//获取购物车产品总数
+(void)getShopCartCountWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"ShoppingCart";
    parameters[@"Function"] = @"HttpQueryCount";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"Resault"], nil);
        }
    }
    ];
}
@end
