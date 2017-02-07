//
//  FasetShowCell.h
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastSubModel.h"
#import "DishModel.h"
@interface FasetShowCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *replceBut;
@property (strong, nonatomic) IBOutlet UILabel *FeastName;
@property (strong, nonatomic) IBOutlet UIImageView *FeastImage;
@property (strong, nonatomic) IBOutlet UILabel *FeastNormLable;
@property (strong, nonatomic) FeastSubModel *model;
@property (strong, nonatomic) DishModel *Dmodel;

@end
