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
#import "UIView+HUD.h"

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
//参与报名
- (IBAction)participateBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.securityCode.text isEqualToString:@""]) {
        [self.view showWarning:@"手机号不能为空"];
        return;
    }
    else
    {
        [CLXiShiTangNetanager getJoinWithDrowID:self.securityCode.text CompletionHandler:^(NSDictionary *result, NSError *error) {
            if ([result[@"提示"] isEqualToString:@"报名成功"]) {
                [self.view showWarning:result[@"提示"]];
            }
            else
            {
                [self.view showWarning:result[@"Reason"]];
            }
        }];
    }
    
}

- (IBAction)backClick:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.securityCode == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    return YES;
}
- (IBAction)checkNumClick:(id)sender {
    [self.view endEditing:YES];
    if ([self.securityCode.text isEqualToString:@""]) {
        [self.view showWarning:@"房间号不能为空"];
        return;
    }
    else
    {
        [CLXiShiTangNetanager getCurrentNumWithDrowID:self.securityCode.text Tel:us CompletionHandler:^(NSArray *array, NSError *error) {
            if (error) {
                [self.view showWarning:@"服务器繁忙"];
            }
            CLCheckViewController *cvc = [[CLCheckViewController alloc]init];
            cvc.isFromCustom = YES;
            cvc.numArr = array;
            [[NSUserDefaults standardUserDefaults]setObject:self.securityCode.text forKey:@"securityCode"];
            [self presentViewController:cvc animated:YES completion:nil];
        }];
    }
}
@end
