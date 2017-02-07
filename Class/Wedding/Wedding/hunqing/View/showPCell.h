//
//  showPCell.h
//  YY
//
//  Created by 赵洁 on 16/6/17.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeddingModel.h"
@interface showPCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *Pimg;
@property (strong, nonatomic) IBOutlet UILabel *PriceLable;
@property (strong, nonatomic) WeddingModel *model;
@end
