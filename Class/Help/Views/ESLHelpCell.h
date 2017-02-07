//
//  ESLHelpCell.h
//  ESL
//
//  Created by 赵洁 on 17/1/16.
//  Copyright © 2017年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastAllModel.h"
@interface ESLHelpCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIView *namlable;
@property (strong, nonatomic) IBOutlet UIButton *fristBnt;
@property (strong, nonatomic) IBOutlet UIButton *secondBnt;
@property (strong, nonatomic) IBOutlet UIButton *thridBnt;
@property (nonatomic,strong)NSArray*imgarray;
@property (weak, nonatomic) IBOutlet UILabel *noDateLabel;

@end
