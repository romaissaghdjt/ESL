//
//  CLTypeViewController.h
//  YY
//
//  Created by 陈龙 on 16/6/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"
#import "BanquetTypeModel.h"

@interface CLTypeViewController : CLAlertViewController

@property (nonatomic, copy) void(^chooseBlock)(BanquetTypeModel *banquetType);
@property (nonatomic, strong)NSArray *typeList;
@end
