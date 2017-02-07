//
//  ShowCell.h
//  YY
//
//  Created by 徐恒 on 16/5/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeddingModel.h"

@interface ShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *displayView;//展示的作品
@property (strong, nonatomic)WeddingModel *WeddingModel;
@end