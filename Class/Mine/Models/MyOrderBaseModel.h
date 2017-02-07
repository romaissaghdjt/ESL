//
//  MyOrderBaseModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderBaseModel : NSObject
@property (nonatomic,strong)NSString*ID;//傻逼那家订单号名称叫ID;
@property (nonatomic,strong)NSString*Status;
@property (nonatomic,strong)NSString*TotalPrice;
@property (nonatomic,strong)NSString*Freight;
@property (nonatomic,strong)NSString*TotalCount;
@property (nonatomic,strong)NSMutableArray*Content;
@property (nonatomic,strong)NSString*RecvTime;//收货时间
@property (nonatomic) BOOL isCancl;
@property (nonatomic)BOOL isDelete;
@property (nonatomic)BOOL isWatiing;
@property (nonatomic)BOOL isSure;
@property (nonatomic)BOOL isDone;

@end

