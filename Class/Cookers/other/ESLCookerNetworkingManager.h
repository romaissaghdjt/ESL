//
//  ESLCookerNetworkingManager.h
//  ESL
//
//  Created by eyou on 16/11/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESLCookerInfoModel.h"
#import "ESLDiscussModel.h"

@interface ESLCookerNetworkingManager : NSObject
//查询所有厨师
+(void)getCookerListCompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;
//获取厨师主页面数据
+(void)getCookerInfoWithCookID:(NSString *)cookID CookCgy:(NSString *)cookCgy CompletionHandler:(void (^)(ESLCookerInfoModel *cookerInfoModel, NSArray *discussArr, NSError *error))completionHandler;

@end
