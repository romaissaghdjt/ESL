//
//  FeastDtiallController.h
//  YY
//
//  Created by 赵洁 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartFeastModel.h"
//#import "DishModel.h"
@interface FeastDtiallController : UIViewController
@property (nonatomic, strong)StartFeastModel *model;
//@property (strong, nonatomic)DishModel *dishModel;
@property (assign, nonatomic)BOOL isHelp_com;

@end
