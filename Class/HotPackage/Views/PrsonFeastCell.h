//
//  PrsonFeastCell.h
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastAllModel.h"
@interface PrsonFeastCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *FeastImage;//图标

@property (strong, nonatomic)FeastAllModel *model;
@end
