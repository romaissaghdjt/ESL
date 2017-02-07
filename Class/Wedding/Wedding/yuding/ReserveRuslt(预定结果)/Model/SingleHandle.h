//
//  SingleHandle.h
//  SixPassValue_single
//
//  Created by zhangwei on 15/11/13.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleHandle : NSObject
+ (SingleHandle *)shareSingleHandle;

@property (weak,nonatomic) NSNumber *orderID;//订单id
@property (strong, nonatomic) NSString *name1;;
@property (strong, nonatomic) NSString *sex1;
@property (strong, nonatomic) NSString *phone1;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *date;

@end
