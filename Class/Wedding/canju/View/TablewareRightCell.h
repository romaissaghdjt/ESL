//
//  TablewareRightCell.h
//  YY
//
//  Created by 徐恒 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"
@interface TablewareRightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic)NSString *StarLevel;
@property (strong, nonatomic)ClassificationModel *model;

@end
