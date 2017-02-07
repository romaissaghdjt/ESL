//
//  FeastAllViewModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeastAllModel.h"
typedef void(^DataSourceBlock)(id DataSource);
typedef void(^AddShopBlock)(id CallBackSource);
typedef void(^XCBlock)(id XCSource);

typedef void(^FeastSubHeadBlock)(id HeadSource);
typedef void(^FeastGarnishsBlock)(id GarnishsSource);
typedef void(^FeastEvaluateBlock)(id EvaluateSource);

@interface FeastAllViewModel : NSObject
@property (nonatomic, copy) DataSourceBlock DataSourceBlock;
@property (nonatomic, copy) FeastSubHeadBlock FeastSubHeadBlock;
@property (nonatomic, copy) XCBlock XCBlock;
@property (nonatomic, copy) FeastGarnishsBlock FeastGarnishsBlock;

@property (nonatomic,copy)AddShopBlock AddShopBlock;
@property (nonatomic,copy)FeastEvaluateBlock FeastEvaluateBlock;

@property (nonatomic,strong)FeastAllModel*Allmodel;
- (void)getFeastAllData;
- (void)getFeastSubDataWihtstr:(NSString*)str;
-(void)getGarnishsDataWithstr:(NSString*)str;
-(void)getAddShopCallBackResultWihtstr:(NSString*)str WihtPecai:(NSString*)as;
-(void)getFeastEvaluateDataWihtstr:(NSString*)str;
- (void)getXCHotFeastDataWith:(NSString*)ID;
- (void)getXCCoolFeastDataWith:(NSString*)ID;

@end
