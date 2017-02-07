//
//  CLLotteryView.m
//  YY
//
//  Created by 陈龙 on 16/6/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLLotteryView.h"

@interface CLLotteryView () <UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger count;
@property (nonatomic, copy)NSString *num;
@end

@implementation CLLotteryView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.count = 0;
        [self setupScrollview];
        [self setupViews];
        [self setupDefaultLabel];
    }
    return self;
}

-(void)setupScrollview {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 3);
    self.scrollView.userInteractionEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

-(void)setupViews {
    self.topView = [[CLLabelView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:self.topView];
    
    self.bottomView = [[CLLabelView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:self.bottomView];
    
    self.currentView = [[CLLabelView alloc]initWithFrame:CGRectMake(0, -self.bounds.size.height , self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:self.currentView];
    
}

-(void)setupDefaultLabel
{
//    if (self.count > self.allTitles.count - 1) {
//        self.count = 0;
//        return;
//    }
    [self.topView setAllLabel:@"00000000000"];
    
//    if (self.count > self.allTitles.count - 1) {
//        self.count = 0;
//    }
    [self.bottomView setAllLabel:nil];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.y >= self.bounds.size.height) {
        
        [self.topView setAllLabel:nil];
//        if (self.count > self.allTitles.count - 1) {
//            self.count = 0;
//        }
        [self.bottomView setAllLabel:nil];
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)setupCurrentNum:(NSString *)num
{
    [self.currentView setAllLabel:num];
}

@end
