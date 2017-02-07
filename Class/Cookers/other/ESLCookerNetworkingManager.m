//
//  ESLCookerNetworkingManager.m
//  ESL
//
//  Created by eyou on 16/11/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCookerNetworkingManager.h"
#import "ESLSingleCookerModel.h"

@implementation ESLCookerNetworkingManager
//查询所有厨师
+(void)getCookerListCompletionHandler:(void (^)(NSArray *result, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"CookRob.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryAllEntitys";
    parameters[@"ProModule"] = @"CookRob";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, error);
        }
        else {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj[@"Cook"]){
                ESLSingleCookerModel *model = [[ESLSingleCookerModel alloc]init];
                model.ID = dict[@"ID"];
                model.name = dict[@"Name"];
                NSLog(@"=====%@", dict[@"ImageUrl"]);
                model.imageUrl = dict[@"ImageUrl"];
                model.serviceNum = dict[@"ServiceNum"];
                model.goodAt = dict[@"GoodAt"];
                model.isRecommend = dict[@"IsYsxRecommend"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }
     ];
}

//获取厨师主页面数据
+(void)getCookerInfoWithCookID:(NSString *)cookID CookCgy:(NSString *)cookCgy CompletionHandler:(void (^)(ESLCookerInfoModel *cookerInfoModel, NSArray *discussArr, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"CookRob.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpGetEntitysMainPage";
    parameters[@"ProModule"] = @"CookRob";
    parameters[@"CookID"] = cookID;
    parameters[@"CookCgy"] = cookCgy;
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            completionHandler(nil, nil, error);
        }
        else {
            NSMutableArray *discussArray = [NSMutableArray array];
            ESLCookerInfoModel *cookerInfoModel = [[ESLCookerInfoModel alloc]init];
            cookerInfoModel.imageUrl = responseObj[@"BaseData"][@"ImageUrl"];
            cookerInfoModel.name = responseObj[@"BaseData"][@"Name"];
            cookerInfoModel.age = responseObj[@"BaseData"][@"Age"];
            cookerInfoModel.workingTime = responseObj[@"BaseData"][@"WorkingTime"];
            cookerInfoModel.sex = responseObj[@"BaseData"][@"Sex"];
            cookerInfoModel.resume = responseObj[@"BaseData"][@"Resume"];
            cookerInfoModel.serviceArea = responseObj[@"BaseData"][@"ServiceArea"];
            cookerInfoModel.goodAt = responseObj[@"BaseData"][@"GoodAt"];
            cookerInfoModel.maxRecvOrdAbility = responseObj[@"BaseData"][@"MaxRecvOrdAbility"];
            
            for (NSDictionary *dict in responseObj[@"Evaluate"]){
                ESLDiscussModel *model = [[ESLDiscussModel alloc]init];
                model.evaluateDt = dict[@"EvaluateDt"];
                model.evaluateTel = dict[@"EvaluateTel"];
                model.starCount = dict[@"StarCount"];
                model.remark = dict[@"Remark"];
                NSLog(@"%@", dict[@"Remark"]);
                [discussArray addObject:model];
            }
            completionHandler(cookerInfoModel, discussArray, nil);
        }
    }
    ];
}

@end
