//
//  WishView.m
//  YY
//
//  Created by 陈龙 on 16/7/26.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "WishView.h"

@interface WishView()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *wishArray;
@property (nonatomic, copy)NSString *wishString;
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, assign)NSInteger count;
@end

@implementation WishView

-(id)initWithFrame:(CGRect)frame WishArray:(NSArray *)wishArray WishString:(NSString *)wishString {
    if (self = [super initWithFrame:frame]) {
        self.wishArray = wishArray;
        self.wishString = wishString;
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
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 2);
    self.scrollView.userInteractionEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

-(void)setupViews {
    UILabel *topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(40, self.bounds.size.height / 7.0, self.bounds.size.width - 40, self.bounds.size.height / 7.0 * 2)];
    topLabel1.font = [UIFont systemFontOfSize:12];
    topLabel1.tag = 50;
    UIImageView *topImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height / 7.0, 30, self.bounds.size.height / 7.0 * 2)];
    topImageView1.image = [UIImage imageNamed:@"xibao.png"];
    UILabel *topLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(40, self.bounds.size.height * 4 / 7.0, self.bounds.size.width - 40, self.bounds.size.height / 7.0 * 2)];
    topLabel2.font = [UIFont systemFontOfSize:12];
    topLabel2.tag = 51;
    UIImageView *topImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height * 4 / 7.0, 30, self.bounds.size.height / 7.0 * 2)];
    topImageView2.image = [UIImage imageNamed:@"dingdan.png"];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.topView addSubview:topImageView1];
    [self.topView addSubview:topLabel1];
    [self.topView addSubview:topImageView2];
    [self.topView addSubview:topLabel2];
    [self.scrollView addSubview:self.topView];
    
    UILabel *bottomLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(40, self.bounds.size.height / 7.0, self.bounds.size.width - 40, self.bounds.size.height / 7.0 * 2)];
    bottomLabel1.font = [UIFont systemFontOfSize:12];
    bottomLabel1.tag = 50;
    UIImageView *bottomImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height / 7.0, 30, self.bounds.size.height / 7.0 * 2)];
    bottomImageView1.image = [UIImage imageNamed:@"xibao"];
    UILabel *bottomLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(40, self.bounds.size.height * 4 / 7.0, self.bounds.size.width - 40, self.bounds.size.height / 7.0 * 2)];
    bottomLabel2.font = [UIFont systemFontOfSize:12];
    bottomLabel2.tag = 51;
    UIImageView *bottomImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height * 4 / 7.0, 30, self.bounds.size.height / 7.0 * 2)];
    bottomImageView2.image = [UIImage imageNamed:@"dingdan"];
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    [self.bottomView addSubview:bottomImageView1];
    [self.bottomView addSubview:bottomLabel1];
    [self.bottomView addSubview:bottomImageView2];
    [self.bottomView addSubview:bottomLabel2];
    [self.scrollView addSubview:self.bottomView];
}

-(void)setupDefaultLabel
{
    if (self.wishArray.count == 0) {
        return;
    }

    ((UILabel *)[self.topView viewWithTag:50]).text = self.wishArray[self.count];
    ((UILabel *)[self.topView viewWithTag:51]).text = self.wishString;
    self.count++;
    if (self.wishArray.count == 1) {
        self.count = 0;
    }
    ((UILabel *)[self.bottomView viewWithTag:50]).text = self.wishArray[self.count];
    ((UILabel *)[self.bottomView viewWithTag:51]).text = self.wishString;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (self.wishArray.count == 0) {
        return;
    }

    CGPoint offset = self.scrollView.contentOffset;
    
    
    if (offset.y >= self.bounds.size.height) {
//        self.count++;
//        NSLog(@"%ld", self.count);
//        if (self.count > self.wishArray.count - 1) {
//            self.count = 0;
//        }
        ((UILabel *)[self.topView viewWithTag:50]).text = self.wishArray[self.count];
        ((UILabel *)[self.topView viewWithTag:51]).text = self.wishString;
        
        self.count++;
        if (self.count > self.wishArray.count - 1) {
            self.count = 0;
        }
        ((UILabel *)[self.bottomView viewWithTag:50]).text = self.wishArray[self.count];
        ((UILabel *)[self.bottomView viewWithTag:51]).text = self.wishString;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

@end
