//
//  MyCollectionModel.m
//  ESL
//
//  Created by 徐恒 on 2016/11/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyCollectionModel.h"

@implementation MyCollectionModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}
@end
