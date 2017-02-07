//
//  ESLBuyNetManager.m
//  ESL
//
//  Created by eyou on 16/10/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLBuyNetManager.h"

@implementation ESLBuyNetManager
//获取抢购列表
+(void)getGetRobberyProductsWithCompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Promoting.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"GetRobberyProducts";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
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
//获取抢购物品详情
+(void)getGetRobberyProductsInfoWithProID:(NSString *)proID ProModule:(NSString *)proModule CompletionHandler:(void (^)(FreashModel *freashModel, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = proModule;
    parameters[@"Function"] = @"HttpGetEntitysMainPage1_1";
    if ([proModule isEqualToString:@"FreashPackage"]) {
        parameters[@"Function"] = @"HttpGetEntitysMainPage";
    }
    parameters[@"ProID"] = proID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler([FreashModel yy_modelWithJSON:responseObj], nil);
        }
    }
    ];
}

//获取配菜列表
+(void)getGarnishesWithProID:(NSString *)proID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"Freash";
    parameters[@"Function"] = @"HttpQueryAllGamishs";
    parameters[@"ProID"] = proID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj) {
                GarnishesModel *model = [[GarnishesModel alloc]init];
                model.ID = dict[@"ID"];
                model.name = dict[@"Name"];
                model.price = dict[@"Price"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//添加收藏
+(void)postCollectWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID ProductCgy:(NSString *)productCgy ImageUrl:(NSString *)imageUrl Remark:(NSString *)remark Price:(NSString *)price CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"ProductCgy"] = productCgy;
    parameters[@"Function"] = @"HttpAddCollectionEx";
    parameters[@"ProID"] = proID;
    parameters[@"ImageUrl"] = imageUrl;
    parameters[@"Remark"] = remark;
    parameters[@"Price"] = price;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"提示"], nil);
            NSLog(@"%@",responseObj[@"提示"]);
        }
    }
     ];
}

//查询收藏状态
+(void)postIsCollectWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID ProductCgy:(NSString *)productCgy CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"ProductCgy"] = productCgy;
    parameters[@"Function"] = @"HttpQueryCollectionStatus";
    parameters[@"ProID"] = proID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSLog(@"++++%@", responseObj[@"Status"]);
            completionHandler(responseObj[@"Status"], nil);
        }
    }
     ];
}

//单品加入购物车
+(void)addFreashToShopCartWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID GamishInfo:(NSArray *)gamishInfoArray TotalCount:(NSString *)totalCount ProModule:(NSString *)proModule CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"ProModule"] = proModule;
    parameters[@"Function"] = @"HttpMoveToShoppingCart";
    parameters[@"ProID"] = proID;
    parameters[@"Component"] = @"Product";
    parameters[@"TotalCount"] = totalCount;
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:gamishInfoArray options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    parameters[@"GamishInfo"] = str;
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
@end
