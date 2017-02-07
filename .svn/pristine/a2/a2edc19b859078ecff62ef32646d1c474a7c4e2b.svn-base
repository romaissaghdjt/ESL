//
//  FeastAllViewModel.m
//  ESL
//
//  Created by 赵洁 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FeastAllViewModel.h"
#import "FeastAllModel.h"
#import "FeastSubModel.h"
#import <UIKit/UIKit.h>
#import "DishModel.h"

@implementation FeastAllViewModel
- (void)getFeastAllData
{
    NSString *url = [PREURL stringByAppendingPathComponent:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpGetHotFreashSetMeal"];
    
    NSLog(@"%@",url);

    [self requestWithUrl:url i:0];
    
}
//乡村喜宴re
-(void)getXCHotFeastDataWith:(NSString*)ID
{
    NSString *Url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FeastSetMeal&Function=HttpGetEntitysMainPage&ProID=%@"],ID];
    NSLog(@"%@",Url);
    [self requestWithUrl:Url i:5];
}
//冷菜
- (void)getXCCoolFeastDataWith:(NSString *)ID
{
    NSString *url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpGetEntitysMainPage1_1&ProID=%@",ID]];
    //HttpQueryAllGarnishs
    NSLog(@"%@",url);
    [self requestWithUrl:url i:6];
}
- (void)getFeastSubDataWihtstr:(NSString *)str
{
    NSString *url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpGetEntitysMainPage1_1&ProID=%@",str]];
    //HttpQueryAllGarnishs
    NSLog(@"%@",url);
    [self requestWithUrl:url i:1];
}
- (void)getGarnishsDataWithstr:(NSString *)str
{
    NSString *url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpQueryAllGamishs&ProID=%@",str]];
    
     NSLog(@"%@",url);

    [self requestWithUrl:url i:2];
}
- (void)getAddShopCallBackResultWihtstr:(NSString *)str WihtPecai:(NSString *)as
{
    if (as == nil) {
        NSString*Url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpMoveToShoppingCart&UserTel=%@&UserPhyAdd=%@&ProID=%@&GamishInfo=nill",us,KUUID,str]];
        NSLog(@"%@",Url);
        [self requestWithUrl:Url i:3];
    }else
    {
        //HttpNewRecvAddr
        //[PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"HttpNewRecvAddr"
       NSString*Url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpMoveToShoppingCart&UserTel=%@&UserPhyAdd=%@&ProID=%@&GamishInfo=%@",us,KUUID,str,as]];
        [self requestWithUrl:Url i:3];

    }
    
}
//获取评价
- (void)getFeastEvaluateDataWihtstr:(NSString *)str
{
    NSString*Url = [PREURL stringByAppendingPathComponent:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpQueryAllEvaluate&ProID=%@",str]];
    NSLog(@"%@",Url);
    [self requestWithUrl:Url i:4];
}
- (void)requestWithUrl:(NSString*)url i:(NSInteger)i
{
   
        
        // 耗时的操作
        [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
            
                // 更新界面
                if (i == 0) {
                    [self jsonParserWithData:data];
                    
                }else if(i == 1){
                    [self jsonParserWithFeastSubData:data];
                }else if(i == 2)
                {
                    [self jsonParserFeastGarnishsData:data];
                }else if(i == 3)
                {
                    [self jsonParserAddShopBackData:data];
                }else if(i == 4)
                {
                    [self jsonParserEvaluateData:data];

                }else if(i == 5)
                {
                    [self jsonParserXCHOTWithData:data];

                }else
                {
                    [self jsonParserXCCOOLWithData:data];
                }
            
        } failedWithError:^(NSError *connectionError) {
            
        }];
        
        
        

    
}

//=================
- (void)jsonParserWithData:(NSData*)data
{
    NSArray*array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSMutableArray*DataArray = [NSMutableArray array];
    for (NSDictionary*dic in array) {
        NSDictionary*dic1 = dic[@"BaseDate"];
        FeastAllModel*model = [[FeastAllModel alloc]init];
        model.ProductCgy = @"FreashSetMeal";
        [model setValuesForKeysWithDictionary:dic1];
        model.Content = dic[@"Content"];
        [DataArray addObject:model];
    }
    _DataSourceBlock(DataArray);
}
//==================主===========================================

- (void)jsonParserWithFeastSubData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSDictionary*dic1 = dic[@"BaseData"];
    self.Allmodel = [[FeastAllModel alloc]init];
    [_Allmodel setValuesForKeysWithDictionary:dic1];
    NSArray*array = dic[@"Content"];
    NSMutableArray*MianArray = [NSMutableArray array];
    for (NSDictionary*dics in array) {
        FeastSubModel*Smodel  = [[FeastSubModel alloc]init];
        [Smodel setValuesForKeysWithDictionary:dics];
        [MianArray addObject:Smodel];

    }
    _FeastSubHeadBlock(_Allmodel);

    _DataSourceBlock(MianArray);
    
}
//==================配菜=====================
- (void)jsonParserFeastGarnishsData:(NSData*)data
{
    NSArray*array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSMutableArray*MianArray = [NSMutableArray array];

    for (NSDictionary*dic in array) {
        self.Allmodel = [[FeastAllModel alloc]init];
        [self.Allmodel setValuesForKeysWithDictionary:dic];
        [MianArray addObject:self.Allmodel];
    }
    
    _FeastGarnishsBlock(MianArray);
    
    
}
//==========加入购物车========
-(void)jsonParserAddShopBackData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSString*str = dic[@"提示"];
    _AddShopBlock(str);
}


-(void)jsonParserEvaluateData:(NSData*)data
{
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSArray*arr = dic[@"Details"];
    NSMutableArray *array = [NSMutableArray array];

    for (NSDictionary*dics in arr) {
        FeastSubModel*model = [[FeastSubModel alloc]init];
        model.Remark = dics[@"Remark"];
        [model setValuesForKeysWithDictionary:dics];
        [array addObject:model];

    }
    
    _FeastEvaluateBlock(array);

    
}


//乡村
- (void)jsonParserXCHOTWithData:(NSData*)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    if (dic.count == 0) {
        NSLog(@"为空===================================");
        return ;
    }else{
        
        
        NSDictionary*dica = dic[@"Content"];
        NSArray*hotarray = dica[@"热菜"];
        NSMutableArray* hotArray = [NSMutableArray array];
        for (NSDictionary*dics in hotarray) {
            DishModel*Dmodel = [[DishModel alloc]init];
            [Dmodel setValuesForKeysWithDictionary:dics];
            [hotArray addObject:Dmodel];
        }
        
        _XCBlock(hotArray);
    }
}
//乡村
- (void)jsonParserXCCOOLWithData:(NSData*)data
{
    //ContentCold
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSDictionary*dic1 = dic[@"BaseData"];
    self.Allmodel = [[FeastAllModel alloc]init];
    [_Allmodel setValuesForKeysWithDictionary:dic1];
    NSArray*array = dic[@"ContentCold"];
    NSMutableArray*MianArray = [NSMutableArray array];
    for (NSDictionary*dics in array) {
        FeastSubModel*Smodel  = [[FeastSubModel alloc]init];
        [Smodel setValuesForKeysWithDictionary:dics];
        [MianArray addObject:Smodel];
        
    }
    _FeastSubHeadBlock(_Allmodel);
    
    _DataSourceBlock(MianArray);
    
    
    
    
}
@end
