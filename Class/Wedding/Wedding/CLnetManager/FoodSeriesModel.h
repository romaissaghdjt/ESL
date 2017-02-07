//
//  FoodSeriesModel.h
//  YY
//
//  Created by 陈龙 on 16/6/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodSeriesModel : NSObject
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *Name;
+(void)getFoodSeriesWithCompletionHandler:(void (^)(NSArray *foodSeries, NSError *error))completionHandler;
@end
