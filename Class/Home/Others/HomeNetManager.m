//
//  HomeNetManager.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "HomeNetManager.h"



@implementation HomeNetManager
//获取抢购时间
+(void)getRobbeyTimeWithCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Promoting.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"GetRobbeyTime";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        }
        else {
            completionHandler(responseObj, nil);
        }
    }
     ];
}

//获取抢购描述
//+(void)getRobbeyDescribeWithCompletionHandler:(void (^)(NSString *, NSError *))completionHandler
//{
//    NSString *url = [PREURL stringByAppendingString: @"Promoting.ashx"];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"Function"] = @"GetPanicbuyDescribe";
//    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
//        if (error) {
//            completionHandler(nil, error);
//        }
//        else {
//            completionHandler(responseObj[@"提示"], nil);
//        }
//    }
//     ];
//}

//获取首页分类图片
+(void)getHomeCategoryPictureWithCompletionHandler:(void (^)(NSArray *singleArray, NSArray *threeArray, NSArray *topArray,NSString *describeStr, NSError *error))completionHandler
{
    NSString *url = [PREURL stringByAppendingString: @"Other.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"HttpQueryAppMainPage";
    [CLNetManager sendRequestWithUrl:url parameters:parameters completionHandler:^(NSDictionary *responseObj, NSError *error) {
        if (error) {
            completionHandler(nil, nil, nil, nil, error);
        }
        else {
            NSMutableArray *singleArray = [NSMutableArray array];
            NSMutableArray *topArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObj[@"GetAdvs"]) {
                [singleArray addObject:[ESLSingleArrayModel yy_modelWithJSON:dict]];
            }
            for (NSDictionary *dict in responseObj[@"GetTopPicture"]) {
                [topArray addObject:[ESLSingleArrayModel yy_modelWithJSON:dict]];
            }
            completionHandler(singleArray,responseObj[@"GetPicture"], topArray,responseObj[@"GetPanicbuyDescribe"][@"Resault"], nil);
        }
    }
    ];
}

@end
