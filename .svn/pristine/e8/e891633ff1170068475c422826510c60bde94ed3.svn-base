//
//  ESLFreashNetworkingManager.h
//  ESL
//
//  Created by eyou on 16/11/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESLSingleFreashModel.h"
@interface ESLFreashNetworkingManager : NSObject
//获取生鲜分类名称
+(void)getFreashTypeWithCompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;
//根据类型获取单品信息
+(void)getSingleFreashWithClassName:(NSString *)className CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;
//单品直接加入购物车
+(void)getJoinShopCartWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd ProID:(NSString *)proID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//获取购物车产品总数
+(void)getShopCartCountWithUserTel:(NSString *)userTel UserPhyAdd:(NSString *)userPhyAdd CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
@end
