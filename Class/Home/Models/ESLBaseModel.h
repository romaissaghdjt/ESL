//
//  ESLBaseModel.h
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ESLBaseModel.h"


@interface ESLBaseModel : NSObject
@property (nonatomic, copy)NSString *imageUrl1;
@property (nonatomic, copy)NSString *imageUrl2;
@property (nonatomic, copy)NSString *imageUrl3;
@property (nonatomic, copy)NSString *imageUrl4;


@property (nonatomic, copy)NSString *imageType1;
@property (nonatomic, copy)NSString *imageType2;
@property (nonatomic, copy)NSString *imageType3;
@property (nonatomic, copy)NSString *imageType4;

@property (nonatomic, assign)NSInteger totalTimes;

+ (instancetype)initWithArray:(NSArray *)array;
@end
