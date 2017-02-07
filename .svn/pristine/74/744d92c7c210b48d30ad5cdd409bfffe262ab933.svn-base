//
//  RegisterViewController.m
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+MD5HexDigest.h"
#import "NSString+Verify.h"
#define url [PREURL stringByAppendingString:@"User.ashx?"]//注册
 // Http://120.27.141.95:8221/ashx/User.ashx?Function=Regist&UserTel=15558793823&UserPwd=123456&UserCode= 55555
@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (strong,nonatomic )UIButton *bb;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
@end

@implementation RegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.getCode.layer.borderColor = [UIColor greenColor].CGColor;
    self.getCode.layer.borderWidth = 1;
    self.getCode.layer.masksToBounds = YES;
    self.getCode.layer.cornerRadius = 5;
    
    self.phoneNum.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"注册";
    

    /**
     注册成功弹出动画
     */
//    _bb = [[UIButton alloc]init];
//    _bb.backgroundColor = [UIColor blackColor];
//    [_bb setTitle:@"注册成功" forState:(UIControlStateNormal)];
//    [_bb addTarget:self action:@selector(bbs) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:_bb];
//    _bb.hidden = YES;
}
#pragma 点击动画事件
//- (void)bbs
//{[UIView animateWithDuration:2 animations:^{
//    _bb.frame = CGRectMake(0, 0, 0, 0);
//    _bb.hidden = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController popViewControllerAnimated:YES];
//}];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 注册确定按钮
- (IBAction)enter:(id)sender {
//    [UIView animateWithDuration:1 animations:^{
//     _bb.frame = CGRectMake(50, 200, 200, 200);
//        _bb.hidden = NO;
//        self.view.backgroundColor = [UIColor lightGrayColor];
//        [self performSelector:@selector(timer) withObject:_bb afterDelay:3];
//    
//     
//    
//    }];
    if (_phoneNum.text.length == 0 || _passWordTF.text.length == 0) {
        [UIViewController showMessage:@"用户名或密码不能为空" ViewController:self];
        return;
    }
    if (_codeNum.text.length == 0) {
        [UIViewController showMessage:@"请输入验证码" ViewController:self];
        return;
    }
    if (![_passWordTF.text isEqualToString:_confirmPwd.text]) {
        [UIViewController showMessage:@"密码不一致" ViewController:self];
        return;
    }
    NSString *urll = [NSString stringWithFormat:[url stringByAppendingString:@"Function=Regist&UserTel=%@&UserPwd=%@&UserCode=%@"],_phoneNum.text,[_passWordTF.text md5HexDigest],_codeNum.text];
    
    //NSString*urll = [NSString stringWithFormat:@"http://120.27.141.95:8221/ashx/User.ashx?Function=Regist&UserTel=%@&UserPwd=%@&UserCode=%@",_phoneNum.text,[_passWordTF.text md5HexDigest],_codeNum.text];
    [self requestNetUrl:urll];
    
    
}
#pragma 定时器方法注册成功返回登录
//- (void)timer
//{
//    _bb.hidden = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark -- 发送网络请求
- (void)requestNetUrl:(NSString *)netUrl
{
    [zJRequestManager requestWithUrl:netUrl parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString*key = dic[@"提示"];
        [self showstr:key];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
#pragma mark -- 解析数据
- (void)showstr:(NSString *)key {
   
    
    if ([key isEqualToString:@"注册成功"]) {
        [[ShowMessageTools sharedInstance]showMessageBack:key controller:self block:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([key isEqualToString:@"注册失败"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"注册失败" controller:self];
    }else if ([key isEqualToString:@"验证码错误"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"验证码错误" controller:self];
    }else if ([key isEqualToString:@"验证码丢失"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"验证码丢失" controller:self];
    }else if ([key isEqualToString:@"该手机号已注册"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"该手机号已注册" controller:self];
    }else if ([key isEqualToString:@"验证码已发送"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"验证码已发送" controller:self];
        //获取验证码失败
    }else if ([key isEqualToString:@"获取验证码失败"]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"获取验证码失败" controller:self];
        //获取验证码失败
    }else
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"获取验证码过期" controller:self];
    }
    
}
#pragma mark -- 获取验证码
- (IBAction)getCode:(id)sender {
    if (_phoneNum.text.length == 0) {
        [UIViewController showMessage:@"手机号码不能空" ViewController:self];
        return;
    }else if (![_phoneNum.text verityTelepone]) {
        [UIViewController showMessage:@"手机格式不正确" ViewController:self];
        return;
    }
    NSString*GetCodeurl = [NSString stringWithFormat:[url stringByAppendingString:@"Function=GetCode&UserTel=%@" ],_phoneNum.text];
    [self requestNetUrl:GetCodeurl];
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_getCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                //设置界面的按钮显示 根据自己需求设置
                _getCode.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_getCode setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _getCode.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark 点击弹窗确定按钮
- (void)showSucceedMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancelAction];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_phoneNum == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            [UIViewController showMessage:@"号码只有十一位" ViewController:self];
            return NO;
        }
    }
    if (_passWordTF == textField || _confirmPwd == textField) {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    return YES;
    
}
#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //实例变量存储当前操作的输入框对象
    _textField = textField;
    
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +450);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    
}
@end
