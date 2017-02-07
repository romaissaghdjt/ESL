//
//  CLLabelView.m
//  YY
//
//  Created by 陈龙 on 16/6/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLLabelView.h"

@interface CLLabelView()
@property (nonatomic, strong)NSArray *array;
@end

@implementation CLLabelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 30)];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(28, 0, 25, 30)];
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(56, 0, 25, 30)];
        self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(28*3, 0, 25, 30)];
        self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(28*4, 0, 25, 30)];
        self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(28*5, 0, 25, 30)];
        self.label7 = [[UILabel alloc]initWithFrame:CGRectMake(28*6, 0, 25, 30)];
        self.label8 = [[UILabel alloc]initWithFrame:CGRectMake(28*7, 0, 25, 30)];
        self.label9 = [[UILabel alloc]initWithFrame:CGRectMake(28*8, 0, 25, 30)];
        self.label10 = [[UILabel alloc]initWithFrame:CGRectMake(28*9, 0, 25, 30)];
        self.label11 = [[UILabel alloc]initWithFrame:CGRectMake(28*10, 0, 25, 30)];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label2.textAlignment = NSTextAlignmentCenter;
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label4.textAlignment = NSTextAlignmentCenter;
        self.label5.textAlignment = NSTextAlignmentCenter;
        self.label6.textAlignment = NSTextAlignmentCenter;
        self.label7.textAlignment = NSTextAlignmentCenter;
        self.label8.textAlignment = NSTextAlignmentCenter;
        self.label9.textAlignment = NSTextAlignmentCenter;
        self.label10.textAlignment = NSTextAlignmentCenter;
        self.label11.textAlignment = NSTextAlignmentCenter;
        
        self.label1.backgroundColor = [UIColor whiteColor];
        self.label2.backgroundColor = [UIColor whiteColor];
        self.label3.backgroundColor = [UIColor whiteColor];
        self.label4.backgroundColor = [UIColor whiteColor];
        self.label5.backgroundColor = [UIColor whiteColor];
        self.label6.backgroundColor = [UIColor whiteColor];
        self.label7.backgroundColor = [UIColor whiteColor];
        self.label8.backgroundColor = [UIColor whiteColor];
        self.label9.backgroundColor = [UIColor whiteColor];
        self.label10.backgroundColor = [UIColor whiteColor];
        self.label11.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.label3];
        [self addSubview:self.label4];
        [self addSubview:self.label5];
        [self addSubview:self.label6];
        [self addSubview:self.label7];
        [self addSubview:self.label8];
        [self addSubview:self.label9];
        [self addSubview:self.label10];
        [self addSubview:self.label11];
        self.array = @[@"134",@"135",@"136",@"137",@"138",@"139",@"150",@"151",@"157",@"158",@"159",@"182",@"187",@"188",@"130",@"131",@"132",@"152",@"155",@"156",@"185",@"186",@"133",@"153",@"180",@"189"];
        
    }
    return self;
}

-(void)setAllLabel:(NSString *)number
{
    if (number) {
        self.label1.text = [number substringToIndex:1];
        self.label2.text = [number substringWithRange:NSMakeRange(1, 1)];
        self.label3.text = [number substringWithRange:NSMakeRange(2, 1)];
        self.label4.text = [NSString stringWithFormat:@"*"];
        self.label5.text = [NSString stringWithFormat:@"*"];
        self.label6.text = [NSString stringWithFormat:@"*"];
        self.label7.text = [NSString stringWithFormat:@"*"];
        self.label8.text = [number substringWithRange:NSMakeRange(7, 1)];
        self.label9.text = [number substringWithRange:NSMakeRange(8, 1)];
        self.label10.text = [number substringWithRange:NSMakeRange(9, 1)];
        self.label11.text = [number substringWithRange:NSMakeRange(10, 1)];
    }
    else
    {
    self.label1.text = [self.array[arc4random() % self.array.count] substringWithRange:NSMakeRange(0, 1)];
    
    self.label2.text = [self.array[arc4random() % self.array.count]  substringWithRange:NSMakeRange(1, 1)];
    self.label3.text = [self.array[arc4random() % self.array.count]  substringWithRange:NSMakeRange(2, 1)];
    self.label4.text = [NSString stringWithFormat:@"*"];
    self.label5.text = [NSString stringWithFormat:@"*"];
    self.label6.text = [NSString stringWithFormat:@"*"];
    self.label7.text = [NSString stringWithFormat:@"*"];
    self.label8.text = [NSString stringWithFormat:@"%u", arc4random() % 10];
    self.label9.text = [NSString stringWithFormat:@"%u", arc4random() % 10];
    self.label10.text = [NSString stringWithFormat:@"%u", arc4random() % 10];
    self.label11.text = [NSString stringWithFormat:@"%u", arc4random() % 10];
    }
}

@end
