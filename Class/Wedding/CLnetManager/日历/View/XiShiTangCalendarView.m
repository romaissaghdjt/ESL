//
//  CLCalendarView.m
//  日历整理
//
//  Created by 陈龙 on 16/7/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "XiShiTangCalendarView.h"
#import "DateModel.h"
#import "NSDate+Calendar.h"
#import "CLYearViewController.h"
#import "CLMonthViewController.h"
typedef enum
{
    PRE, CUR, NEX
}TYPE;

@interface XiShiTangCalendarView()<UIScrollViewDelegate>
//中间日期数组
@property (nonatomic, strong)NSArray *centerDateArray;
//左边日期数组
@property (nonatomic, strong)NSArray *leftDateArray;
//右边日期数组
@property (nonatomic, strong)NSArray *rightDateArray;

@property(nonatomic,strong)UIScrollView *scrollView;
//中间视图
@property (nonatomic, strong)UIView *centerView;
//左边视图
@property (nonatomic, strong)UIView *leftView;
//右边视图
@property (nonatomic, strong)UIView *rightView;
//当前日期
@property (nonatomic, strong)NSDate *currentDate;

@property (nonatomic, strong)UIButton *yearBtn;

@property (nonatomic, strong)UIButton *monthBtn;
//占用的日期数组
@property (nonatomic, strong)NSArray *currentArray;

@property (nonatomic, assign)NSInteger index;


@end

@implementation XiShiTangCalendarView

-(id)initWithFrame:(CGRect)frame CurrentArray:(NSArray *)currentArray{
    if (self = [super initWithFrame:frame]) {
        self.tag = 1000;
        self.currentDate = [NSDate date];
        self.index = [NSDate month:[NSDate date]];
        self.currentArray = currentArray;
        [self creatYearAndMonthBtn];
        [self creatWeakLabel];
        [self setupScrollview];
        [self setupCalendarViews];
        [self setupDefaultCalendar];
    }
    return self;
}
-(void)creatYearAndMonthBtn
{
    self.yearBtn = [[UIButton alloc]initWithFrame:CGRectMake((KWIDTH - 260)/2, 0, 120, 40)];
    self.monthBtn = [[UIButton alloc]initWithFrame:CGRectMake(120 + (KWIDTH - 220)/2, 0, 120, 40)];
    [_yearBtn setTitle:[NSString stringWithFormat:@"%ld年", (long)[NSDate year:self.currentDate]] forState:UIControlStateNormal];
    [_monthBtn setTitle:[NSString stringWithFormat:@"%ld月", (long)[NSDate month:self.currentDate]] forState:UIControlStateNormal];
    [_yearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_monthBtn addTarget:self action:@selector(monthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_yearBtn addTarget:self action:@selector(yearBtn
                                              :) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yearBtn];
    [self addSubview:_monthBtn];
}

-(void)creatWeakLabel
{
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < weekArray.count; i++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * self.bounds.size.width / 7.0, 40,  self.bounds.size.width / 7.0, 30)];
        weekLabel.text = weekArray[i];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:weekLabel];
    }
}
-(void)setupScrollview
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_scrollView];
    //设置代理
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    //设置当前显示的位置在中间位置
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //去掉水平滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //边缘不弹跳
    self.scrollView.bounces = NO;
}

-(void)setupCalendarViews {
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:self.leftView];
    
    self.centerView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:_centerView];
    
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(2*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:_rightView];
}

-(void)setupDefaultCalendar
{
    [self getDateArray:self.currentDate completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
        [self creatCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:self.currentDate View:self.centerView Type:CUR];
    }];
    [self getDateArray:[NSDate lastMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
        [self creatCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate lastMonth:self.currentDate] View:self.leftView Type:PRE];
    }];
    [self getDateArray:[NSDate nextMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
        [self creatCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate nextMonth:self.currentDate] View:self.rightView Type:NEX];
    }];
}

