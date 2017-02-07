//
//  CarInformationViewController.h
//  YY
//
//  Created by 徐恒 on 16/5/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInfoModel.h"
#import "Name.h"
#import "CarCompanyModel.h"
@interface CarInformationViewController : UIViewController
@property (strong, nonatomic)CarInfoModel *carModel;
@property (strong, nonatomic)NSMutableArray *ary;
@property (strong, nonatomic)Name *nameModle;
@property (strong, nonatomic)CarCompanyModel*carCompanyModel;

@end
