//
//  ConfirmOrderController.h
//  ESL
//
//  Created by 徐恒 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastAllModel.h"

typedef enum
{
    //单品,抢购,购物车,套餐(人气套餐),
    FREASH,SNAP,SHOPPING,PACKAGE,BAG
}FROMTYPE;

@interface ConfirmOrderController : UIViewController
//套餐
@property (nonatomic, strong)NSArray *feastArray;
//单品
@property (nonatomic, strong)NSArray *singleProArray;

@property (nonatomic, assign)FROMTYPE type;

@property ( nonatomic)BOOL isRefresh;//是否刷新
@end
