//
//  MyOrderViewModel.m
//  ESL
//
//  Created by 赵洁 on 16/10/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyOrderViewModel.h"
#import "MyOrderBaseModel.h"
#import "MyOrederSubModel.h"
#import "ESLGamishModel.h"
#import "ESLUserModel.h"
@implementation MyOrderViewModel
- (void)getYes_Or_Join
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"ServerManager.ashx?ServerModule=CookServer&Function=HttpQueryJoinStatus&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:4];
    NSLog(@"%@",url);
}
- (void)getUserInfo
{
    //http://ess.nbeysx.com/ashx/User.ashx/?Function=GetInfo&UserTel=18913247634&UserPhyAdd=222222
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"User.ashx/?Function=GetInfo&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:3];
    NSLog(@"%@",url);

}
- (void)getAllOrderData
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpGetEntitysMainPage&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:0];
    NSLog(@"%@",url);
}
- (void)getNo_PayOrderData
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpQueryPrePay&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:0];
    
    NSLog(@"%@",url);
}
//待发货``
- (void)getstay_shippingOrderData
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpQueryPreSendOut&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:0];
    NSLog(@"%@",url);
}
//收货
-(void)getstay_goodsOrderData
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpQueryPreRecv&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:0];
    NSLog(@"%@",url);
}
- (void)getPreEvaluateData
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpQueryPreEvaluate&UserTel=%@&UserPhyAdd=%@",us,KUUID]];
    [self requestWithUrl:url i:0];
    NSLog(@"%@",url);
}
//得到某个订单详情信息
- (void)getevaluateOrderDataWithOrderID:(NSString*)OrderID
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpQuerySingleDetails&UserTel=%@&UserPhyAdd=%@&OrderID=%@",us,KUUID,OrderID]];
    [self requestWithUrl:url i:0];
    NSLog(@"%@",url);
}
//取消
- (void)canclOrderWithOrderID:(NSString *)OrderID
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpMoveToRubbish&UserTel=%@&UserPhyAdd=%@&OrderID=%@",us,KUUID,OrderID]];
    NSLog(@"%@",url);
    [self requestWithUrl:url i:2];
}
//删除
- (void)deleteOrderWithOrderID:(NSString *)OrderID
{
    NSString*url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpDeleteOne&UserTel=%@&UserPhyAdd=%@&OrderID=%@",us,KUUID,OrderID]];
    NSLog(@"%@",url);
    [self requestWithUrl:url i:2];
}
//确认
- (void)sureGetGoodsWithOrderID:(NSString *)OrderID
{
    NSString*url = [PREURL stringByAppendingString:[NSString stringWithFormat:@"Shopping.ashx?Component=Order&Function=HttpDetermineRecv&UserTel=%@&UserPhyAdd=%@&OrderID=%@",us,KUUID,OrderID]];
    NSLog(@"%@",url);
    [self requestWithUrl:url i:2];
}
- (void)requestWithUrl:(NSString*)url i:(NSInteger)i
{
    // 耗时的操作
    
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        if (i == 0) {
            [self jsonParserAddNewWithData:data];
            
        }else if (i == 1)
        {
            //....
        }else if (i == 2)
        {
            [self jsonParserCanclOrderWithData:data];
        }else if (i == 3)
        {
            //用户信息
            [self jsonParserUserInfoWithData:data];
            
        }else
        {
            [self jsonParserJoinYes_Or_NoWithData:data];
        }
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
    
}
- (void)jsonParserAddNewWithData:(NSData*)data
{
    
    NSArray*ar =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    if (ar == nil) {
        return;
    }else
    {
        NSMutableArray*array = [NSMutableArray array];
        
        
        //          NSString*aa = @"";
        for (NSDictionary*dic in ar) {
            MyOrderBaseModel*Bmodle = [[MyOrderBaseModel alloc]init];
            [Bmodle setValuesForKeysWithDictionary:dic];
            NSArray*aa = dic[@"Content"];
            Bmodle.Content = [NSMutableArray array];
            for (NSDictionary*dic1 in aa) {
                MyOrederSubModel*smodel = [[MyOrederSubModel alloc]init];
                
                [smodel setValuesForKeysWithDictionary:dic1];
                NSArray*ab = dic1[@"Gamish"];
                //                NSMutableArray*saray = [NSMutableArray array];;
                smodel.GamishArr = [NSMutableArray array];
                
                for (NSDictionary*dic2 in ab) {
                    ESLGamishModel *pmodel = [[ESLGamishModel alloc]init];
                    
                    [pmodel setValuesForKeysWithDictionary:dic2];
                    [smodel.GamishArr addObject:pmodel];
                }
                
                [Bmodle.Content addObject:smodel];
                
            }
            
            [array addObject:Bmodle];
            
        }
        
        
        //        for (ESLGamishModel*model in smodel.GamishArr) {
        //            aa = [aa stringByAppendingString:[NSString stringWithFormat:@"%@,",model.GamishName]];
        //        }
        _allBlock(array);
        
    }
    
    
}
- (void)jsonParserCanclOrderWithData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSString*str = dic[@"提示"];
    _Cancl_Or_DeleteBlock(str);
    
}
- (void)jsonParserUserInfoWithData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSMutableArray*array = [NSMutableArray array];
    ESLUserModel*model = [[ESLUserModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    [array addObject:model];
    _User_Block(array);
}
- (void)jsonParserJoinYes_Or_NoWithData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSString*str = dic[@"进度"];
    _Cancl_Or_DeleteBlock(str);
}
@end
