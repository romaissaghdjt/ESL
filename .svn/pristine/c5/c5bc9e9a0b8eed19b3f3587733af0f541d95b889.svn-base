//
//  ReserveViewController.m
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ReserveViewController.h"
#import "ReserveRusltViewController.h"
//#import "XHHomeController.h"
#import "LoginViewController.h"
#import "NSString+Verify.h"

//#import "XHXiShiTangController.h"
#import "CLTypeViewController.h"
#import "CLSeriesViewController.h"
#import "CLFoodTimeViewController.h"
//#import "UUID.h"
#import "CLStyleViewController.h"
#import "XiShiTangModel.h"
#import "CLCalendarViewController.h"
#import "CLXiShiTangNetanager.h"

#define url [PREURL stringByAppendingString:@"BookHandler.ashx"]


@interface ReserveViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _flag;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *xiShiTypeField;
@property (weak, nonatomic) IBOutlet UITextField *foodTypeField;
@property (weak, nonatomic) IBOutlet UITextField *xiShiTangNameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *foodTimeField;
@property (weak, nonatomic) IBOutlet UITextField *mainField;
@property (weak, nonatomic) IBOutlet UITextField *minorField;
@property (weak, nonatomic) IBOutlet UIButton *man;
@property (weak, nonatomic) IBOutlet UIButton *women;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

@property (strong, nonatomic) UITextField *textField;//键盘回收
//
@property (nonatomic, strong)CLVillageModel *villageModel;
@property (nonatomic, strong)FoodSeriesModel *foodSeriesModel;
@property (nonatomic, strong)NSArray *foodSeriesArr;
@property (nonatomic, strong)BanquetTypeModel *banquetTypeModel;
@property (nonatomic, strong)NSArray *banquetTypeArr;


@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *sexCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *addressCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *xiShiTypeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *xiShiTangNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *mainCountCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *minorCountCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *foodTypeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *mainFoodTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *dateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *confirmCell;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;


@end

@implementation ReserveViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    //添加键盘通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航条的颜色
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //    改变返回键的颜色
    self.navigationController.navigationBar.tintColor = ZXColor(83, 162, 38, 1);
    //       设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    WK(weakSelf)
    [CLXiShiTangNetanager getBanquetTypeWithCompletionHandler:^(NSArray *banquetType, NSArray *foodSeries, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"网络错误" ViewController:self];
        }
        else
        {
            weakSelf.foodSeriesArr = foodSeries;
            weakSelf.foodSeriesModel = foodSeries.firstObject;
            weakSelf.banquetTypeArr = banquetType;
            weakSelf.banquetTypeModel = banquetType.firstObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.xiShiTypeField.text = weakSelf.banquetTypeModel.Name;
                weakSelf.foodTypeField.text = weakSelf.foodSeriesModel.Name;
            });
        }
    }];
    
    self.dateField.enabled = NO;
    self.xiShiTangNameField.enabled = NO;
    self.navigationController.navigationBar.hidden = NO;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    self.dateField.text = [formatter stringFromDate:date];
    
    self.title = @"预定信息";
    self.tabBarController.tabBar.hidden = YES;
    _man.selected = YES;
    _flag = 1;
    NSLog(@"%ld", self.isOther);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];

    //取消键盘通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return self.nameCell;
            break;
        case 1:
            return self.sexCell;
            break;
        case 2:
            return self.phoneCell;
            break;
        case 3:
            return self.addressCell;
            break;
        case 4:
            return self.xiShiTypeCell;
            break;
        case 5:
            return self.xiShiTangNameCell;
            break;
        case 6:
            return self.mainCountCell;
            break;
        case 7:
            return self.minorCountCell;
            break;
        case 8:
            return self.foodTypeCell;
            break;
        case 9:
            return self.mainFoodTimeCell;
            break;
        case 10:
            return self.dateCell;
            break;
        default:
            return self.confirmCell;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 12) {
        return 80;
    }
    else
    {
        return KHEIGHT * 60 / 640;
    }
    
}

