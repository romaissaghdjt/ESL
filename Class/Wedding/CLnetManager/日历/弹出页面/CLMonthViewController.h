//
//  CLMonthViewController.h
//  test
//
//  Created by 陈龙 on 16/5/24.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "CLAlertViewController.h"

@interface CLMonthViewController : CLAlertViewController

//用于回传数据的block
@property (nonatomic, copy) void(^chooseBlock)(NSInteger monthValue);

@property (nonatomic, copy)NSString *monthStr;
@property (nonatomic, assign) NSInteger indexP;
@end
