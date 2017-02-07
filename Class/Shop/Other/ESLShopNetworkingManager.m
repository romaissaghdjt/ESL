//
//  ESLShopNetworkingManager.m
//  ESL
//
//  Created by eyou on 16/10/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLShopNetworkingManager.h"

@implementation ESLShopNetworkingManager
//提交编辑购物车
+(void)postEditShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProInfo:(NSArray *)proInfo CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"ShoppingCart";
    parameters[@"Function"] = @"HttpSetShoppingCartCount";
    parameters[@"UserTel"] = userTel;
    
    parameters[@"UserPhyAdd"] = userPhyAdd;

    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:proInfo options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    parameters[@"ProInfo"] = str;

    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
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

//清除购物车的多个产品
+(void)postDeleteSomeShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProInfo:(NSArray *)proInfo CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"ShoppingCart";
    parameters[@"Function"] = @"HttpClearMultiple";
    parameters[@"UserTel"] = userTel;
    
    parameters[@"UserPhyAdd"] = userPhyAdd;
    
    NSMutableArray *array = [NSMutableArray array];
    for (ShopCartContentModel *contentModel in proInfo) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"ProductCgy"] = contentModel.ProductCgy;
        dict[@"ID"] = contentModel.ID;
        [array addObject:dict];
    }
    
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    parameters[@"ProInfo"] = str;
    NSLog(@"===%@", str);
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"提示"], nil);
            NSLog(@"%@", responseObj[@"提示"]);
        }
    }
     
     ];
}

//清除购物车的一个产品
+(void)postDeleteOneShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProModule:(NSString *)proModule ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"Product";
    parameters[@"ProModule"] = proModule;
    parameters[@"Function"] = @"HttpRemoveOutShoppingCart";
    parameters[@"UserTel"] = userTel;
    parameters[@"ProID"] = proID;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj[@"提示"], nil);
            NSLog(@"%@", responseObj[@"提示"]);
        }
    }
    ];
}

//获取购物车
+(void)getShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Component"] = @"ShoppingCart";
    parameters[@"Function"] = @"HttpGetEntitysMainPageEx";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = userPhyAdd;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj) {
                ESLShopCartModel *model = [[ESLShopCartModel alloc]init];
                model = [ESLShopCartModel yy_modelWithJSON:dict];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//微信支付
+(void)getWechatPayWithPurpose:(NSString *)purpose Value:(NSString *)value OrderID:(NSString *)orderID VoucherValue:(NSString *)voucherValue CompletionHandler:(void (^)(NSDictionary *dict, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"wxpay_index.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"purpose"] = purpose;
    dict[@"UserTel"] = us;
    dict[@"OrderID"] = orderID;
    dict[@"VoucherValue"] = voucherValue;
    dict[@"value"] = value;
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    parameters[@"Function"] = @"StartPay";
    parameters[@"Body"] = str;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj, nil);
        }
    }
     ];
}

@end
