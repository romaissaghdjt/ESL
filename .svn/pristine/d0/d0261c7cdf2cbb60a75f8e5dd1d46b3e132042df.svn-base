//
//  CLCalendarViewController.m
//  YY
//
//  Created by 陈龙 on 16/7/21.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLCalendarViewController.h"
#import "NSDate+Calendar.h"
#import "OrderCalendarView.h"

@interface CLCalendarViewController ()<OrderCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@end

@implementation CLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WK(weakSelf)
    self.title = @"日历";
    OrderCalendarView *calendarView = [[OrderCalendarView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 370)CurrentArray:nil];
    calendarView.delgate = self;
    [weakSelf.calendarView addSubview:calendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postWithDateStr:(NSString *)dateStr
{
    self.PushData(dateStr);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
