//
//  CLCarNetanager.h
//  YY
//
//  Created by 陈龙 on 16/5/31.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLXiShiTangNetanager.h"

@interface CLCarNetanager : NSObject
+(void)getAllCarCompanyCompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
+(void)getAllCarInfoWithComPanyID:(NSString *)comPanyID ModelID:(NSString *)modelID CompletionHandler:(void (^)(NSArray *array, NSError *error))completionHandler;
@end
