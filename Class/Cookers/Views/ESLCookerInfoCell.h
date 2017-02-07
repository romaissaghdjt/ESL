//
//  ESLCookerInfoCell.h
//  ESL
//
//  Created by eyou on 16/11/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLCookerInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *cookAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recommendImage;
@property (weak, nonatomic) IBOutlet UIView *backgoundView;

@end
