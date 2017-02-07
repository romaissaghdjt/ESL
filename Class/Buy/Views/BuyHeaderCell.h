//
//  BuyHeaderCell.h
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeOverLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;
-(void)settTimeValue:(NSInteger)totalTime;
@end