-(void)getDateArray:(NSDate *)date completionHandler:(void (^)(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray))completionHandler
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *preArray = [NSMutableArray array];
    NSMutableArray *currentArray = [NSMutableArray array];
    NSMutableArray *nextArray = [NSMutableArray array];
    for (int i = 0; i < 42; i++) {
        NSInteger daysInLastMonth = [NSDate totaldaysInMonth:[NSDate lastMonth:date]];
        NSInteger daysInThisMonth = [NSDate totaldaysInMonth:date];
        NSInteger firstWeekday = [NSDate firstWeekdayInThisMonth:date];
        NSInteger day = 0;
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [preArray addObject:[NSString stringWithFormat:@"%ld", (long)day]];
            [array addObject:[NSString stringWithFormat:@"%ld", (long)day]];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [nextArray addObject:[NSString stringWithFormat:@"%ld", (long)day]];
            [array addObject:[NSString stringWithFormat:@"%ld", (long)day]];
            
        }else{
            day = i - firstWeekday + 1;
            [currentArray addObject:[NSString stringWithFormat:@"%ld", (long)day]];
            [array addObject:[NSString stringWithFormat:@"%ld", (long)day]];
        }
    }
    completionHandler(preArray, currentArray, nextArray, array);
}
//创建日历视图
-(void)creatCalendarView:(NSArray *)allDateArray PreDateArray:(NSArray *)preDateArray CurrentDateArray:(NSArray *)currentDateArray Date:(NSDate *)date View:(UIView *)view Type:(TYPE)type
{
    for (int i = 0; i < allDateArray.count; i++) {
        UIButton *button = nil;
        if (i < preDateArray.count) {
            button = [self creatCalendarButton:allDateArray[i] Index:i Type:PRE Date:date];
        }
        else if(i >= preDateArray.count && i < preDateArray.count + currentDateArray.count)
        {
            button = [self creatCalendarButton:allDateArray[i] Index:i Type:CUR Date:date];
        }
        else
        {
            button = [self creatCalendarButton:allDateArray[i] Index:i Type:NEX Date:date];
        }
        [button addTarget:self action:@selector(clickCalendarBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        switch (type) {
            case PRE:
                button.tag = 100 + i;
                break;
            case CUR:
                button.tag = 200 + i;
                break;
            default:
                button.tag = 300 + i;
                break;
        }
    }
}

//创建日历按钮
-(UIButton *)creatCalendarButton:(NSString *)dateString Index:(NSInteger)index Type:(TYPE)type Date:(NSDate *)date
{
    double width = self.bounds.size.width*1.0 / 7;
    UILabel *solarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 25)];
    solarLabel.text = dateString;
    solarLabel.textAlignment = NSTextAlignmentCenter;
    solarLabel.font = [UIFont systemFontOfSize:18];
    UILabel *lunarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, width, 25)];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(index%7*width, index/7*50, width, 50)];
    NSString *nowStr = [self getDateString:dateString Type:type Date:date];
    NSDate *chineseCalendarDate = [DateModel dateFromString:nowStr];
    if (chineseCalendarDate) {
        lunarLabel.text = [DateModel getChineseCalendarWithDate:chineseCalendarDate];
    }
    lunarLabel.textAlignment = NSTextAlignmentCenter;
    lunarLabel.font = [UIFont systemFontOfSize:14];
    solarLabel.textColor = kUIColorFromRGB(0x8e8e8e);
    lunarLabel.textColor = [UIColor brownColor];
    button.enabled = YES;
    if (type == PRE || type == NEX) {
        button.enabled = NO;
        lunarLabel.textColor = kUIColorFromRGB(0xc6c9d6);
        solarLabel.textColor = kUIColorFromRGB(0xc6c9d6);
    }
    solarLabel.tag = 50;
    lunarLabel.tag = 51;
    
    [button addSubview:solarLabel];
    [button addSubview:lunarLabel];
    [button setBackgroundImage:[UIImage imageNamed:@"日历"] forState:UIControlStateNormal];
    //判断是否是今天
    if ([NSDate year:[NSDate date]] == [NSDate year:date]&& [NSDate month:[NSDate date]] == [NSDate month:date] && [NSDate day:[NSDate date]] == [dateString integerValue]&& button.enabled == YES)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"日历-今天"] forState:UIControlStateNormal];
        ((UILabel *)[button  viewWithTag:50]).textColor = [UIColor whiteColor];
        ((UILabel *)[button  viewWithTag:51]).textColor = [UIColor whiteColor];
    }
    [self judgeDateButtonIsUse:button Date:date DateStr:dateString];
    return button;
}
//判断农历
-(NSString *)getDateString:(NSString *)dateString Type:(TYPE)type Date:(NSDate *)date
{
    NSInteger tempMonthStr = [NSDate month:date];
    NSString *startMonthStr = @"";
    NSString *startYearStr = @"";
    switch (type) {
        case PRE:
            startMonthStr = (tempMonthStr - 1) > 0 ? [NSString stringWithFormat:@"%02ld", (tempMonthStr - 1)] : @"12";
            startYearStr = [startMonthStr isEqualToString:@"12"] ? [NSString stringWithFormat:@"%ld", ([NSDate year:date] - 1)] : [NSString stringWithFormat:@"%ld", (long)[NSDate year:date]];
            break;
        case NEX:
            startMonthStr = (tempMonthStr + 1) > 12 ?  @"1": [NSString stringWithFormat:@"%02ld", (tempMonthStr + 1)];
            startYearStr = [startMonthStr isEqualToString:@"1"] ? [NSString stringWithFormat:@"%ld", ([NSDate year:date] + 1)] : [NSString stringWithFormat:@"%ld", (long)[NSDate year:date]];
            break;
        default:
            startMonthStr = [NSString stringWithFormat:@"%02ld", (long)tempMonthStr];
            startYearStr = [NSString stringWithFormat:@"%ld", (long)[NSDate year:date]];
            break;
    }
    return [NSString stringWithFormat:@"%@-%@-%02ld", startYearStr, startMonthStr, (long)[dateString integerValue]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadDate];
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

-(void)reloadDate {
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x > self.bounds.size.width) {//向右滑动
        self.currentDate = [NSDate nextMonth:self.currentDate];
        self.index = [NSDate month:self.currentDate];
        [self.yearBtn setTitle:[NSString stringWithFormat:@"%ld年", (long)[NSDate year:self.currentDate]] forState:UIControlStateNormal];
        [self.monthBtn setTitle:[NSString stringWithFormat:@"%ld月", (long)[NSDate month:self.currentDate]] forState:UIControlStateNormal];
        [self getDateArray:self.currentDate completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:self.currentDate View:self.centerView Tag:200];
        }];
        [self getDateArray:[NSDate lastMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate lastMonth:self.currentDate] View:self.leftView Tag:100];
        }];
        [self getDateArray:[NSDate nextMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate nextMonth:self.currentDate] View:self.rightView Tag:300];
        }];
    }else if(offset.x < self.bounds.size.width) { //向左滑动
        self.currentDate = [NSDate lastMonth:self.currentDate];
        self.index = [NSDate month:self.currentDate];
        [self.yearBtn setTitle:[NSString stringWithFormat:@"%ld年", (long)[NSDate year:self.currentDate]] forState:UIControlStateNormal];
        [self.monthBtn setTitle:[NSString stringWithFormat:@"%ld月", (long)[NSDate month:self.currentDate]] forState:UIControlStateNormal];
        [self getDateArray:self.currentDate completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:self.currentDate View:self.centerView Tag:200];
        }];
        [self getDateArray:[NSDate lastMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate lastMonth:self.currentDate] View:self.leftView Tag:100];
        }];
        [self getDateArray:[NSDate nextMonth:self.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [self setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate nextMonth:self.currentDate] View:self.rightView Tag:300];
        }];
    }
}

