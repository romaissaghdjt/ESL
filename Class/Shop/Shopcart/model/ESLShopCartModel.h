//
//  ESLShopCartModel.h
//  ESL
//
//  Created by eyou on 16/11/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopCartContentModel,ShopCartContentGamishModel;
@interface ESLShopCartModel : NSObject

@property (nonatomic, strong) NSMutableArray<ShopCartContentModel *> *Content;

@property (nonatomic, copy) NSString *Type;

@property (nonatomic, assign)BOOL groupSelected;

@end

@interface ShopCartContentModel : NSObject

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, copy) NSString *MinRecvHour;

@property (nonatomic, copy) NSString *GamishTotalPrice;

@property (nonatomic, strong) NSArray<ShopCartContentGamishModel *> *Gamish;

@property (nonatomic, copy) NSString *TotalCount;

@property (nonatomic, copy) NSString *MaxRecvHour;

@property (nonatomic, copy) NSString *ProductCgy;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Price;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign)BOOL singleSelected;

@end

@interface ShopCartContentGamishModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Name;

@end

