//
//  CLXiShiTangNetanager.m
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLXiShiTangNetanager.h"
#import "XiShiListModel.h"

@implementation CLXiShiTangNetanager

+(void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求超时时间
    
    manager.requestSerializer.timeoutInterval = 15;
    [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

//获取城镇村
+(void)getAllDistrictDateWithCompletionHandler:(void (^)(XiShiTangModel *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryAllVillage";
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
                completionHandler(nil, error);
            }
            else {
                completionHandler([XiShiTangModel yy_modelWithJSON:responseObj.firstObject], nil);
            }
        
        }
        
    ];

}

//通过村获取占用情况
+(void)getOccupationWithVillageID:(NSString *)villageID CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getTake";
    parameters[@"ID"] = villageID;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
           // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"占用情况"]) {  
                OccupationDateModel *model = [[OccupationDateModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}
//通过帐号获取喜事堂占用情况
+(void)getOccupationWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *, CLVillageModel *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getHallUTel";
    parameters[@"UserTel"] = tel;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"占用情况"]) {
                OccupationDateModel *model = [[OccupationDateModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
            }
            CLVillageModel *villageModel = [[CLVillageModel alloc]init];
            for (NSDictionary *dict in responseObj[@"喜事堂详细"]) {
                [villageModel setValuesForKeysWithDictionary:dict];
            }

            completionHandler(array, villageModel, nil);
        }
    }];
}

//抽奖报名
+(void)getJoinWithDrowID:(NSString *)drowID CompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpDrawSignUp";
    parameters[@"DrawID"] = drowID;
    parameters[@"UserPhyAdd"] = KUUID;
    parameters[@"UserTel"] = us;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj, nil);
        }
    }];
}
//开奖
+(void)getStartLotteryWithDrowID:(NSString *)drowID DrawLevel:(NSString *)drawLevel CompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpDrawSelectOne";
    parameters[@"DrawID"] = drowID;
    parameters[@"DrawLevel"] = drawLevel;
    parameters[@"UserTel"] = us;
    parameters[@"UserPhyAdd"] = KUUID;
    
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj, nil);
        }
    }];
}
//查看开奖号码
+(void)getCurrentNumWithDrowID:(NSString *)drowID Tel:(NSString *)tel CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpDrawGetAll";
    parameters[@"DrawID"] = drowID;
    parameters[@"UserTel"] = tel;
    parameters[@"UserPhyAdd"] = KUUID;
    
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj) {
                CLCheckNumModel *model = [[CLCheckNumModel alloc]init];
                model.WinnerTel = dict[@"WinnerTel"];
                model.NameS = dict[@"DrawLevel"];
                [array addObject:model];
            }
            NSLog(@"%ld", array.count);
            completionHandler(array, nil);
        }
    }];
}

//发起抽奖获取验证码
+(void)getCodeDrawCompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpDrawCreate";
    parameters[@"UserTel"] = us;
    parameters[@"UserPhyAdd"] = KUUID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"DrawID"], nil);
        }
    }];
}

//结束抽奖
+(void)stopDrawWithDrowID:(NSString *)drowID CompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpDrawStop";
    parameters[@"UserTel"] = us;
    parameters[@"UserPhyAdd"] = KUUID;
    parameters[@"DrawID"] = drowID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj, nil);
        }
    }];
}

//设置喜事堂占用日期
+(void)setDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallID:(NSString *)hallID Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice Address:(NSString *)address CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"HallsSch";
    parameters[@"HallStatus"] = @"3";
    parameters[@"SolarDtFrom"] = solarDtFrom;
    parameters[@"SolarDtTo"] = solarDtTo;
    parameters[@"UserName"] = userName;
    parameters[@"HallID"] = hallID;
    parameters[@"Tel"] = tel;
    parameters[@"Dinner"] = dinner;
    parameters[@"Vice"] = vice;
    parameters[@"Address"] = address;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
            
        }
    }];
}

