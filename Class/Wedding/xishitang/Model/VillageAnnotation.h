//
//  VillageAnnotation.h
//  YY
//
//  Created by 陈龙 on 16/5/29.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "XiShiTangModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface VillageAnnotation : NSObject<BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong)CLVillageModel *model;
@end