//喜事类别点击事件
- (IBAction)classNameClick:(UIButton *)sender {
    WK(weakSelf)
    [self.view endEditing:YES];
    CLTypeViewController *vc = [[CLTypeViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(150, 130)Array:nil];
    vc.typeList = self.banquetTypeArr;
    vc.chooseBlock = ^(BanquetTypeModel *model){
        weakSelf.xiShiTypeField.text = model.Name;
        weakSelf.banquetTypeModel = model;
    };
    [self presentViewController:vc animated:YES completion:nil];
}
//菜系点击事件
- (IBAction)foodClassClick:(UIButton *)sender {
    WK(weakSelf)
    [self.view endEditing:YES];
    CLSeriesViewController *vc = [[CLSeriesViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(150, 130)Array:nil];
    vc.seriesList = self.foodSeriesArr;
    vc.chooseBlock = ^(FoodSeriesModel *model){
        weakSelf.foodSeriesModel = model;
        weakSelf.foodTypeField.text = model.Name;
    };
    [self presentViewController:vc animated:YES completion:nil];
}
//正餐时间点击事件
- (IBAction)foodTimeClick:(UIButton *)sender {
    WK(weakSelf)
    [self.view endEditing:YES];
    CLFoodTimeViewController *vc = [[CLFoodTimeViewController alloc] initWithSourceView:sender sourceRect:sender.bounds contentSize:CGSizeMake(150, 100)Array:nil];
    
    vc.chooseBlock = ^(NSString *string){
        weakSelf.foodTimeField.text = string;
        
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark -- 立即预定按钮相应事件
- (IBAction)reserve:(id)sender {
    
    [self.view endEditing:YES];
    
    if ([_phoneField.text isEqualToString:@""]||[_nameField.text isEqualToString:@""]||[_minorField.text isEqualToString:@""]||[_mainField.text isEqualToString:@""]||[_dateField.text isEqualToString:@""]||[_xiShiTangNameField.text isEqualToString:@""]||[_addressField.text isEqualToString:@""]||(_man.selected == NO && _women.selected == NO)) {
        [UIViewController showMessage:@"信息不能为空" ViewController:self];
        return;
    }
    
    //判断手机格式
    if (![_phoneField.text verityTelepone]) {
        [UIViewController showMessage:@"手机格式不正确" ViewController:self];
        return;
    }
    
    [self judgeAboutWithPattern:@"^(?:[\u4e00-\u9fa5|a-zA-Z])+?$" TextField:self.nameField];
    [self judgeAboutWithPattern:@"^[0-9]*$" TextField:self.mainField];
    [self judgeAboutWithPattern:@"^[0-9]*$" TextField:self.minorField];
    
    NSString *fkDinnerTimeID = @"1";
    if ([self.foodTimeField.text isEqualToString:@"晚上"]) {
        fkDinnerTimeID = @"2";
    }
    ReserveRusltViewController *ruslt = [[ReserveRusltViewController alloc] initWithNibName:@"ReserveRusltViewController" bundle:nil];
    ruslt.nameStr = _nameField.text;
    ruslt.phoneStr = _phoneField.text;
    ruslt.addressStr = _addressField.text;
    ruslt.mainStr = _mainField.text;
    ruslt.minorStr = _minorField.text;
    ruslt.sexStr = [NSString stringWithFormat:@"%ld", _flag];
    ruslt.xiShiTangStr = self.xiShiTangNameField.text;
    ruslt.dateStr = _dateField.text;
    ruslt.villageModel = self.villageModel;
    ruslt.xiShiClassStr = self.xiShiTypeField.text;
    ruslt.foodStr = self.foodTypeField.text;
    ruslt.foodTimeStr = self.foodTimeField.text;
    ruslt.foodSeriesModel = self.foodSeriesModel;
    ruslt.banquetTypeModel = self.banquetTypeModel;
    ruslt.foodSeriesArr = self.foodSeriesArr;
    ruslt.banquetTypeArr = self.banquetTypeArr;
    ruslt.isOther = self.isOther;
    [self.navigationController pushViewController:ruslt animated:YES];
}
#pragma mark -- 选择男女
- (IBAction)manCilck:(id)sender {
    _man.selected = !_man.selected;
    if (_man.selected == YES) {
        _women.selected = NO;
        _flag = 1;
    }
}

- (IBAction)womanClick:(id)sender {
    _women.selected = !_women.selected;
    if (_women.selected == YES) {
        _man.selected = NO;
        _flag = 0;
    }
}


#pragma mark -- 选择婚宴日期相应事件
- (IBAction)dateClick:(id)sender {
    WK(weakSelf)
    [self.view endEditing:YES];
    
    CLCalendarViewController *cvc = [[CLCalendarViewController alloc]init];
   // cvc.isFromOther = YES;
    cvc.PushData = ^(NSString *date){
        weakSelf.dateField.text = date;
    };
    [self.navigationController pushViewController:cvc animated:YES];
}


#pragma UITextFieldDelegate -- 键盘回收
//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (self.nameField == textField) {
        if ([toBeString length] > 8) {
            textField.text = [toBeString substringToIndex:8];
            return NO;
        }
    }
    if (self.mainField == textField) {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:2];
            return NO;
        }
    }
    if (self.minorField == textField) {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:2];
            return NO;
        }
    }
    if (self.addressField == textField) {
        if ([toBeString length] > 20) {
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    return YES;
}

-(void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode  currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (textField == self.nameField) {
                if (toBeString.length > 8) {
                    textField.text = [toBeString substringToIndex:8];
                }
            }
            else
            {
                if (toBeString.length > 20) {
                    textField.text = [toBeString substringToIndex:20];
                }
            }
            
        }
    }
}

- (IBAction)gotoXiShiTang:(id)sender {
//    XHXiShiTangController *xiyan = [[XHXiShiTangController alloc]init];
//    xiyan.isFromOther = YES;
//    xiyan.confirmBlock = ^(CLVillageModel *village){
//        self.villageModel = village;
//        self.xiShiTangNameField.text = village.Name;
//    };
//    [self.navigationController pushViewController:xiyan animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

-(void)judgeAboutWithPattern:(NSString *)pattern TextField:(UITextField *)textField
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    NSTextCheckingResult *result2 = [regex firstMatchInString:textField.text options:0 range:NSMakeRange(0, textField.text.length)];
    
    if (!result2) {
        if (textField == self.nameField) {
            [UIViewController showMessage:@"姓名格式错误" ViewController:self];
            return;
        }
        else if (textField == self.mainField)
        {
            [UIViewController showMessage:@"主桌数格式错误" ViewController:self];
            return;
        }
        else
        {
            [UIViewController showMessage:@"副桌数格式错误" ViewController:self];
            return;
        }
    }
}

-(void)openKeyboard:(NSNotification *)notification
{
    //按照键盘的高度修改输入框底部的约束的constant
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.inputViewBottomConstraint.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}
-(void)closeKeyboard:(NSNotification *)notification
{
    //修改输入框底部的约束的constant为0
    //按照键盘的高度修改输入框底部的约束的constant
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.inputViewBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}


@end
