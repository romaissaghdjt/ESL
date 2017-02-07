//
//  ESLSingleFoodCell.h
//  ESL
//
//  Created by eyou on 16/12/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLBagModel.h"

@interface ESLSingleFoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
-(void)setValueWithModel:(ESLBagModel *)model;
@end
