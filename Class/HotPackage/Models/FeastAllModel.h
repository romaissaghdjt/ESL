//
//  FeastAllModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeastAllModel : NSObject
/**
 "ImageUrl": "",
 "Name": "参考菜单1",
 "Price": "",
 "Sales": "
 FreashSetMeal
 */

@property (nonatomic,strong)NSString*ImageUrl;
@property (nonatomic,strong)NSString*Name;
@property (nonatomic,strong)NSString*Price;
@property (nonatomic,strong)NSString*Sales;
@property (nonatomic,strong)NSString*Content;
@property (nonatomic,strong)NSString*ID;
@property (nonatomic,strong)NSString*Feature;//评价
@property (nonatomic,strong)NSString*Remark;//公告
@property (nonatomic,strong)NSString*ProductCgy;//模块
@property (nonatomic,strong)NSString*MaxRecvHour;//最大期限
@property (nonatomic,strong)NSString*MinRecvHour;//最小期限
@property (nonatomic,strong)NSString*Norm;//规格

@property (nonatomic, copy)NSString *totalCount;

@end