//修改日历视图
-(void)setCalendarView:(NSArray *)allDateArray PreDateArray:(NSArray *)preDateArray CurrentDateArray:(NSArray *)currentDateArray Date:(NSDate *)date View:(UIView *)view Tag:(NSInteger)tag
{
    for (int i = 0; i < allDateArray.count; i++)
    {
        if (i < preDateArray.count) {
            [self setCalendarButton:allDateArray[i] Index:i Type:PRE Date:date button:[view viewWithTag:tag + i]];
        }
        else if(i >= preDateArray.count && i < preDateArray.count + currentDateArray.count)
        {
            [self setCalendarButton:allDateArray[i] Index:i Type:CUR Date:date button:[view viewWithTag:tag + i]];
        }
        else
        {
            [self setCalendarButton:allDateArray[i] Index:i Type:NEX Date:date button:[view viewWithTag:tag + i]];
        }
    }
}
//修改日历按钮
-(void)setCalendarButton:(NSString *)dateString Index:(NSInteger)index Type:(TYPE)type Date:(NSDate *)date button:(UIButton *)button
{
    button.enabled = YES;
    [button setBackgroundImage:[UIImage imageNamed:@"日历"] forState:UIControlStateNormal];
    
    ((UILabel *)[button viewWithTag:50]).textColor = kUIColorFromRGB(0x8e8e8e);
    ((UILabel *)[button viewWithTag:51]).textColor = [UIColor brownColor];
    if (type == PRE || type == NEX) {
        button.enabled = NO;
        ((UILabel *)[button viewWithTag:50]).textColor = kUIColorFromRGB(0xc6c9d6);
        ((UILabel *)[button viewWithTag:51]).textColor = kUIColorFromRGB(0xc6c9d6);
    }
    //判断是否是今天
    if ([NSDate year:[NSDate date]] == [NSDate year:date]&& [NSDate month:[NSDate date]] == [NSDate month:date] && [NSDate day:[NSDate date]] == [dateString integerValue]&& button.enabled == YES)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"日历-今天"] forState:UIControlStateNormal];
        ((UILabel *)[button  viewWithTag:50]).textColor = [UIColor whiteColor];
        ((UILabel *)[button  viewWithTag:51]).textColor = [UIColor whiteColor];
    }
    [self judgeDateButtonIsUse:button Date:date DateStr:dateString];
    ((UILabel *)[button viewWithTag:50]).text = dateString;
    NSString *nowStr = [self getDateString:dateString Type:type Date:date];
    NSDate *chineseCalendarDate = [DateModel dateFromString:nowStr];
    
    ((UILabel *)[button viewWithTag:51]).text = [DateModel getChineseCalendarWithDate:chineseCalendarDate];
}

