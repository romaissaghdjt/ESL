//
//  FeastDtiallleftCell.h
//  YY
//
//  Created by 赵洁 on 16/6/16.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CuisineModel.h"
@interface FeastDtiallleftCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *TopView;
@property (strong, nonatomic) IBOutlet UILabel *NameLable;
@property (nonatomic, strong)CuisineModel *model;
@property (nonatomic, strong)NSMutableArray *array;
@end
