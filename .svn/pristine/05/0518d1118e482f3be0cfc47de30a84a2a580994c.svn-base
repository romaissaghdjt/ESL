//
//  ReserveRusltViewController.m
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
////
#import "XHTabBarController.h"
#import "ReserveRusltViewController.h"
#import "SingleHandle.h"
//#import <AFNetworking.h>
#import "NSString+Verify.h"
//#import "XHXiShiTangController.h"
#import "CLTypeViewController.h"
#import "CLSeriesViewController.h"
#define url [PREURL stringByAppendingString:@"BookHandler.ashx"]
#import "CLFoodTimeViewController.h"
#import "CLStyleViewController.h"
#import "CLCalendarViewController.h"
#import "FeastDtiallController.h"
#import "TablewareController.h"
#import "TeamChefsDetailsViewController.h"
#import "CookChooseController.h"
@interface ReserveRusltViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//点击修改前cell
@property (strong, nonatomic) IBOutlet UITableViewCell *confirmCell;
//点击修改前属性
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *main;
@property (weak, nonatomic) IBOutlet UITextField *minor;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *xiShiTang;
@property (weak, nonatomic) IBOutlet UITextField *xiShiClass;
@property (weak, nonatomic) IBOutlet UITextField *food;
@property (weak, nonatomic) IBOutlet UITextField *foodTime;

@property (strong, nonatomic) UITextField *textField;//键盘回收
@end

@implementation ReserveRusltViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.confirmCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 610;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}
#pragma 确认信息按钮点击事件


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self changeTFEnabled];

    //导航条的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"预定成功";
    self.navigationController.navigationBar.titleTextAttributes =@{NSForegroundColorAttributeName: ZXColor(83, 162, 38, 1),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //修改前
    _name.text = _nameStr;
    _phone.text = _phoneStr;
    _address.text = _addressStr;
    _minor.text = _minorStr;
    _main.text = _mainStr;
    _date.text = _dateStr;
    _xiShiTang.text = self.villageModel.Name;
    _xiShiClass.text = _xiShiClassStr;
    _food.text = _foodStr;
    if ([_sexStr isEqualToString:@"1"]) {
        _sex.text = @"男";
    }else {
        _sex.text = @"女";
    }
    _foodTime.text = _foodTimeStr;
    NSLog(@"%ld", self.isOther);
}

#pragma mark -- 改变输入框的用户交互
- (void)changeTFEnabled {
    _xiShiTang.enabled = NO;
    _name.enabled = NO;
    _phone.enabled = NO;
    _address.enabled = NO;
    _minor.enabled =  NO;
    _main.enabled = NO;
    _date.enabled = NO;
    _sex.enabled = NO;
    _food.enabled = NO;
    _xiShiClass.enabled = NO;
    _foodTime.enabled = NO;
}


#pragma mark -- 再次编辑按钮相应事件
- (IBAction)change:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 确认信息 钮响应事件
- (IBAction)enter:(id)sender {
    [self.view endEditing:YES];

    NSString *dayStr = [[[_date.text stringByReplacingOccurrencesOfString:@"年" withString:@"/"] stringByReplacingOccurrencesOfString:@"月" withString:@"/"] stringByReplacingOccurrencesOfString:@"日" withString:@""];
        NSString *fkDinnerTimeID = @"1";
        if ([self.foodTime.text isEqualToString:@"晚上"]) {
            fkDinnerTimeID = @"2";
        }
 
        NSDictionary *dic = @{@"Action":@"book",
                              @"Name":_name.text,
                              @"fkCusTel":[[NSUserDefaults standardUserDefaults]objectForKey:@"us"],
                              @"Sex":_sexStr,
                              @"DeliveryAddr":_address.text,
                              @"MainCount":_main.text,
                              @"SubCount":_minor.text,
                              @"FeastDateTime":dayStr,
                              @"Tel":_phone.text,
                              @"Cuisine":_foodSeriesModel.ID,
                              @"FeastCgy":_banquetTypeModel.pkFstCgyID,
                              @"HallID":self.villageModel.HallID,
                              @"CustPhyAddr":KUUID,
                              @"fkDinnerTimeID":fkDinnerTimeID,
                              @"CuisAmflCgyID":_foodSeriesModel.ID};
    
        [self requestNetUrl:url withDictionary:dic];
}

#pragma mark -- 发送网络请求
- (void)requestNetUrl:(NSString *)netUrl withDictionary:(NSDictionary *)dic {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak ReserveRusltViewController *vc = self;
    [manager POST:netUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [vc parerData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task);
    }];
}

- (void)parerData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    NSLog(@"%@", dataDic[@"提示"]);
        if ([dataDic[@"提示"] isEqualToString:@"预定成功"]) {
            [self showScessMessage:@"预定成功"];
        }
        else if ([dataDic[@"提示"] isEqualToString:@"你有未支付的订单"]) {
            [self showScessMessage:@"你有未支付的订单"];
        }
        else if ([dataDic[@"提示"] isEqualToString:@"当日订单已满"]) {
            [self showScessMessage:@"当日订单已满"];
        }
        else {
            [UIViewController showMessage:dataDic[@"提示"] ViewController:self];
            return;
        }
}

- (void)showScessMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (self.isOther == YES) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[FeastDtiallController class]]||[controller isKindOfClass:[CookChooseController class]]||[controller isKindOfClass:[TeamChefsDetailsViewController class]]||[controller isKindOfClass:[TablewareController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
        else
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }];
    [alert addAction:cancelAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
