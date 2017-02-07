//
//  OrderCalendarView.h
//  ESL
//
//  Created by eyou on 16/11/7.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCalendarViewDelegate <NSObject>

-(void)postWithDateStr:(NSString *)dateStr;

@end

@interface OrderCalendarView : UIView

-(id)initWithFrame:(CGRect)frame CurrentArray:(NSArray *)currentArray;
@property (nonatomic, assign)id<OrderCalendarViewDelegate>delgate;
@end
