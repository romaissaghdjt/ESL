//
//  ESLMyNetworkingManager.h
//  ESL
//
//  Created by eyou on 16/11/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookOrderModel.h"
#import "CookerOrderInfoModel.h"
#import "ESLBalanceModel.h"
@interface ESLMyNetworkingManager : NSObject
//获取厨师抢单列表
+(void)getCookOrderWithCompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取厨师待执行列表
+(void)getCookerToDoOrderWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取厨师已完成列表
+(void)getCookerCompleteWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取厨师订单详情
+(void)getCookerOrderInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd OrderID:(NSString *)orderID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//厨师签到
+(void)getCookerCheckInWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
//查询收支明细
+(void)getAccountInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;
//获取用户余额
+(void)getAccountBalanceWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSDictionary *result, NSError *error))completionHandler;

//获取用户信息
+(void)getUserInfoCompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
@end
