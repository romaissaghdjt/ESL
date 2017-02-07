//
//  ESLBagHeaderCell.h
//  ESL
//
//  Created by eyou on 17/1/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreashModel.h"

@interface ESLBagHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint4;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

-(void)reloadCellInfo:(FreashModel *)model;
@end
