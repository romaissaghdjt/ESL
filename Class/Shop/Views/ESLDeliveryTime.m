//
//  ESLDeliveryTime.m
//  ESL
//
//  Created by 徐恒 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLDeliveryTime.h"

@implementation ESLDeliveryTime
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self View];
    }
    return self;
}
- (void)View{
    //背景一
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 40*SCREEN_DCALE)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    self.oneView = view;
    
    //背景二
    UIView *towView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, KWIDTH, 55)];
    [self addSubview:towView];
    towView.backgroundColor = ZXColor(225, 250, 220, 1);
    self.towView = towView;
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(20*SCREEN_SCALE, 5*SCREEN_DCALE, 90*SCREEN_SCALE, 30*SCREEN_DCALE)];
    timeLab.text = @"送达时间:";
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = [UIFont systemFontOfSize:15];
    [view addSubview:timeLab];
    
    UITextField *timenLabel = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLab.frame) + 20*SCREEN_SCALE, timeLab.frame.origin.y+1*SCREEN_SCALE, 150*SCREEN_DCALE, timeLab.frame.size.height)];
    timenLabel.placeholder = @"请选择送达日期->";
    timenLabel.font = [UIFont systemFontOfSize:15];
    timenLabel.textColor = [UIColor blackColor];
    timenLabel.textAlignment = NSTextAlignmentCenter;
    timenLabel.layer.borderWidth = 1;
    timenLabel.layer.cornerRadius = 3;
    timenLabel.layer.masksToBounds = YES;
    timenLabel.enabled = false;//禁止输入
    timenLabel.layer.borderColor = ZXColor(204, 204, 204, 1).CGColor;
    self.timenLabel = timenLabel;
    [view addSubview:timenLabel];
    
    
    UIButton *calendarBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timenLabel.frame)+30*SCREEN_SCALE, timeLab.frame.origin.y, 30*SCREEN_SCALE,timeLab.frame.size.height)];
    [calendarBtn setImage:[UIImage imageNamed:@"day"] forState:UIControlStateNormal];
    calendarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.CalendarBtn = calendarBtn;
    [view addSubview:calendarBtn];
   
    
    UILabel  *headLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 150, 20)];
//    headLab.backgroundColor = ZXColor(61, 176, 47, 1);
    headLab.font = [UIFont systemFontOfSize:15];
    headLab.text = @"您是否需要定制厨师?";
    headLab.textAlignment = NSTextAlignmentCenter;
    [towView addSubview:headLab];
    
    UILabel  *needLab = [[UILabel alloc]init];
    //==============================================
    if (SW==320) {
        needLab.frame = CGRectMake(CGRectGetMaxX(headLab.frame)+10 , headLab.frame.origin.y, 32, 20 );
    }else if (SW==375){
        needLab.frame = CGRectMake(CGRectGetMaxX(headLab.frame)+24 , headLab.frame.origin.y, 32, 20 );
    }else{
        needLab.frame = CGRectMake(CGRectGetMaxX(headLab.frame)+33 , headLab.frame.origin.y, 32, 20 );
    }
    needLab.text = @"需要";
//    needLab.backgroundColor = [UIColor redColor];
    needLab.font = [UIFont systemFontOfSize:15];
    needLab.textAlignment = NSTextAlignmentLeft;
    [towView addSubview:needLab];
    
    UIButton  *btn = [[UIButton alloc]init];
    [btn setImage:defaultImg forState:UIControlStateNormal];
    [btn setImage:seletedImg forState:UIControlStateSelected];
    self.NeedBtn = btn;
//    btn.backgroundColor = [UIColor blueColor];
    //==============================================
    if (SW==320) {
        btn.frame = CGRectMake(CGRectGetMaxX(needLab.frame)+10  , headLab.frame.origin.y, 20 , 20);
    }else if (SW==375){
        btn.frame = CGRectMake(CGRectGetMaxX(needLab.frame)+24  , headLab.frame.origin.y, 20 , 20);
    }else{
        btn.frame = CGRectMake(CGRectGetMaxX(needLab.frame)+33  , headLab.frame.origin.y, 20 , 20);
    }
    [towView addSubview:btn];
    
    UILabel  *noNeedLab = [[UILabel alloc]init];
    //==============================================
    if (SW==320) {
        noNeedLab.frame = CGRectMake(CGRectGetMaxX(btn.frame)+10  , headLab.frame.origin.y  , 48, 20  );
    }else if (SW==375){
        noNeedLab.frame = CGRectMake(CGRectGetMaxX(btn.frame)+24  , headLab.frame.origin.y  , 48, 20  );
    }else{
        noNeedLab.frame = CGRectMake(CGRectGetMaxX(btn.frame)+33  , headLab.frame.origin.y  , 48, 20  );
    }
    noNeedLab.text = @"不需要";
