//
//  ESLThreeCell.m
//  ESL
//
//  Created by eyou on 17/1/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLThreeCell.h"
@interface ESLThreeCell()
@property (nonatomic, assign)NSInteger totalTime;
@property (nonatomic, strong)UILabel *hourLabel;
@property (nonatomic, strong)UILabel *minuteLabel;
@property (nonatomic, strong)UILabel *secondLabel;
@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *timeOverLabel;
@property (nonatomic, strong)UIView *timeView;
@end

@implementation ESLThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initContent
{
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KWIDTH/5.0 * 2, KWIDTH/5*3.0)];
    self.btn1.tag = 11;
    [self.btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, KWIDTH/5.0 * 2 * 3 / 5.0, KWIDTH/5*3.0*0.5*0.4 - 20)];
    imageView.image = [UIImage imageNamed:@"秒抢购"];
    [self.btn1 addSubview:imageView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, KWIDTH/5*3.0*0.5*0.4, KWIDTH/5.0 * 2 - 10, KWIDTH/5*3.0*0.5*0.2)];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self.btn1 addSubview:_nameLabel];
    
    _timeOverLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _nameLabel.y+_nameLabel.height, self.btn1.width, 20)];
    _timeOverLabel.text = @"本次抢购已结束";
    _timeOverLabel.font = [UIFont systemFontOfSize:14];
    [self.btn1 addSubview:_timeOverLabel];
    
    _timeView = [[UIView alloc]initWithFrame:CGRectMake(0, _nameLabel.y+_nameLabel.height, self.btn1.width, 20)];
    [self.btn1 addSubview:_timeView];
    
    _hourLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 18, 20)];
    
    _hourLabel.font = [UIFont systemFontOfSize:13];
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    _hourLabel.backgroundColor = [UIColor darkGrayColor];
    _hourLabel.textColor = [UIColor whiteColor];
    [_timeView addSubview:_hourLabel];
    //冒号
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, 10, 20)];
    label1.text = @":";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor whiteColor];
    [_timeView addSubview:label1];
    
    _minuteLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 0, 18, 20)];
    _minuteLabel.textAlignment = NSTextAlignmentCenter;
    _minuteLabel.font = [UIFont systemFontOfSize:13];
    
    _minuteLabel.backgroundColor = [UIColor darkGrayColor];
    _minuteLabel.textColor = [UIColor whiteColor];
    [_timeView addSubview:_minuteLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(51, 0, 10, 20)];
    label2.text = @":";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.backgroundColor = [UIColor whiteColor];
    [_timeView addSubview:label2];
    
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(61, 0, 18, 20)];
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.font = [UIFont systemFontOfSize:14];
    
    _secondLabel.textColor = [UIColor whiteColor];
    _secondLabel.backgroundColor = [UIColor darkGrayColor];
    [_timeView addSubview:_secondLabel];
    
    _imageBuy = [[UIImageView alloc]initWithFrame:CGRectMake(0, _timeView.y+_timeView.height+10, KWIDTH/5.0 * 2, KWIDTH/5*3.0-_timeView.y-_timeView.height-10)];
    [self.btn1 addSubview:_imageBuy];
    
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH/5.0 * 2, 0, KWIDTH/5.0 * 3, KWIDTH/5*3.0/5*3.0)];
    self.btn2.tag = 12;
    [self.btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH/5.0 * 2, KWIDTH/5*3.0/5*3.0, KWIDTH/5.0 * 3, KWIDTH/5*3.0/5*2.0)];
    self.btn3.tag = 13;
    [self.btn3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.btn1];
    [self.contentView addSubview:self.btn2];
    [self.contentView addSubview:self.btn3];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 5)];
    view1.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH/5.0 * 2 - 1, 0, 2, KWIDTH/5*3.0)];
    view2.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(KWIDTH/5.0 * 2, KWIDTH/5*3.0/5*3.0, KWIDTH/5.0 * 3, 2)];
    view3.backgroundColor = ZXColor(233, 233, 233, 1);
    [self.contentView addSubview:view3];
    
}

-(void)creatThreeImage:(NSArray *)array WithStr:(NSString *)string
{
    _nameLabel.text = string;
    [_imageBuy sd_setImageWithURL:[NSURL URLWithString:array[0][@"Image"]]];
    [self.btn2 sd_setImageWithURL:[NSURL URLWithString:array[1][@"Image"]] forState:UIControlStateNormal];
    [self.btn3 sd_setImageWithURL:[NSURL URLWithString:array[2][@"Image"]] forState:UIControlStateNormal];
}

-(void)setBaseTime:(NSInteger)totalTimes
{
    self.totalTime = totalTimes;
    NSInteger hour = 0;
    NSInteger min = 0;
    NSInteger sec = 0;
    
    if (totalTimes > 0) {
        self.timeOverLabel.hidden = YES;
        self.timeView.hidden = NO;
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        hour = totalTimes/3600;
        min = totalTimes%3600/60;
        sec = totalTimes%3600%60;
    }
    else
    {
        self.timeOverLabel.hidden = NO;
        self.timeView.hidden = YES;
    }
    _hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
    _secondLabel.text = [NSString stringWithFormat:@"%02ld", sec];
    _minuteLabel.text = [NSString stringWithFormat:@"%02ld", min];
}

-(void)timeFireMethod:(NSTimer *)timer
{
    self.totalTime--;
    if (self.totalTime == 0) {
        [timer invalidate];
        timer = nil;
        self.timeOverLabel.hidden = NO;
        self.timeView.hidden = YES;
    }
    NSInteger hour = self.totalTime/3600;
    NSInteger min = self.totalTime%3600/60;
    NSInteger sec = self.totalTime%3600%60;
    _hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
    _minuteLabel.text = [NSString stringWithFormat:@"%02ld", min];
    _secondLabel.text = [NSString stringWithFormat:@"%02ld", sec];
    _minuteLabel.text = [NSString stringWithFormat:@"%02ld", min];
}

-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 11) {
        [self.delegate clickButtonWithType:@"fastBuy"];
    }
    else if(sender.tag == 12)
    {
        [self.delegate clickButtonWithType:@"cookers"];
    }
    else
    {
        [self.delegate clickButtonWithType:@"hotFood"];
    }
    
}

@end