//点击日历按钮
-(void)clickCalendarBtn:(UIButton *)sender
{
    if (self.isFromOther == NO) {
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *chooseDate = [formatter dateFromString:[[self getChooseDate:sender] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    NSDate *newDate = [formatter dateFromString:[NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]*10000+[NSDate month:[NSDate date]]*100+[NSDate day:[NSDate date]]]];
    if (self.isFromJoin == NO) {
        if ([chooseDate timeIntervalSinceDate:newDate]<4*24*3600)
        {
            [self showWarning:@"请提前三天预定"];
            return;
        }
    }
    else
    {
        if ([[[self getChooseDate:sender] stringByReplacingOccurrencesOfString:@"/" withString:@""] integerValue] - ([NSDate year:[NSDate date]]*10000+[NSDate month:[NSDate date]]*100+[NSDate day:[NSDate date]]) > 0)
        {
            return;
        }
    }
    
    if ([_delgate respondsToSelector:@selector(postWithDateStr:)]) {
        NSString *dateStr = [self getChooseDate:sender];
        [_delgate postWithDateStr:dateStr];
    }
}

-(NSString *)getChooseDate:(UIButton *)sender
{
    NSString *day = [NSString stringWithFormat:@"%02ld",[((UILabel *)[sender viewWithTag:50]).text integerValue]];
    NSLog(@"%@", day);
    NSString *month = [NSString stringWithFormat:@"%02ld",[[self.monthBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""] integerValue]];
    NSLog(@"%@", month);
    NSString *year = [self.yearBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"年" withString:@""];
    NSLog(@"%@", year);
    return [[year stringByAppendingPathComponent:month]stringByAppendingPathComponent:day];
}

//判断日期是否占用
-(void)judgeDateButtonIsUse:(UIButton *)button Date:(NSDate *)date DateStr:(NSString *)dateStr
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSDictionary *dict in self.currentArray) {
            NSString * tempStr = [NSString stringWithFormat:@"%ld%02ld%02ld", (long)[NSDate year:date], (long)[NSDate month:date], (long)[dateStr integerValue]];
            if ([dict[@"list"] isEqualToString:tempStr]&& button.enabled == YES) {
                if ([dict[@"HallStatus"] integerValue] == 2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [button setBackgroundImage:[UIImage imageNamed:@"日历-已申请"] forState:UIControlStateNormal];
                        ((UILabel *)[button  viewWithTag:50]).textColor = [UIColor whiteColor];
                        ((UILabel *)[button  viewWithTag:51]).textColor = [UIColor whiteColor];
                    });
                }
                else if([dict[@"HallStatus"] integerValue] == 3)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [button setBackgroundImage:[UIImage imageNamed:@"日历-订单"] forState:UIControlStateNormal];
                        ((UILabel *)[button  viewWithTag:50]).textColor = [UIColor whiteColor];
                        ((UILabel *)[button  viewWithTag:51]).textColor = [UIColor whiteColor];
                    });
                }
            }
        }
    });
}

