//
//  PriceRangeController.h
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^priceIndex) (NSString *);
@interface PriceRangeController : UIViewController
@property (strong, nonatomic)priceIndex block2;
@end
