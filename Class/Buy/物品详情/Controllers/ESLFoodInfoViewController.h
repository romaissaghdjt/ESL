//
//  ESLFoodInfoViewController.h
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLBuyModel.h"
#import "ConfirmOrderController.h"
@interface ESLFoodInfoViewController : UIViewController
@property (nonatomic, strong)ESLBuyModel *buyModel;
@property (nonatomic, assign)BOOL isFromRob;
@property (nonatomic, assign)FROMTYPE type;

@end
