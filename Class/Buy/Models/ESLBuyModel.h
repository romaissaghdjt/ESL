//
//  ESLBuyModel.h
//  ESL
//
//  Created by eyou on 16/10/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESLBuyModel : NSObject
//抢购ID
@property (nonatomic, copy)NSString *robberyID;
//产品类别
@property (nonatomic, copy)NSString *productCgy;
//产品ID
@property (nonatomic, copy)NSString *productID;

@property (nonatomic, copy)NSString *imageUrl;
//抢购描述
@property (nonatomic, copy)NSString *reMark;
//销量
@property (nonatomic, copy)NSString *sales;
//剩余量
@property (nonatomic, copy)NSString *surplusCount;
//原价
@property (nonatomic, copy)NSString *originalPrice;
//现价
@property (nonatomic, copy)NSString *currentPrice;
//规格
@property (nonatomic, copy)NSString *norm;
-(void)setValueWithDictionary:(NSDictionary *)dict;
@end
