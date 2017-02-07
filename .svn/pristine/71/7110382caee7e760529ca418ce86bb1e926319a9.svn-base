//
//  LoginViewController.m
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPassWordViewController.h"
#import "RegisterViewController.h"
#import "NSString+MD5HexDigest.h"
#import "NSString+Verify.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *LookPassWordBnt;
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) NSInteger count;
@property (nonatomic,strong)TCPChannel*channel;

@end

@implementation LoginViewController

//-(void)viewWillAppear:(BOOL)animated
//{
//    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
//    }else{
//        self.navigationItem.leftBarButtonItem=nil;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    
    self.title = @"用户登录";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dimiss:)];
    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ZXColor(255, 255, 255, 1);
    

    self.navigationItem.leftBarButtonItem = back;
    
    _count = 0;
    self.userTF.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
    [self regestNSNotification];
    
}

#pragma mark -- 登录按钮点击事件
- (IBAction)lgoin:(id)sender {
    [self.view endEditing:YES];
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    if (_userTF.text.length == 0 && _passWordTF.text.length == 0) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"用户名密码不能为空" controller:self];
        return;
    }
    NSString *newIP = [[TCPChannel getTcpChannel] getProperIPWithAddress:HOST_IP port:HOST_PORT];
    //连接TCP
    [[TCPChannel getTcpChannel]connectServer:newIP port:HOST_PORT];
    
      //推迟两纳秒执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
        NSLog(@"====++++%@", KUUID);
        [[TCPChannel getTcpChannel] sendLoginWithUesrName:_userTF.text passWord:_passWordTF.text Add:KUUID];
    });
}
/**
 注册通知登陆
 */
- (void)regestNSNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Login_SC_Or_Failnotification) name:NotificationSC_KEY object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoginFailnotification) name:NotificationFAIL_KEY object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoginREGnotification) name:NotificationREG_KEY object:nil];
   
}
//密码或用户名密码错误
- (void)LoginFailnotification
{
    [[ShowMessageTools sharedInstance]showSimplMessage:@"用户名或密码错误" controller:self];
    
}
//没注册
- (void)LoginREGnotification
{
    
    
    [[ShowMessageTools sharedInstance]showSimplMessage:@"你还没注册" controller:self];;
}
//成功
- (void)Login_SC_Or_Failnotification
{
    
   
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
#pragma mark -- 注册按钮点击事件
- (IBAction)register1:(id)sender {
    [self.view endEditing:YES];
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma 密码可见点击事件
- (IBAction)LookPassWord:(id)sender {
    if (_count %2 != 0) {
        
        [_LookPassWordBnt setImage:[UIImage imageNamed:@"eye40%.png"] forState:(UIControlStateNormal)];
        //设置密文不可见
        [_passWordTF setSecureTextEntry:YES];
    }else
    {
        [_LookPassWordBnt setImage:[UIImage imageNamed:@"eye100%.png"] forState:(UIControlStateNormal)];
        //设置密文可见
        [_passWordTF setSecureTextEntry:NO];

    }
    _count++;
    
}
#pragma mark -- 找回密码
- (IBAction)findPassWord:(id)sender {
    [self.view endEditing:YES];
    FindPassWordViewController *find = [[FindPassWordViewController alloc] initWithNibName:@"FindPassWordViewController" bundle:nil];
    find.isLogin = NO;
    [self.navigationController pushViewController:find animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_userTF == textField)
    {
        if ([toBeString length] > 11) {
            
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (_passWordTF == textField) {
        if ([toBeString length] > 15) {
            
            textField.text = [toBeString substringToIndex:15];
          
            return NO;
        }
    }
    return YES;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults]setObject:_userTF.text forKey:@"us"];
    [[NSUserDefaults standardUserDefaults]setObject:_passWordTF.text forKey:@"pw"];
    ;
}
#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //实例变量存储当前操作的输入框对象
    self.textField = textField;
    
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +500);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    
    return YES;
    
    
}
//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +480);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +480);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }

}

- (void)dimiss:(id)sender {
    [self.view endEditing:YES];
    if ([_delegate respondsToSelector:@selector(dismiss)]) {
        [_delegate dismiss];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationSC_KEY object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];

}

- (void)rebackToRootViewAction {
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
