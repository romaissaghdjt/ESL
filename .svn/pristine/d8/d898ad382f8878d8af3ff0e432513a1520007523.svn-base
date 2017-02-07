//
//  CLLotteryView.h
//  YY
//
//  Created by 陈龙 on 16/6/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLabelView.h"

typedef void(^CompletionHandler)(NSString *string);

@interface CLLotteryView : UIView
@property (nonatomic, strong)CLLabelView *topView;
@property (nonatomic, strong)CLLabelView *bottomView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, copy)CompletionHandler completionHandler;
@property (nonatomic, strong)CLLabelView *currentView;
-(id)initWithFrame:(CGRect)frame ;
-(void)setupCurrentNum:(NSString *)num;
@end
