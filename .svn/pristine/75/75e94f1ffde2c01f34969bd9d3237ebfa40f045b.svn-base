//
//  CLXiShiTangNetanager.m
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLXiShiTangNetanager.h"
#import "BanquetTypeModel.h"
#import "FoodSeriesModel.h"
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


+(void)getAllDistrictDateWithCompletionHandler:(void (^)(XiShiTangModel *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getVillageAllInfoByCityID";
    parameters[@"CityID"] = @"1";
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
                completionHandler(nil, error);
            }
            else {
                completionHandler([XiShiTangModel yy_modelWithJSON:responseObj], nil);
            }
        
        }
        
    ];

}

//通过村获取占用情况
+(void)getOccupationWithVillageID:(NSString *)villageID CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"HallsHandler.ashx"];
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
+(void)getJoinWithDrowID:(NSString *)drowID JoinTel:(NSString *)joinTel CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString:@"HandlerDraw.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"SignUp";
    parameters[@"JoinTel"] = joinTel;
    parameters[@"DrowID"] = drowID;
    
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"结果"], nil);
        }
    }];
}
//开奖
+(void)getStartLotteryWithDrowID:(NSString *)drowID DrawLevel:(NSString *)drawLevel CreatorTel:(NSString *)creatorTel CustPhyAddr:(NSString *)custPhyAddr CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HandlerDraw.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"SelectOne";
    parameters[@"DrowID"] = drowID;
    parameters[@"DrawLevel"] = drawLevel;
    parameters[@"CreatorTel"] = creatorTel;
    parameters[@"CustPhyAddr"] = custPhyAddr;
    
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"结果"], nil);
        }
    }];
}
//查看开奖号码
+(void)getCurrentNumWithDrowID:(NSString *)drowID CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HandlerDraw.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"GetAll";
    parameters[@"DrowID"] = drowID;
    
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            // NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in responseObj[@"结果"]) {
                CLCheckNumModel *model = [[CLCheckNumModel alloc]init];
                model.WinnerTel = dict[@"WinnerTel"];
                model.NameS = dict[@"NameS"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}

//发起抽奖获取验证码
+(void)getCodeDrawWithTel:(NSString *)tel CustPhyAddr:(NSString *)custPhyAddr CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HandlerDraw.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"Create";
    parameters[@"CreatorTel"] = tel;
    parameters[@"CustPhyAddr"] = custPhyAddr;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"抽奖验证码"], nil);
        }
    }];
}

//结束抽奖
+(void)stopDrawWithCreatorTel:(NSString *)creatorTel CustPhyAddr:(NSString *)custPhyAddr DrowID:(NSString *)drowID CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HandlerDraw.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"Stop";
    parameters[@"CreatorTel"] = creatorTel;
    NSLog(@"%@", creatorTel);
    parameters[@"CustPhyAddr"] = custPhyAddr;
    NSLog(@"%@", custPhyAddr);
    parameters[@"DrowID"] = drowID;
    NSLog(@"%@", drowID);
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            completionHandler(responseObj[@"结果"], nil);
        }
    }];
}

//设置喜事堂占用日期
+(void)setDateWithSolarDtFrom:(NSString *)solarDtFrom SolarDtTo:(NSString *)solarDtTo UserName:(NSString *)userName HallID:(NSString *)hallID Tel:(NSString *)tel Dinner:(NSString *)dinner Vice:(NSString *)vice Address:(NSString *)address CompletionHandler:(void (^)(NSString *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"LoginCheckHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"MainPageMsgHandler.ashx"];
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
+(void)getCompleteOrderCount:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"MainPageMsgHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"GetAllAndFinishOrder";
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
//获取婚宴类型和八大菜系
+(void)getBanquetTypeWithCompletionHandler:(void (^)(NSArray *, NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString:@"BookHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"bookPage";
    NSMutableArray *banquetTypeArray = [NSMutableArray array];
    NSMutableArray *foodSeriesArray = [NSMutableArray array];
    [CLXiShiTangNetanager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil,nil,error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"Type"]) {
                BanquetTypeModel *model = [[BanquetTypeModel alloc]init];
                model.pkFstCgyID = dict[@"pkFstCgyID"];
                
                model.Name = dict[@"Name"];
                [banquetTypeArray addObject:model];
            }
            for (NSDictionary *dict in responseObj[@"series"]) {
                FoodSeriesModel *model = [[FoodSeriesModel alloc]init];
                model.ID = dict[@"ID"];
                model.Name = dict[@"Name"];
                [foodSeriesArray addObject:model];
            }
            completionHandler(banquetTypeArray, foodSeriesArray, nil);
        }
        
    }];
    
}

//通过帐号获取喜事堂列表
+(void)getXiShiListWithTel:(NSString *)tel CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString: @"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"CooksHandler.ashx"];
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
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getdetail";
    parameters[@"ID"] = ID;
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            NSDictionary *dict = ((NSArray *)responseObj[@"详情"]).firstObject;
            CLVillageModel *model = [[CLVillageModel alloc]init];
            model.HallID = dict[@"HallID"];
            model.Name = dict[@"Name"];
            model.Principal = dict[@"Principal"];
            model.PrincipalTel = dict[@"PrincipalTel"];
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
    NSString *url = [WeddURL stringByAppendingString:@"HallsHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getVillage";
    parameters[@"ID"] = ID;
    NSMutableArray *array = [NSMutableArray array];
    [self sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"乡村"]) {
                CLVillageModel *model = [[CLVillageModel alloc]init];
                model.HallID = dict[@"HallID"];
                model.Name = dict[@"Name"];
                model.Principal = dict[@"Principal"];
                model.PrincipalTel = dict[@"PrincipalTel"];
                model.FeastDt = dict[@"FeastDt"];
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

@end