//    noNeedLab.backgroundColor = [UIColor purpleColor];
    noNeedLab.font = [UIFont systemFontOfSize:15];
    noNeedLab.textAlignment = NSTextAlignmentLeft;
    [towView addSubview:noNeedLab];
    
    UIButton  *btn1 = [[UIButton alloc]init];
    //==============================================
    if (SW==320) {
        btn1.frame = CGRectMake(CGRectGetMaxX(noNeedLab.frame)+10  , headLab.frame.origin.y, 20  , 20);
    }else if (SW==375){
        btn1.frame = CGRectMake(CGRectGetMaxX(noNeedLab.frame)+23  , headLab.frame.origin.y, 20  , 20);
    }else{
        btn1.frame = CGRectMake(CGRectGetMaxX(noNeedLab.frame)+33  , headLab.frame.origin.y, 20  , 20);
    }
    [btn1 setImage:defaultImg forState:UIControlStateNormal];
    [btn1 setImage:seletedImg forState:UIControlStateSelected];
    self.NoNeedBtn = btn1;
    [towView addSubview:btn1];
    
    
    UILabel  *cuisineLab = [[UILabel alloc]initWithFrame:CGRectMake(10, btn1.frame.origin.y+30  , 65, 20  )];
    cuisineLab.text = @"菜系选择";
//    cuisineLab.backgroundColor = [UIColor grayColor];
    cuisineLab.font = [UIFont systemFontOfSize:15];
    cuisineLab.textAlignment = NSTextAlignmentLeft;
    [towView addSubview:cuisineLab];
    
    UIButton  *cuisineBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cuisineLab.frame)+10  , cuisineLab.frame.origin.y, 100  , 20  )];
    cuisineBtn.backgroundColor = ZXColor(67, 175, 32, 1);
    [cuisineBtn setTitle:@"宁波本帮菜" forState: UIControlStateNormal];
    [cuisineBtn setImage:[UIImage imageNamed:@"多边形1"] forState:UIControlStateNormal];
    cuisineBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cuisineBtn setImageEdgeInsets:(UIEdgeInsetsMake(2, 80  , 0, -5))];
    [cuisineBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -16  , 0, 20  )];
    cuisineBtn.layer.cornerRadius = 3;
    cuisineBtn.layer.masksToBounds = YES;
    self.CuisineBtn = cuisineBtn;
    [towView addSubview:cuisineBtn];
    
    UITextField *tableNumber = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cuisineBtn.frame)+20, cuisineBtn.frame.origin.y, KWIDTH-cuisineBtn.frame.size.width-130, 20)];
    tableNumber.placeholder = @" 请填写桌数";
    tableNumber.textAlignment = NSTextAlignmentCenter;
    tableNumber.font = [UIFont systemFontOfSize:14];
    tableNumber.layer.borderWidth = 1;
    tableNumber.layer.borderColor = [UIColor grayColor].CGColor;
    tableNumber.layer.cornerRadius = 3;
    tableNumber.backgroundColor = [UIColor whiteColor];
    tableNumber.delegate = self;
    tableNumber.layer.masksToBounds = YES;
    tableNumber.userInteractionEnabled = NO;
//    tableNumber.returnKeyType = UIReturnKeyGo;
    tableNumber.keyboardType = UIKeyboardTypeDecimalPad;//数字键盘
    [towView addSubview:tableNumber];
    self.tableNum = tableNumber;

    
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    //设置style
    [topView setBarStyle:UIBarStyleDefault];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    [doneButton setTintColor:[UIColor blueColor]];
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.tableNum  setInputAccessoryView:topView];
}
//隐藏键盘
- (void)resignKeyboard {
    [self.tableNum resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    回收键盘,取消第一响应者
    [textField resignFirstResponder];
    return YES;
    
}
//3.实现协议中的方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.NeedBtn.selected == YES) {
        [self.tableNum resignFirstResponder];
    }
}
//textField第一位不能零
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (str.length==0) {
        return YES;
    }else{
    char a = [str characterAtIndex:0];
    if (a == 48) {
        return NO;
    }
    return YES;
 }
}
@end
