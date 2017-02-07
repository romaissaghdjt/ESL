//
//  ESLMyNetworkingManager.m
//  ESL
//
//  Created by eyou on 16/11/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLMyNetworkingManager.h"

@implementation ESLMyNetworkingManager
//获取厨师抢单列表
+(void)getCookOrderWithCompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpGetEntitysMainPage";
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"CookRequire";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                CookOrderModel *cookOrderModel = [[CookOrderModel alloc]init];
                cookOrderModel.ID = dict[@"ID"];
                cookOrderModel.orderID = dict[@"OrderID"];
                cookOrderModel.wages = dict[@"Wages"];
                cookOrderModel.createTime = dict[@"CreateTime"];
                cookOrderModel.serverTime = dict[@"ServerTime"];
                cookOrderModel.serverAddr = dict[@"ServerAddr"];
                cookOrderModel.serverNum = dict[@"TableNumber"];
                cookOrderModel.state = dict[@"Status"];
                cookOrderModel.dinnerTime = dict[@"DinnerTime"];
                cookOrderModel.orderState = dict[@"OrderStatus"];
                [array addObject:cookOrderModel];
            }
            completionHandler(array, nil);
        }
    }
    ];
}

//获取厨师待执行列表
+(void)getCookerToDoOrderWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryPreExecute";
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"CookRequire";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                CookOrderModel *cookOrderModel = [[CookOrderModel alloc]init];
                cookOrderModel.ID = dict[@"ID"];
                cookOrderModel.orderID = dict[@"OrderID"];
                cookOrderModel.wages = dict[@"Wages"];
                cookOrderModel.createTime = dict[@"CreateTime"];
                cookOrderModel.serverTime = dict[@"ServerTime"];
                cookOrderModel.serverAddr = dict[@"ServerAddr"];
                cookOrderModel.serverNum = dict[@"TableNumber"];
                cookOrderModel.dinnerTime = dict[@"DinnerTime"];
                cookOrderModel.state = dict[@"Status"];
                [array addObject:cookOrderModel];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//获取厨师已完成列表
+(void)getCookerCompleteWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryFinish";
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = @"CookRequire";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                CookOrderModel *cookOrderModel = [[CookOrderModel alloc]init];
                cookOrderModel.ID = dict[@"ID"];
                cookOrderModel.orderID = dict[@"OrderID"];
                cookOrderModel.wages = dict[@"Wages"];
                cookOrderModel.createTime = dict[@"CreateTime"];
                cookOrderModel.serverTime = dict[@"ServerTime"];
                cookOrderModel.serverAddr = dict[@"ServerAddr"];
                cookOrderModel.serverNum = dict[@"TableNumber"];
                cookOrderModel.dinnerTime = dict[@"DinnerTime"];
                cookOrderModel.state = dict[@"Status"];
                [array addObject:cookOrderModel];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//获取厨师订单详情
+(void)getCookerOrderInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd OrderID:(NSString *)orderID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"CookRob.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpGetOrderInfo";
    parameters[@"ProModule"] = @"CookRob";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"OrderID"] = orderID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                CookerOrderInfoModel *model = [[CookerOrderInfoModel alloc]init];
                model.ID = dict[@"ID"];
                model.name = dict[@"Name"];
                model.productCgy = dict[@"ProductCgy"];
                model.count = dict[@"Count"];
                model.imageUrl = dict[@"ImageUrl"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
    ];
}

//厨师签到
+(void)getCookerCheckInWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"CookRob.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpStartExecute";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    parameters[@"ProID"] = proID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSLog(@"%@", responseObj[@"Reason"]);
            completionHandler(responseObj[@"提示"], nil);
        }
    }
     ];
}

//查询收支明细
+(void)getAccountInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryPayment";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj){
                ESLBalanceModel *model = [[ESLBalanceModel alloc]init];
                model.dateStr = dict[@"Date"];
                model.valueStr = dict[@"Value"];
                model.resualtValueStr = dict[@"ResualtValue"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//获取用户余额
+(void)getAccountBalanceWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSDictionary *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpGetBalance";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
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

//获取用户信息
+(void)getUserInfoCompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"GetInfo";
    parameters[@"UserTel"] = us;
    parameters[@"UserPhyAdd"] = KUUID;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"Authority"], nil);
        }
    }
    ];
}

@end