//判断喜事堂权限
+(void)judgeXiShiTangPermissionWithUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"Authority";
    parameters[@"UserTel"] = userTel;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(((NSDictionary *)responseObj).allKeys.firstObject, nil);
        }
    }];
}
//通过帐号判断厨师权限
+(void)judgeCookerWithUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSString *,  NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"Authority";
    parameters[@"UserTel"] = userTel;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(((NSDictionary *)responseObj).allKeys.firstObject, nil);
        }
    }];
}

//获取用户信息
+(void)getUserInfoWithUserUserTel:(NSString *)userTel CompletionHandler:(void (^)(NSArray *,  NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"LoginCheckHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"userInfo";
    parameters[@"UserTel"] = userTel;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj[@"用户信息"]) {
                YYUserInfo *model = [[YYUserInfo alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}
//通过plist读取祝福语
+ (void)getWishWord:(void (^)(NSArray *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WishWord" ofType:@"plist"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(array, nil);
        });
    });
}

//获取成功订单
+(void)getCompleteOrder:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"MainPageMsgHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"GetNearOrder";
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj, nil);
        }
    }];
}

//获取下单数和完成数
+(void)getCompleteOrderCount:(void (^)( id, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx?Function=HttpQueryFeastHeaderInfo"];
   
    [self sendRequestWithUrl:url parameters:nil completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj, nil);
        }
    }];
}

//通过帐号获取喜事堂列表
+(void)getXiShiListWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getHallDtToTel";
    parameters[@"UserTel"] = tel;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"占用情况"]) {
                XiShiListModel *model = [[XiShiListModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}

//修改喜事堂档期
+(void)changeXiShiTangDateWithSchID:(NSString *)schID SolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallStatus:(NSString *)hallStatus Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice address:(NSString *)address CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"HallsSchUP";
    parameters[@"SchID"] = schID;
    parameters[@"SolarDtFrom"] = solarDtFrom;
    parameters[@"SolarDtTo"] = solarDtTo;
    parameters[@"UserName"] = userName;
    parameters[@"Tel"] = tel;
    parameters[@"HallStatus"] = @"3";
    parameters[@"Dinner"] = dinner;
    parameters[@"Vice"] = vice;
    parameters[@"Address"] = address;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

//修改喜事堂占用日期
+(void)changeDateWithSolarDtFrom:(NSString *)solarDtFrom SchID:(NSString *)schID SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallID:(NSString *)hallID Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice Address:(NSString *)address CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"SchID"] = schID;
    parameters[@"Action"] = @"HallsSchUP";
    parameters[@"HallStatus"] = @"3";
    parameters[@"SolarDtFrom"] = solarDtFrom;
    parameters[@"SolarDtTo"] = solarDtTo;
    parameters[@"UserName"] = userName;
    parameters[@"HallID"] = hallID;
    parameters[@"Tel"] = tel;
    parameters[@"Dinner"] = dinner;
    parameters[@"Vice"] = vice;
    parameters[@"Address"] = address;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
            
        }
    }];
}

//删除喜事堂占用
+(void)deleteDateWithSchID:(NSString *)schID CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"DeleteDetailID";
    parameters[@"id"] = schID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

//通过帐号获取厨师档期
+(void)getCookListWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getCooksDtToCld";
    parameters[@"Tel"] = tel;
    NSMutableArray *orderArray = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"订单档期"]) {
                CLCookOccupyModel *model = [[CLCookOccupyModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [orderArray addObject:model];
            }
            completionHandler(orderArray, nil);
        }
    }];
}

