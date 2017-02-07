//
//  CLNetManager.h
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNetManager : NSObject
+(void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

@end
