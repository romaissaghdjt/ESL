//
//  CLCarNetanager.m
//  YY
//
//  Created by 陈龙 on 16/5/31.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLCarNetanager.h"
#import "CarCompanyModel.h"
#import "CarInfoModel.h"

@implementation CLCarNetanager
+(void)getAllCarCompanyCompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"WedingCarHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getComp";
    NSMutableArray *array = [NSMutableArray array];
    [CLXiShiTangNetanager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        NSLog(@"_+_++_+_+_+_+_+_+_+_%@", responseObj);
        if (error) {
            NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"Company"]) {
                CarCompanyModel *model = [[CarCompanyModel alloc]init];
                model.pkCompanyID = dict[@"pkCompanyID"];
                model.CompanyName = dict[@"CompanyName"];
                model.Adr = dict[@"Adr"];
                model.LegalPerson = dict[@"LegalPerson"];
                model.Principal = dict[@"Principal"];
                model.PrincipalTel = dict[@"PrincipalTel"];
                model.ImgBLUrl = dict[@"ImgBLUrl"];
                model.ImgOCCUrl = dict[@"ImgOCCUrl"];
                model.ImgPTEAAUrl = dict[@"ImgPTEAAUrl"];
                model.ImgTRCUrl = dict[@"ImgTRCUrl"];
                model.fkStatusID = dict[@"fkStatusID"];
                model.ImgPTEAAUrl = dict[@"ImgPTEAAUrl"];
                model.ImgTRCUrl = dict[@"ImgTRCUrl"];
                model.fkStatusID = dict[@"fkStatusID"];
                model.Scope = dict[@"Scope"];
                model.fkCompanyCgyID = dict[@"fkCompanyCgyID"];
                model.Summary = dict[@"Summary"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
}
//
+(void)getAllCarInfoWithComPanyID:(NSString *)comPanyID ModelID:(NSString *)modelID CompletionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSString *url = [WeddURL stringByAppendingString: @"WedingCarHandler.ashx"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Action"] = @"getCarinfo";
    parameters[@"comPanyID"] = comPanyID;
    parameters[@"modelID"] = modelID;
    NSMutableArray *array = [NSMutableArray array];
    [CLXiShiTangNetanager sendRequestWithUrl:url parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        NSLog(@"===========%@", responseObj);
        if (error) {
            NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        else
        {
            for (NSDictionary *dict in responseObj[@"Carinfo"]) {
                CarInfoModel *model = [[CarInfoModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
//                model.PlateNum = dict[@"PlateNum"];
                [array addObject:model];
            }
            completionHandler(array, nil);
        }
    }];
    
}

@end
