//
//  CLMapViewController.h
//  YY
//
//  Created by 陈龙 on 16/5/29.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiShiTangModel.h"

@interface CLMapViewController : UIViewController
@property (nonatomic, assign)double currentLatitude;
@property (nonatomic, assign)double currentLongitude;

@property (nonatomic, strong)CLVillageModel *villageModel;
@property (nonatomic, copy)NSString *townID;
@property (nonatomic, copy)void(^completionHandler)(CLVillageModel *currentVillage);

@end
