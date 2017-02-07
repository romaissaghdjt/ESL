//
//  CLNetManager.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "CLNetManager.h"

@implementation CLNetManager
+(void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler
{
    // 1.初始化
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


//    // 2.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];


    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求超时时间
    
    manager.requestSerializer.timeoutInterval = 15;
    [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

@end
