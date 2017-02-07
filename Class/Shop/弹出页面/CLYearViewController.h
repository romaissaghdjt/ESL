//
//  CLMonthViewController.h
//  test
//
//  Created by 陈龙 on 16/5/24.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "CLAlertViewController.h"

@interface CLYearViewController : CLAlertViewController
//用于回传数据的block
@property (nonatomic, copy) void(^chooseBlock)(NSInteger yearValue);
@property (nonatomic, assign)BOOL isFromJoin;
@property (nonatomic, copy)NSString *yearStr;


@end







