//
//  VillageViewController.h
//  YY
//
//  Created by 陈龙 on 16/5/29.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"
#import "CLXiShiTangNetanager.h"

@interface VillageViewController : CLAlertViewController
//用于回传数据的block
@property (nonatomic, copy) void(^chooseBlock)(CLVillageModel *V=villageModel);

@end
