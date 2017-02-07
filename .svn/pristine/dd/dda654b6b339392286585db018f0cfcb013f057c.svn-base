//
//  BuyHeaderCell.m
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "BuyHeaderCell.h"

@interface BuyHeaderCell ()
@property (nonatomic, assign)NSInteger totalTime;
@end

@implementation BuyHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)settTimeValue:(NSInteger)totalTime
{
    NSInteger hour = 0;
    NSInteger min = 0;
    NSInteger sec = 0;
    self.totalTime = totalTime;
    
    if (totalTime > 0) {
        self.timeView.hidden = NO;
        self.timeOverLabel.hidden = YES;
        
        hour = totalTime/3600;
        min = totalTime%3600/60;
        sec = totalTime%3600%60;
        
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    else
    {
        self.timeView.hidden = YES;
        self.timeOverLabel.hidden = NO;
    }
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, min, sec];
    NSLog(@"%@", _timeLabel.text);
}

-(void)timeFireMethod:(NSTimer *)timer
{
    self.totalTime--;
    if (self.totalTime == 0) {
        [timer invalidate];
        timer = nil;
        self.timeView.hidden = YES;
        self.timeOverLabel.hidden = NO;
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"StopBuy" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        
    }
    
    NSInteger hour = self.totalTime/3600;
    NSInteger min = self.totalTime%3600/60;
    NSInteger sec = self.totalTime%3600%60;
    
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, min, sec];
    
}
@end
