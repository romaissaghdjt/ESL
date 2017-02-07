//
//  TownViewController.h
//  YY
//
//  Created by 陈龙 on 16/5/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"
#import "CLXiShiTangNetanager.h"

@interface TownViewController : CLAlertViewController
//用于回传数据的block
@property (nonatomic, copy) void(^chooseBlock)(CLTownsModel *townsModel);


@end
