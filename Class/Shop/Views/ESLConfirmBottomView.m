//
//  ESLConfirmBottomView.m
//  ESL
//
//  Created by 徐恒 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLConfirmBottomView.h"
#define Y combinedLab.frame.origin.y
#define W CGRectGetMaxX(combinedLab.frame)
#define H combinedLab.frame.size.height
@implementation ESLConfirmBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createFooterView];
    }
    return self;
}
- (void)createFooterView{
    
//    UILabel *combinedLab = [[UILabel alloc]init];
//    combinedLab.frame = CGRectMake(40, 5, 40, 30);
//    combinedLab.text = @"合计:";
//    combinedLab.textAlignment = NSTextAlignmentCenter;
//    combinedLab.font = [UIFont systemFontOfSize:15];
//    [self addSubview:combinedLab];
//    
//    UILabel *RNM = [[UILabel alloc]initWithFrame:CGRectMake (W+10, Y+5, 20, H-10)];
//    RNM.text = @"¥";
//    RNM.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:RNM];
//    
//    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(W+RNM.size.width+5, Y+5, 100, RNM.size.height)];
//    priceLab.text = @"88888";
//    [self addSubview:priceLab];
//    self.totalPrice = priceLab;
//    
//    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH-CGRectGetMaxX(priceLab.frame)+105, 0, 100, H+10)];
//    submitBtn.backgroundColor = ZXColor(244, 142, 38, 1);
//    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [submitBtn setTitle:@"提交订单" forState: UIControlStateNormal];
//    [self addSubview:submitBtn];
//    self.submit = submitBtn;
    
    self.combinedLab = [[UILabel alloc]init];
    [self addSubview:self.combinedLab];
    self.combinedLab.frame = CGRectMake(10, 5, 40, 30);
    self.combinedLab.text = @"合计:";
    //    self.combinedLab.backgroundColor = [UIColor purpleColor];
    self.combinedLab.textAlignment = NSTextAlignmentCenter;
    self.combinedLab.font = [UIFont systemFontOfSize:15];
    
    self.totalPrice = [[UILabel alloc]init];
    self.totalPrice.text = @".....";
    self.totalPrice.textAlignment = NSTextAlignmentRight;
    self.totalPrice.textColor = ZXColor(245, 170, 0, 1);
    //    self.totalPrice.backgroundColor = [UIColor redColor];
    [self addSubview:self.totalPrice];
    [self.totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.combinedLab.origin.y);
        make.left.equalTo(self.combinedLab.mas_right).with.offset(5);
        make.height.mas_equalTo(30);
    }];
    
    self.freightLab = [[UILabel alloc]init];
    self.freightLab.text = @".....";
    self.freightLab.textColor = [UIColor grayColor];
//        self.freightLab.backgroundColor = [UIColor greenColor];
    self.freightLab.textAlignment = NSTextAlignmentCenter;
    self.freightLab.font = [UIFont systemFontOfSize:14];
    self.freightLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.freightLab];
    [self.freightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.combinedLab.origin.y);
        make.right.equalTo(self.submitBtn.mas_left).with.offset(-85);
        make.height.mas_equalTo(30);
    }];
    
    
        UIButton *submitBtn = [[UIButton alloc]init];
    if (SW==320) {
        submitBtn.frame = CGRectMake(240, 0, 80, 40);
    }else if (SW==375){
        submitBtn.frame = CGRectMake(295, 0, 80, 40);
    }else if (SW>375){
        submitBtn.frame = CGRectMake(334, 0, 80, 40);
    }
        submitBtn.backgroundColor = ZXColor(244, 142, 38, 1);
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [submitBtn setTitle:@"提交订单" forState: UIControlStateNormal];
        [self addSubview:submitBtn];
        self.submit = submitBtn;
    
}
@end
