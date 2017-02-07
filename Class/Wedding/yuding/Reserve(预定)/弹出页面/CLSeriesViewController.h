//
//  CLSeriesViewController.h
//  YY
//
//  Created by 陈龙 on 16/6/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLAlertViewController.h"
#import "FoodSeriesModel.h"

@interface CLSeriesViewController : CLAlertViewController
@property (nonatomic, copy) void(^chooseBlock)(FoodSeriesModel *banquetType);
@property (nonatomic, strong)NSArray *seriesList;
@end
