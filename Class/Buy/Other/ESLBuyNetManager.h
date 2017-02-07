//
//  ESLBuyNetManager.h
//  ESL
//
//  Created by eyou on 16/10/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FreashModel.h"
#import "GarnishesModel.h"

@interface ESLBuyNetManager : NSObject
//获取抢购列表
+(void)getGetRobberyProductsWithCompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取抢购物品详情
+(void)getGetRobberyProductsInfoWithProID:(NSString *)proID ProModule:(NSString *)proModule CompletionHandler:(void (^)(FreashModel *freashModel, NSError *error))completionHandler;
//获取配菜列表
+(void)getGarnishesWithProID:(NSString *)proID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
//添加收藏
+(void)postCollectWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID ProductCgy:(NSString *)productCgy ImageUrl:(NSString *)imageUrl Remark:(NSString *)remark Price:(NSString *)price CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
//查询收藏状态
+(void)postIsCollectWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID ProductCgy:(NSString *)productCgy CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
//单品加入购物车
+(void)addFreashToShopCartWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID GamishInfo:(NSArray *)gamishInfoArray TotalCount:(NSString *)totalCount ProModule:(NSString *)proModule CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
@end
