//
//  MyOrederSubModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyOrderBaseModel.h"

@interface MyOrederSubModel : NSObject
@property (nonatomic,strong)NSString*ID;//菜的ID
@property (nonatomic,strong)NSString*ProductCgy;//模块
@property (nonatomic,strong)NSString*ImageUrl;
@property (nonatomic,strong)NSString*Name;
@property (nonatomic,strong)NSString*TotalCount;
@property (nonatomic,strong)NSString*TotalPrice;
@property (nonatomic,strong)NSMutableArray*GamishArr;
@property (nonatomic,strong)NSString*CookName;
@property (nonatomic,strong)NSString*CookTel;
@property (nonatomic,strong)NSString*GamishTotalPrice;
@property (nonatomic,strong)NSString*IsEvaluate;
@property (nonatomic,assign)NSInteger TAG;

@end
