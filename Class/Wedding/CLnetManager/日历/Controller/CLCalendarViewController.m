//
//  CLCalendarViewController.m
//  YY
//
//  Created by 陈龙 on 16/7/21.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLCalendarViewController.h"
#import "CLXiShiTangNetanager.h"
#import "NSDate+Calendar.h"
#import "XiShiTangCalendarView.h"

@interface CLCalendarViewController ()<XiShiTangCalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;

@end

@implementation CLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WK(weakSelf)
    self.title = @"日历";
    if (self.isFromOther == NO) {
        self.hiddenView.hidden = NO;
        [CLXiShiTangNetanager getOccupationWithVillageID:[NSString stringWithFormat:@"%ld", (long)self.villagemodel.HallID.integerValue] CompletionHandler:^(NSArray *responseObj, NSError *error) {
            NSMutableArray *possessDateArray = [NSMutableArray array];
            for (OccupationDateModel *dateModel in responseObj) {
                [possessDateArray addObjectsFromArray:[weakSelf getAllDateWithOccupationDateModel:dateModel]];
            }
            XiShiTangCalendarView *calendarView = [[XiShiTangCalendarView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 370)CurrentArray:possessDateArray];
            calendarView.isFromOther = self.isFromOther;
            calendarView.delgate = self;
            [weakSelf.calendarView addSubview:calendarView];
        }];
    }
    else
    {
        XiShiTangCalendarView *calendarView = [[XiShiTangCalendarView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 370)CurrentArray:nil];
        calendarView.isFromOther = self.isFromOther;
        calendarView.isFromJoin = self.isFromJoin;
        calendarView.delgate = self;
        [weakSelf.calendarView addSubview:calendarView];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray *)getAllDateWithOccupationDateModel:(OccupationDateModel *)dateModel
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    formatter1.dateFormat = @"yyyy/MM/d";
    
    NSString *tempStr1 = [[dateModel.SolarDtFrom componentsSeparatedByString:@" "][0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDate *solarDt = [NSDate local:[formatter1 dateFromString:tempStr1]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    formatter2.dateFormat = @"yyyyMMdd";
    NSString *solarStr = [formatter2 stringFromDate:solarDt];
    
    NSMutableArray *array = [NSMutableArray array];
    dict[@"HallStatus"] = dateModel.HallStatus;
    dict[@"list"] = solarStr;
    [array addObject:dict];
    
    NSString *tempStr2 = [[dateModel.SolarDtTo componentsSeparatedByString:@" "][0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDate *lunarDt = [NSDate local:[formatter1 dateFromString:tempStr2]];
    NSString *lunarStr = [formatter2 stringFromDate:lunarDt];
    
    NSString *dayStr = [solarStr substringFromIndex:6];
    NSString *monthStr = [solarStr substringWithRange:NSMakeRange(4, 2)];
    NSString *yearStr = [solarStr substringToIndex:4];
    if ([solarStr isEqualToString:lunarStr]) {
        return array;
    }
    else
    {
        NSInteger num = dayStr.integerValue;
        while (![solarStr isEqualToString:lunarStr]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            num++;
            if(num == 32)
            {
                dayStr = @"01";
                monthStr = [NSString stringWithFormat:@"%02ld", monthStr.integerValue + 1];
                if (monthStr.integerValue == 13) {
                    yearStr = [NSString stringWithFormat:@"%04ld", yearStr.integerValue + 1];
                    monthStr = @"01";
                }
                else
                {
                    monthStr = [NSString stringWithFormat:@"%02ld", monthStr.integerValue];
                }
            }
            else
            {
                dayStr = [NSString stringWithFormat:@"%02ld", dayStr.integerValue + 1];
            }
            solarStr = [[yearStr stringByAppendingString:monthStr] stringByAppendingString:dayStr];
            dict[@"HallStatus"] = dateModel.HallStatus;
            dict[@"list"] = solarStr;
            [array addObject:dict];
        }
    }
    return array;
    
}
-(void)postWithDateStr:(NSString *)dateStr
{
    self.PushData(dateStr);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
