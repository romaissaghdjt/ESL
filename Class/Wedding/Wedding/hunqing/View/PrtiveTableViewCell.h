//
//  PrtiveTableViewCell.h
//  YY
//
//  Created by 赵洁 on 16/7/25.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrtiveTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lable;

+ (CGFloat)cellAoutoHigeht:(NSString *)string;
@end
