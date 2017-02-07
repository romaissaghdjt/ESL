//
//  XiShiTangCalendarView.h
//  YY
//
//  Created by 陈龙 on 16/7/21.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XiShiTangCalendarDelegate <NSObject>

-(void)postWithDateStr:(NSString *)dateStr;

@end

@interface XiShiTangCalendarView : UIView
@property (nonatomic, assign)BOOL isFromJoin;
@property (nonatomic, assign)BOOL isFromOther;
-(id)initWithFrame:(CGRect)frame CurrentArray:(NSArray *)currentArray;
@property (nonatomic, assign)id<XiShiTangCalendarDelegate>delgate;
@end
