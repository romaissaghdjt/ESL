//
//  SinglFaestCell.h
//  ESL
//
//  Created by 赵洁 on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastSubModel.h"
@interface SinglFaestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *timelable;
@property (weak, nonatomic) IBOutlet UILabel *summerLable;

@property (nonatomic,strong)FeastSubModel*model;
@end
