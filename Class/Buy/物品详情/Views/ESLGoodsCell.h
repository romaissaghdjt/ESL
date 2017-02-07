//
//  ESLGoodsCell.h
//  ESL
//
//  Created by eyou on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreashModel.h"
@interface ESLGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint4;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

-(void)setValueWithModel:(FreashModel *)model From:(BOOL)isFromRob;
@end
