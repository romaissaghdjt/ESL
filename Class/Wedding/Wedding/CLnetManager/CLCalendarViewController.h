//
//  CLCalendarViewController.h
//  YY
//
//  Created by 陈龙 on 16/7/21.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiShiTangModel.h"

@interface CLCalendarViewController : UIViewController
@property (nonatomic, copy)void(^PushData)(NSString *date);
@property (nonatomic, strong)CLVillageModel *villagemodel;
@property (nonatomic, assign)BOOL isFromOther;
@property (nonatomic, assign)BOOL isFromJoin;
@end
