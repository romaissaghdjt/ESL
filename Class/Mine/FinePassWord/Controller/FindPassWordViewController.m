//
//  FindPassWordViewController.m
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "NSString+MD5HexDigest.h"
#import "NSString+Verify.h"
#define url [PREURL stringByAppendingString:@"User.ashx?"]//修改密码
@interface FindPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getCode.layer.masksToBounds = YES;
    self.getCode.layer.cornerRadius = 5;
    self.getCode.layer.borderWidth = 1;
    self.getCode.layer.borderColor = [UIColor greenColor].CGColor;
    self.navigationController.navigationBar.hidden = NO;
    if (self.isLogin == YES) {
        self.title = @"修改密码";
        self.phoneNumTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"us"];
        self.phoneNumTF.enabled = YES;
    }
    else
    {
        self.title = @"找回密码";
        self.phoneNumTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"us"];
        self.phoneNumTF.enabled = YES;
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- 发送网络请求
- (void)requestNetUrl:(NSString *)netUrl withDictionary:(NSDictionary *)dic {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak FindPassWordViewController *vc = self;
    [manager POST:netUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [vc parerData:responseObject];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -- 解析数据
- (void)parerData:(NSData *)data {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSString*str = dic[@"提示"];
    //    NSLog(@"_+_+_+_+%@",str);
    if ([str isEqualToString:@"1"]) {
        [self showMessage:@"发送成功"];
    }else if ([str isEqualToString:@"-1"]) {
        [self showMessage:@"请求失败"];
    }else if ([str isEqualToString:@"-2"]) {
        [self showMessage:@"操作超时"];
    }else if ([str isEqualToString:@"-3"]) {
        [self showMessage:@"验证码错误"];
    }else if ([str isEqualToString:@"-4"]) {
        [self showMessage:@"验证码丢失"];
    }else if ([str isEqualToString:@"重置成功"]) {
        [self showMessage:@"设置成功"];
        
    }
}
#pragma mark -- 获取验证码按钮
- (IBAction)getCode:(id)sender {
    if (![_phoneNumTF.text verityTelepone]) {
        [self showMessage:@"手机格式不正确"];
        return;
    }
     NSString*GetCodeurl = [NSString stringWithFormat:[url stringByAppendingString:@"Function=GetCode&UserTel=%@" ],_phoneNumTF.text];
    [self requestNetUrl:GetCodeurl withDictionary:nil];
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
- (IBAction)findPW:(id)sender {
    [self.view endEditing:YES];
    if (_phoneNumTF.text.length == 0 || _passWordTF.text.length == 0) {
        [self showMessage:@"用户名或密码不能为空"];
        return;
    }
    if (_codeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    if (![_passWordTF.text isEqualToString:_confirmPwd.text]) {
        [self showMessage:@"密码不一致"];
        return;
    }
    //    NSLog(@"%@%@%@",_passWordTF.text,_phoneNumTF.text,_codeTF.text);
   //NSDictionary *dic = @{@"Function":@"ForgetPwd",@"UserTel":_phoneNumTF.text,@"UserNewPass":[_passWordTF.text md5HexDigest],@"UserCode":_codeTF.text};
    NSString*Furl = [NSString stringWithFormat:[url stringByAppendingString:@"Function=ForgetPwd&UserTel=%@&UserNewPwd=%@&UserCode=%@" ],_phoneNumTF.text,[_passWordTF.text md5HexDigest],_codeTF.text];
    NSLog(@"%@",Furl);
    [self requestNetUrl:Furl withDictionary:nil];
}
//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
//
#pragma mark --发送错误方法
- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    if ([message isEqualToString:@"设置成功"]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:cancelAction];
    }
    else
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
    }
    
    
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_phoneNumTF == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            [self showMessage:@"号码只有十一位"];
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
@end
