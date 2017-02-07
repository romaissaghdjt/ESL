//
//  XiShiTangModel.h
//  YY
//
//  Created by 陈龙 on 16/7/1.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLCitiesModel,CLTownsModel,CLVillageModel;

@interface XiShiTangModel : NSObject

@property (nonatomic, copy) NSString *CityName;
@property (nonatomic, copy) NSString *CityID;
@property (nonatomic, strong) NSArray<CLCitiesModel *> *Counties;

@end
@interface CLCitiesModel : NSObject

@property (nonatomic, strong) NSArray<CLTownsModel *> *Towns;

@property (nonatomic, copy) NSString *CountyID;

@property (nonatomic, copy) NSString *CountyName;
@end

@interface CLTownsModel : NSObject

@property (nonatomic, copy) NSString *TownName;

@property (nonatomic, copy) NSString *DistrictID;

@property (nonatomic, copy) NSString *TownID;

@property (nonatomic, strong) NSArray<CLVillageModel *> *Villages;

@end

@interface CLVillageModel : NSObject

@property (nonatomic, copy) NSString *HallID;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Principal;
@property (nonatomic, copy) NSString *PrincipalTel;
@property (nonatomic, copy) NSString *FeastDt;
@property (nonatomic, copy) NSString *DetailAddr;
@property (nonatomic, copy) NSString *Longitude;
@property (nonatomic, copy) NSString *Latitude;
@property (nonatomic, copy) NSString *ImageUrl;
@property (nonatomic, copy) NSString *DistrictID;

@end

