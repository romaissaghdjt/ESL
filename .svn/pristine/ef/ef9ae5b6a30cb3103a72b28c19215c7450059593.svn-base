//
//  FreashModel.h
//  ESL
//
//  Created by eyou on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Basedata,Evaluateoverview,Details,RecommendFreash;
@interface FreashModel : NSObject

@property (nonatomic, strong) Basedata *BaseData;

@property (nonatomic, copy) NSString *RobData;

@property (nonatomic, strong) NSArray<RecommendFreash *> *RecommendFreash;

@property (nonatomic, strong) Evaluateoverview *EvaluateOverView;


@end

@interface Basedata : NSObject

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, copy) NSString *Number;

@property (nonatomic, copy) NSString *NormUnit;

@property (nonatomic, copy) NSString *MinRecvHour;

@property (nonatomic, copy) NSString *Remark;

@property (nonatomic, copy) NSString *MaxRecvHour;

@property (nonatomic, copy) NSString *Sales;

@property (nonatomic, copy) NSString *ProUnit;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Price;

@property (nonatomic, copy) NSString *IsOnLine;

@property (nonatomic, copy) NSString *Robberable;

@property (nonatomic, copy) NSString *IsSeasonal;
@end

@interface Evaluateoverview : NSObject

@property (nonatomic, copy) NSString *AvStar;

@property (nonatomic, strong) NSArray<Details *> *Details;

@property (nonatomic, copy) NSString *TotalCount;

@end

@interface Details : NSObject

@property (nonatomic, copy) NSString *StarCount;

@property (nonatomic, copy) NSString *Remark;

@property (nonatomic, copy) NSString *EvaluateDt;

@property (nonatomic, copy) NSString *EvaluateTel;

@end

@interface RecommendFreash : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, copy) NSString *Price;

@property (nonatomic, copy) NSString *Norm;

@property (nonatomic, copy) NSString *ProUnit;

@property (nonatomic, copy) NSString *IsSeasonal;

@property (nonatomic, copy) NSString *Robberable;
@end

