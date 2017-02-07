//
//  ESLCookerDescriptionCell.h
//  ESL
//
//  Created by eyou on 16/11/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESLCookerDescriptionCell;

@protocol ESLCookerDescriptionCellDelegate <NSObject>

-(void)downArrowBtnClick:(ESLCookerDescriptionCell *)cell Button:(UIButton *)sender;

@end

@interface ESLCookerDescriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverLimitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxNumLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *downArrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint;
@property (nonatomic, assign)id<ESLCookerDescriptionCellDelegate> delegate;
@end
