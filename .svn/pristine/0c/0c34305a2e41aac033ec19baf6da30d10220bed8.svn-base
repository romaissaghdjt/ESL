//
//  ESLPayModel.m
//  ESL
//
//  Created by eyou on 16/12/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLPayModel.h"

@implementation ESLPayModel
+(NSArray *)getPayList
{
    NSMutableArray *listArray = [NSMutableArray array];
    ESLPayModel *model1 = [[ESLPayModel alloc]init];
    model1.imageName = @"zhifubao";
    model1.describeName = @"支持有支付宝,网银的用户使用";
    model1.btnIsSelect = YES;
    model1.nameText = @"支付宝";
    
    ESLPayModel *model2 = [[ESLPayModel alloc]init];
    model2.imageName = @"weixin";
    model2.describeName = @"只用微信支付,安全便捷";
    model2.btnIsSelect = NO;
    model2.nameText = @"微信支付";
    
    [listArray addObject:model1];
    [listArray addObject:model2];
    return listArray;
}
@end
