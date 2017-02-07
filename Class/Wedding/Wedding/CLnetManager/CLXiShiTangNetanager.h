//
//  CLXiShiTangNetanager.h
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OccupationDateModel.h"
#import "XiShiTangModel.h"
#import "YYModel.h"
#import "CLCheckNumModel.h"
#import "CLCookOccupyModel.h"
#import "YYUserInfo.h"

@interface CLXiShiTangNetanager : NSObject

+(void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

+(void)getAllDistrictDateWithCompletionHandler:(void (^)(XiShiTangModel *model, NSError *error))completionHandler;
//通过喜事堂ID获取喜事堂占用情况
+(void)getOccupationWithVillageID:(NSString *)villageID CompletionHandler:(void(^)(NSArray *responseObj, NSError *error))completionHandler;
//通过帐号获取喜事堂占用情况
+(void)getOccupationWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *responseObj, CLVillageModel *model, NSError *error))completionHandler;

+(void)getJoinWithDrowID:(NSString *)drowID JoinTel:(NSString *)joinTel CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

+(void)getStartLotteryWithDrowID:(NSString *)drowID DrawLevel:(NSString *)drawLevel CreatorTel:(NSString *)creatorTel CustPhyAddr:(NSString *)custPhyAddr CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

+(void)getCurrentNumWithDrowID:(NSString *)drowID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;

+(void)getCodeDrawWithTel:(NSString *)tel CustPhyAddr:(NSString *)custPhyAddr CompletionHandler:(void (^)(NSString *code, NSError *error))completionHandler;

+(void)stopDrawWithCreatorTel:(NSString *)creatorTel CustPhyAddr:(NSString *)custPhyAddr DrowID:(NSString *)drowID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//设置喜事堂占用日期
+(void)setDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallID:(NSString *)hallID Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice Address:(NSString *)address CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//判断喜事堂权限
+(void)judgeXiShiTangPermissionWithUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//通过帐号判断厨师权限
+(void)judgeCookerWithUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSString *result,  NSError *error))completionHandler;

//获取用户信息
+(void)getUserInfoWithUserUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSArray *result,  NSError *error))completionHandler;
//通过plist读取祝福语
+ (void)getWishWord:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取成功订单
+(void)getCompleteOrder:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取下单数和完成数
+(void)getCompleteOrderCount:(void (^)(NSArray *array, NSError *error))completionHandler;
//获取婚宴类型和八大菜系
+(void)getBanquetTypeWithCompletionHandler:(void (^)(NSArray *banquetType, NSArray *FoodSeries, NSError *error))completionHandler;

//通过帐号获取喜事堂列表
+(void)getXiShiListWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;

//修改喜事堂档期
+(void)changeXiShiTangDateWithSchID:(NSString *)schID SolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallStatus:(NSString *)hallStatus Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice address:(NSString *)address CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//修改喜事堂占用日期
+(void)changeDateWithSolarDtFrom:(NSString *)solarDtFrom SchID:(NSString *)schID SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallID:(NSString *)hallID Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice Address:(NSString *)address CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//删除喜事堂占用
+(void)deleteDateWithSchID:(NSString *)schID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//通过帐号获取厨师档期
+(void)getCookListWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *orderArray, NSError *error))completionHandler;

//通过帐号获取厨师占用情况
+(void)getCookWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *array,  NSError *error))completionHandler;

//设置厨师占用日期
+(void)setDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserTel:(NSString *)userTel HallName:(NSString *)hallName ROrderName:(NSString *)rOrderName ROrderNameTel:(NSString *)rOrderNameTel CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//修改厨师占用日期
+(void)changeDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo SchID:(NSString *)schID UserTel:(NSString *)userTel HallName:(NSString *)hallName ROrderName:(NSString *)rOrderName ROrderNameTel:(NSString *)rOrderNameTel CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//删除厨师档期
+(void)deleteCookDateWithSchID:(NSString *)schID CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

//根据ID获取喜事堂详情
+(void)getXiShiTangInfoWithID:(NSString *)ID CompletionHandler:(void (^)(CLVillageModel *model, NSError *error))completionHandler;

//根据城镇ID获取所有村详情
+(void)getTownXiShiTangInfoWithTownID:(NSString *)ID CompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler;

@end