- (void)monthBtn:(UIButton *)sender {
    CLMonthViewController *vc = [[CLMonthViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(120, 230)Array:nil];
    vc.indexP = self.index;
    vc.monthStr = [self.monthBtn.titleLabel.text substringToIndex:2];
    WK(weakSelf)
    vc.chooseBlock = ^(NSInteger monthValue){
        weakSelf.index = monthValue;
        [weakSelf.monthBtn setTitle:[NSString stringWithFormat:@"%ld月", (long)monthValue] forState:UIControlStateNormal];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setYear:[[weakSelf.yearBtn.titleLabel.text substringToIndex:4] integerValue]];
        [dateComps setMonth:monthValue];
        [dateComps setDay:1];
        NSDate *itemDate = [[NSCalendar currentCalendar] dateFromComponents:dateComps];
        weakSelf.currentDate = itemDate;
        [weakSelf getDateArray:weakSelf.currentDate completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:weakSelf.currentDate View:weakSelf.centerView Tag:200];
        }];
        [weakSelf getDateArray:[NSDate lastMonth:weakSelf.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate lastMonth:weakSelf.currentDate] View:weakSelf.leftView Tag:100];
        }];
        [weakSelf getDateArray:[NSDate nextMonth:weakSelf.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate nextMonth:weakSelf.currentDate] View:weakSelf.rightView Tag:300];
        }];
    };
    [[self getCurrentVC] presentViewController:vc animated:YES completion:nil];
}

- (void )yearBtn:(UIButton *)sender {
    CLYearViewController *vc = [[CLYearViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(120, 230)Array:nil];
    vc.isFromJoin = self.isFromJoin;
    vc.yearStr = [self.yearBtn.titleLabel.text substringToIndex:4];
    WK(weakSelf)
    vc.chooseBlock = ^(NSInteger yearValue){
        [weakSelf.yearBtn setTitle:[NSString stringWithFormat:@"%ld年", (long)yearValue] forState:UIControlStateNormal];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setYear:yearValue];
        [dateComps setMonth:[[weakSelf.monthBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""] integerValue]];
        [dateComps setDay:1];
        NSDate *itemDate = [[NSCalendar currentCalendar] dateFromComponents:dateComps];
        weakSelf.currentDate = itemDate;
        [weakSelf getDateArray:weakSelf.currentDate completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:weakSelf.currentDate View:weakSelf.centerView Tag:200];
        }];
        [weakSelf getDateArray:[NSDate lastMonth:weakSelf.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate lastMonth:weakSelf.currentDate] View:weakSelf.leftView Tag:100];
        }];
        [weakSelf getDateArray:[NSDate nextMonth:weakSelf.currentDate] completionHandler:^(NSArray *preDateArray, NSArray *currentDateArray, NSArray *nextDateArray, NSArray *allDateArray) {
            [weakSelf setCalendarView:allDateArray PreDateArray:preDateArray CurrentDateArray:currentDateArray Date:[NSDate nextMonth:weakSelf.currentDate] View:weakSelf.rightView Tag:300];
        }];
    };
    [[self getCurrentVC] presentViewController:vc animated:YES completion:nil];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end


