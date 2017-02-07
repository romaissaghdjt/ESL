//
//  CategoryController.h
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CategoryControllerDelegeta<NSObject>;
@end
typedef void (^cargetaIndex)(NSString *);
@interface CategoryController : UITableViewController
@property (copy, nonatomic)cargetaIndex block1;
@end
