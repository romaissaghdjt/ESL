//
//  AddressBaseViewModel.m
//  ESL
//
//  Created by 赵洁 on 16/10/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "AddressBaseViewModel.h"

@implementation AddressBaseViewModel

- (void)AddNew_Or_ModifiyRequestWithUserTel:(NSString *)userTel UUID:(NSString *)uuid RecvTel:(NSString *)RecvTel RecvName:(NSString *)RecvName  RecvID:(NSString*)RecvID CountyID:(NSString*)CountyID Details:(NSString *)Details IsDefault:(NSString*)IsDefault isAdd:(BOOL)isAdd
{
    if (isAdd == YES) {
        //添加
        NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx?Function=HttpNewRecvAddr&UserTel=%@&UserPhyAdd=%@&RecvTel=%@&RecvName=%@&CountyID=%@&Details=%@&IsDefault=%@",userTel,uuid,RecvTel,RecvName,CountyID,Details,IsDefault]];
        NSLog(@"%@",url);
        
        [self requestWithUrl:url i:0];
        
    }else
    {
        //修改
        NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx?Function=HttpUpdateRecvAddr&UserTel=%@&UserPhyAdd=%@&RecvTel=%@&RecvName=%@&RecvID=%@&CountyID=%@&Details=%@&IsDefault=%@",userTel,uuid,RecvTel,RecvName,RecvID,CountyID,Details,IsDefault]];
        NSLog(@"%@",url);
        
        [self requestWithUrl:url i:0];
    }
}
//得到全部的收货地址
- (void)getAddNewDataWithUserTel:(NSString *)userTel UUID:(NSString *)uuid
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx?Function=HttpQueryAllRecvAddr&UserTel=%@&UserPhyAdd=%@",userTel,uuid]];
    NSLog(@"%@",url);
    
    [self requestWithUrl:url i:1];
}
//删除地址
- (void)DeleteAddressDataWithUserTel:(NSString *)UserTel UserPhyAdd:(NSString *)UserPhyAdd RecvAddrID:(NSString *)RecvAddrID
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx?Function=HttpDeleteRecvAddr&UserTel=%@&UserPhyAdd=%@&RecvAddrID=%@",UserTel,UserPhyAdd,RecvAddrID]];
    NSLog(@"%@",url);
    [self requestWithUrl:url i:0];
}
-(void)settingDefullAddressWithRecvID:(NSString *)RecvID
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx?Function=HttpSetDefaultRecvAddr&UserTel=%@&UserPhyAdd=%@&RecvID=%@",us,KUUID,RecvID]];
    
    NSLog(@"设置默认%@",url);
    [self requestWithUrl:url i:2];
}
- (void)requestWithUrl:(NSString*)url i:(NSInteger)i
{
    // 耗时的操作r
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        if (i == 0) {
            [self jsonParserAddNewWithData:data];
            
        }else if (i==1)
        {
            [self jsonParserAddressAllWithData:data];
        }else if (i == 2)
        {
            [self jsonParserAddNewWithData:data];
        }
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
    
}
//公用
- (void)jsonParserAddNewWithData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSString*str = dic[@"提示"];
    _NewAddBlock(str);
}
//解析全部收货地址
- (void)jsonParserAddressAllWithData:(NSData*)data
{
    NSArray*array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    if (array==nil) {
        return;
    }else{
    NSMutableArray*aa = [NSMutableArray array];
    for (NSDictionary*dic in array) {
        AddressMolde*model = [[AddressMolde alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [aa addObject:model];
        if ([model.isDefault isEqualToString:@"true"]) {
            [aa insertObject:model atIndex:0];
            [aa removeLastObject];
        }
    
        
    }
    _AllAddressataBlock(aa);
    }
}

@end
