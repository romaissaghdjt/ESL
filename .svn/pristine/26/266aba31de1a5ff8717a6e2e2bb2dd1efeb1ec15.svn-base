//
//  ESLHelpViewModle.m
//  ESL
//
//  Created by 赵洁 on 17/1/16.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLHelpViewModle.h"
#import "FeastAllModel.h"
@implementation ESLHelpViewModle
- (void)getFeastAllData
{
    NSString *url = [PREURL stringByAppendingPathComponent:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpAskAndHelp"];
    
    NSLog(@"%@",url);
    
    [self requestWithUrl:url i:0];
    
}
- (void)requestWithUrl:(NSString*)url i:(NSInteger)i
{
    // 耗时的操作
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        
        if (i == 0) {
            [self jsonParserWithData:data];
        }
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)jsonParserWithData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSMutableArray*tarray = [NSMutableArray array];
    NSMutableArray*fuarray = [NSMutableArray array];
    NSMutableArray*fiarray = [NSMutableArray array];

    NSMutableArray*mainarray = [NSMutableArray array];
    NSArray*thrrearray = dic[@"Five"];
    NSArray*fourarray = dic[@"Eight"];
    NSArray*fivearray = dic[@"Ten"];

    for (NSDictionary*dica in thrrearray) {
        FeastAllModel*model = [[FeastAllModel alloc]init];

        [model setValuesForKeysWithDictionary:dica];
        [tarray addObject:model];
        
    }
    [mainarray addObject:tarray];
    for (NSDictionary*dica in fourarray) {
        FeastAllModel*model = [[FeastAllModel alloc]init];

        [model setValuesForKeysWithDictionary:dica];
        [fuarray addObject:model];
    }
    [mainarray addObject:fuarray];

    for (NSDictionary*dica in fivearray) {
        FeastAllModel*model = [[FeastAllModel alloc]init];

        [model setValuesForKeysWithDictionary:dica];
        [fiarray addObject:model];
    }
    [mainarray addObject:fiarray];

    NSLog(@"%ld", mainarray.count);
    _DataSourceBlock(mainarray);
}
@end
