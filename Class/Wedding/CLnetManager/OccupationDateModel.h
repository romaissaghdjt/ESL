//
//  OccupationDateModel.h
//  YY
//
//  Created by 陈龙 on 16/6/12.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OccupationDateModel : NSObject
@property (nonatomic, copy)NSString *SchID;
//开始
@property (nonatomic, copy)NSString *SolarDtFrom;
//结束
@property (nonatomic, copy)NSString *SolarDtTo;
@property (nonatomic, copy)NSString *LunarDt;
@property (nonatomic, copy)NSString *HallStatus;
@property (nonatomic, copy)NSString *HallID;
@property (nonatomic, copy)NSString *UserName;

@property (nonatomic, copy)NSString *FeastCgy;
//@property (nonatomic, copy)NSString *pkTakenID;




@end