//通过帐号获取厨师占用情况
+(void)getCookWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *,  NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getOccupy";
    parameters[@"Tel"] = tel;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"占用情况"]) {
                CLCookOccupyModel *model = [[CLCookOccupyModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}

//设置厨师占用日期
+(void)setDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserTel:(NSString *)userTel HallName:(NSString *)hallName ROrderName:(NSString *)rOrderName ROrderNameTel:(NSString *)rOrderNameTel CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"CooksSch";
    parameters[@"OccupyStatus"] = @"3";
    parameters[@"SolarDtFrom"] = solarDtFrom;
    parameters[@"SolarDtTo"] = solarDtTo;
    parameters[@"UserTel"] = userTel;
    parameters[@"HallName"] = hallName;
    parameters[@"ROrderName"] = rOrderName;
    parameters[@"ROrderNameTel"] = rOrderNameTel;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

//修改厨师占用日期
+(void)changeDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo SchID:(NSString *)schID UserTel:(NSString *)userTel HallName:(NSString *)hallName ROrderName:(NSString *)rOrderName ROrderNameTel:(NSString *)rOrderNameTel CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"CooksSchUP";
    parameters[@"SchID"] = schID;
    parameters[@"OccupyStatus"] = @"3";
    parameters[@"SolarDtFrom"] = solarDtFrom;
    parameters[@"SolarDtTo"] = solarDtTo;
    parameters[@"UserTel"] = userTel;
    parameters[@"HallName"] = hallName;
    parameters[@"ROrderName"] = rOrderName;
    parameters[@"ROrderNameTel"] = rOrderNameTel;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

//删除厨师档期
+(void)deleteCookDateWithSchID:(NSString *)schID CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"CooksHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"DeleteDetailID";
    parameters[@"id"] = schID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

//根据村ID获取喜事堂详情
+(void)getXiShiTangInfoWithID:(NSString *)ID CompletionHandler:(void (^)(CLVillageModel *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryHallDetail";
    parameters[@"HallID"] = ID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            NSDictionary *dict = responseObj.firstObject;
            CLVillageModel *model = [[CLVillageModel alloc]init];
            model.HallID = dict[@"HallID"];
            model.Name = dict[@"Name"];
//            model.Principal = dict[@"Principal"];
//            model.PrincipalTel = dict[@"PrincipalTel"];
            model.FeastDt = dict[@"FeastDt"];
            model.DetailAddr = dict[@"DetailAddr"];
            model.Longitude = dict[@"Longitude"];
            model.Latitude = dict[@"Latitude"];
            model.ImageUrl = dict[@"ImageUrl"];
            model.DistrictID = dict[@"DistrictID"];
            completionHandler(model, nil);
        }
    }];
}

//根据城镇ID获取所有村详情
+(void)getTownXiShiTangInfoWithTownID:(NSString *)ID CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryVillageInTown";
    parameters[@"TownID"] = ID;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSArray *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj) {
                CLVillageModel *model = [[CLVillageModel alloc]init];
                model.HallID = dict[@"HallID"];
                model.Name = dict[@"Name"];
//                model.Principal = dict[@"Principal"];
//                model.PrincipalTel = dict[@"PrincipalTel"];
//                model.FeastDt = dict[@"FeastDt"];

                model.DetailAddr = dict[@"DetailAddr"];
                model.Longitude = dict[@"Longitude"];
                model.Latitude = dict[@"Latitude"];
                model.ImageUrl = dict[@"ImageUrl"];
                model.DistrictID = dict[@"DistrictID"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}

//喜事堂设定收货地址
+(void)setXiShiTangAddressWithRecvTel:(NSString *)recvTel RecvName:(NSString *)recvName CountyID:(NSString *)countyID Details:(NSString *)details CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString:@"User.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserTel"] = us;
    parameters[@"Function"] = @"HttpNewRecvAddr";
    parameters[@"UserPhyAdd"] = KUUID;
    parameters[@"RecvTel"] = recvTel;
    parameters[@"RecvName"] = recvName;
    parameters[@"CountyID"] = countyID;
    parameters[@"Details"] = details;
    parameters[@"IsDefault"] = @"true";
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"提示"], nil);
        }
    }];
}

@end
