//
//  ESLShopNetworkingManager.h
//  ESL
//
//  Created by eyou on 16/10/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESLShopCartModel.h"
#import "WXApi.h"

@interface ESLShopNetworkingManager : NSObject
//提交编辑购物车
+(void)postEditShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProInfo:(NSArray *)proInfo CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler;
//清除购物车的多个产品
+(void)postDeleteSomeShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProInfo:(NSArray *)proInfo CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler;
//清除购物车的一个产品
+(void)postDeleteOneShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProModule:(NSString *)proModule ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *string, NSError *error))completionHandler;
//获取购物车
+(void)getShopInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//微信支付
+(void)getWechatPayWithPurpose:(NSString *)purpose Value:(NSString *)value OrderID:(NSString *)orderID VoucherValue:(NSString *)voucherValue CompletionHandler:(void (^)(NSDictionary *dict, NSError *error))completionHandler;
@end
