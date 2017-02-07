//
//  ReserveRusltViewController.h
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiShiTangModel.h"
#import "BanquetTypeModel.h"
#import "FoodSeriesModel.h"

@interface ReserveRusltViewController : UIViewController
@property (copy,nonatomic) NSString *orderIDStr;//订单id
@property (copy, nonatomic) NSString *nameStr;;
@property (copy, nonatomic) NSString *sexStr;
@property (copy, nonatomic) NSString *phoneStr;
@property (copy, nonatomic) NSString *addressStr;
@property (copy, nonatomic) NSString *mainStr;
@property (copy, nonatomic) NSString *minorStr;
@property (copy, nonatomic) NSString *dateStr;
@property (nonatomic, copy)NSString *xiShiClassStr;
@property (nonatomic, copy)NSString *foodStr;
@property (nonatomic, copy)NSString *xiShiTangStr;
@property (nonatomic, copy)NSString *foodTimeStr;
@property (nonatomic, strong)CLVillageModel *villageModel;
@property (nonatomic, strong)BanquetTypeModel *banquetTypeModel;
@property (nonatomic, strong)FoodSeriesModel *foodSeriesModel;
@property (nonatomic, strong)NSArray *banquetTypeArr;
@property (nonatomic, strong)NSArray *foodSeriesArr;
@property (nonatomic, assign)BOOL isOther;
@end
