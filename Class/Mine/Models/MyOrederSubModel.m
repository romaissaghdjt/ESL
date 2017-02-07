//
//  MyOrederSubModel.m
//  ESL
//
//  Created by 赵洁 on 16/10/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyOrederSubModel.h"

@implementation MyOrederSubModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}
@end
