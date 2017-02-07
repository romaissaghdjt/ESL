//
//  CarInfoModel.h
//  YY
//
//  Created by 陈龙 on 16/5/31.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfoModel : NSObject
@property (nonatomic, strong)NSNumber *pkCarID;
@property (nonatomic, copy)NSString *PlateNum;
@property (nonatomic, strong)NSNumber *fkCarModelID;
@property (nonatomic, copy)NSString *CarFrameNum;
@property (nonatomic, copy)NSString *CarColor;
@property (nonatomic, strong)NSNumber *fkCarRentStatusID;
@property (nonatomic, strong)NSNumber *Seating;
@property (nonatomic, strong)NSNumber *fkCompanyID;
@property (nonatomic, copy)NSString *imgeUrl;
@property (nonatomic, strong)NSNumber *price;
@property (strong, nonatomic)NSString *StyleIndex;//四星
@property (copy, nonatomic)NSString *StarNum;
@end
