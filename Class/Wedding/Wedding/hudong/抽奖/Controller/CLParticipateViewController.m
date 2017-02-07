//
//  CLParticipateViewController.m
//  YY
//
//  Created by 陈龙 on 16/6/30.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLParticipateViewController.h"
#import "CLXiShiTangNetanager.h"
#import "CLCheckViewController.h"

@interface CLParticipateViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *securityCode;


@end

@implementation CLParticipateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.securityCode.delegate = self;
    self.securityCode.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"securityCode"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)participateBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.securityCode.text isEqualToString:@""]) {
        [self showMessage:@"验证码不能为空"];
        return;
    }
    else if(self.securityCode.text.length != 7)
    {
        [self showMessage:@"验证码格式错误"];
        return;
    }
    else
    {
        [CLXiShiTangNetanager getJoinWithDrowID:self.securityCode.text JoinTel:[[NSUserDefaults standardUserDefaults]objectForKey:@"us"] CompletionHandler:^(NSString *result, NSError *error) {
            [self showMessage:result];
        }];
    }
    
}

- (IBAction)backClick:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    if ([message isEqualToString:@"报名成功"]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:self.securityCode.text forKey:@"securityCode"];
//            self.securityCode.text = @"";
        }];
        [alert addAction:cancelAction];
    }
    else
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.securityCode == textField)
    {
        if ([toBeString length] > 7) {
            textField.text = [toBeString substringToIndex:7];
            return NO;
        }
    }
    return YES;
}
- (IBAction)checkNumClick:(id)sender {
    [self.view endEditing:YES];
    if ([self.securityCode.text isEqualToString:@""]) {
        [self showMessage:@"验证码不能为空"];
        return;
    }
    else if(self.securityCode.text.length != 7)
    {
        [self showMessage:@"验证码格式错误"];
        return;
    }
    else
    {
        [CLXiShiTangNetanager getCurrentNumWithDrowID:self.securityCode.text CompletionHandler:^(NSArray *array, NSError *error) {
            CLCheckViewController *cvc = [[CLCheckViewController alloc]initWithNibName:@"CLCheckViewController" bundle:nil];
            cvc.isFromCustom = YES;
            cvc.numArr = array;
//            self.securityCode.text = @"";
            [self.navigationController pushViewController:cvc animated:YES];
        }];
    }
}
@end
