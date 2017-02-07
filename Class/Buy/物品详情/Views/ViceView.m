//
//  ViceView.m
//  ESL
//
//  Created by eyou on 16/10/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ViceView.h"
#import "GarnishesModel.h"
#import "ESLGarnishLabel.h"

@interface ViceView()
@property (nonatomic, strong)UIButton *noWantFood;
@property (nonatomic, strong)NSArray *foodArray;

@property (nonatomic, assign)BOOL isNOSelect;
@end

@implementation ViceView
-(NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.foodArray = array;
        self.isNOSelect = YES;
        //配菜(可多选)
        UILabel *sideDishes = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, KWIDTH - 20, 20)];
        sideDishes.text = @"配菜(可多选)";
        [self addSubview:sideDishes];
        //不需要配菜
        _noWantFood = [[UIButton alloc]initWithFrame:CGRectMake(20, 35, 180, 25)];
        [_noWantFood setTitle:@"不需要配菜" forState:UIControlStateNormal];
        _noWantFood.layer.cornerRadius = 8;
        _noWantFood.layer.masksToBounds = YES;
        [_noWantFood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _noWantFood.selected = YES;
        [_noWantFood setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_noWantFood setBackgroundColor:ZXColor(48, 166, 27, 1)];
        [_noWantFood addTarget:self action:@selector(noWant:) forControlEvents:UIControlEventTouchUpInside];
        _noWantFood.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_noWantFood];
        for (int i = 0; i < array.count; i++) {
            //配菜
            ESLGarnishLabel *label = [[ESLGarnishLabel alloc]initWithFrame:CGRectMake(20, 70+i*(35), 180, 25)];
            label.layer.cornerRadius = 8;
            label.layer.masksToBounds = YES;
            label.backgroundColor = ZXColor(238, 238, 238, 1);
            label.text = [NSString stringWithFormat:@"%@ 1份 %.02lf元", ((GarnishesModel *)self.foodArray[i]).name, [((GarnishesModel *)self.foodArray[i]).price doubleValue]];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = i+1000;
            [self addSubview:label];
            
            UIButton *subButton = [[UIButton alloc]initWithFrame:CGRectMake(210, 70+i*(35), 20, 20)];
            subButton.tag = i;
            subButton.centerY = label.centerY;
            [subButton setTitle:@"-" forState:UIControlStateNormal];
            [subButton addTarget:self action:@selector(subClick:) forControlEvents:UIControlEventTouchUpInside];
            subButton.titleLabel.font = [UIFont systemFontOfSize:18];
            [subButton setTitleColor:ZXColor(136, 136, 136, 1) forState:UIControlStateNormal];
            subButton.tag = i;
            [subButton setBackgroundColor:ZXColor(238, 238, 238, 1)];
            [self addSubview:subButton];
            
            UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 70+i*(35), 20, 20)];
            numLabel.text = @"0";
            [self.labelArray addObject:numLabel];
            numLabel.centerY = label.centerY;
            numLabel.font = [UIFont systemFontOfSize:15];
            numLabel.textColor = ZXColor(136, 136, 136, 1);
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.tag = i+100;
            [self addSubview:numLabel];
            
            UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 70+i*(35), 20, 20)];
            addButton.centerY = label.centerY;
            addButton.tag = i;
            [addButton setTitle:@"+" forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
            addButton.titleLabel.font = [UIFont systemFontOfSize:18];
            [addButton setTitleColor:ZXColor(136, 136, 136, 1) forState:UIControlStateNormal];
            addButton.tag = i;
            [addButton setBackgroundColor:ZXColor(238, 238, 238, 1)];
            [self addSubview:addButton];
        }
        
    }
    return self;
}

-(void)subClick:(UIButton *)sender
{
    UILabel *numLabel = [self viewWithTag:sender.tag+100];
    UILabel *label = [self viewWithTag:sender.tag+1000];
    if ([numLabel.text isEqual:@"0"]) {
        return;
    }
    if ([numLabel.text isEqual:@"1"]) {
        label.backgroundColor = ZXColor(238, 238, 238, 1);
        label.textColor = [UIColor blackColor];
    }
    
    numLabel.text = [NSString stringWithFormat:@"%ld", [numLabel.text integerValue]-1];
    
    
    [self.delegate buttonClickWithButton:sender Type:@"sub"];
    if ([numLabel.text isEqual:@"0"]) {
        for (int i = 0; i<self.labelArray.count; i++) {
            if ([((UILabel *)self.labelArray[i]).text isEqualToString:@"0"]) {
                self.isNOSelect = YES;
            }
            else
            {
                self.isNOSelect = NO;
                break;
            }
        }
        if (self.isNOSelect == YES) {
            [self noWant:_noWantFood];
        }
    }
}

-(void)addClick:(UIButton *)sender
{
    UILabel *numLabel = [self viewWithTag:sender.tag+100];
    UILabel *label = [self viewWithTag:sender.tag+1000];
    if ([numLabel.text isEqual:@"99"]) {
        return;
    }
    self.isNOSelect = NO;
    numLabel.text = [NSString stringWithFormat:@"%ld", [numLabel.text integerValue]+1];
    label.backgroundColor = ZXColor(48, 166, 27, 1);
    label.textColor = [UIColor whiteColor];
    _noWantFood.selected = NO;
    [_noWantFood setBackgroundColor:ZXColor(238, 238, 238, 1)];
    [_noWantFood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.delegate buttonClickWithButton:sender Type:@"add"];
    
}

-(void)noWant:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    self.isNOSelect = YES;
    _noWantFood.selected = !_noWantFood.selected;
    if (_noWantFood.selected == NO) {
        [sender setBackgroundColor:ZXColor(238, 238, 238, 1)];
    }
    else{
        [sender setBackgroundColor:ZXColor(48, 166, 27, 1)];
        for (int i = 0; i<self.foodArray.count; i++) {
            UILabel *numLabel = [self viewWithTag:i+100];
            UILabel *label = [self viewWithTag:i+1000];
            label.backgroundColor = ZXColor(238, 238, 238, 1);
            label.textColor = [UIColor blackColor];
            numLabel.text = @"0";
        }
    }
    [self.delegate buttonClickWithButton:sender Type:@"zero"];
}

@end
