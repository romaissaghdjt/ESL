//
//  ToJoinInController.m
//  YY
//
//  Created by 徐恒 on 16/5/12.
//  Copyright © 2016年 徐恒. All rights reserved.
//公司加盟

#import "ToJoinInController.h"
#import "ToJionInModel.h"
#import "CLCalendarViewController.h"
#import "NSString+Verify.h"
#import "ContractController.h"
#import "ToJooinChooseController.h"
#import "XHTabBarController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TextFilter.h"

@interface ToJoinInController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TextFilterDelegate,LoginViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *ToJoinContract;
@property (strong, nonatomic) IBOutlet UIButton *SQButton;
@property (nonatomic, strong) TextFilter *filterCH;
@property (strong, nonatomic) IBOutlet UIButton *chooseButton;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UILabel *day;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) NSMutableArray *monthArray;
@property (strong, nonatomic) NSMutableArray *dayArray;
@property (strong, nonatomic) UIPickerView *datePickerView;
@property (assign, nonatomic) NSInteger count;
//日历背景 View
@property (weak, nonatomic)UIView *clearView;
//所选择的日期
@property (strong, nonatomic)NSString *chooseDate;
@property (strong, nonatomic) UIImageView *dropdownMenu;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *areaArray;
@property (strong, nonatomic) IBOutlet UILabel *weedLable;

@property (strong, nonatomic) NSString *str;
@property (strong, nonatomic) ToJionInModel *ToModel;
@property (strong, nonatomic)NSString*Id;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation ToJoinInController
- (void)dealloc
{
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phone"];
}
- (NSMutableArray *)areaArray
{
    if (_areaArray == nil) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    

    // 判断是否登录过
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    else
    {
        NSString*str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
        self.phoneTextFiled.text = str;
        self.phoneTextFiled.enabled = NO;
    }
}
//登陆返回代理
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _string;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    self.day.text = [formatter stringFromDate:date];
    self.SQButton.enabled = NO;
//    self.compnyTextField.inputType = YBTextInputTypeChinese|YBTextInputTypeLetter;
//    self.compnyTextField.maxLength = 30;
//    self.nametextField.inputType = YBTextInputTypeChinese|YBTextInputTypeLetter;
//    self.nametextField.maxLength = 30;
    [self creatView];
    [self request];
    [self.tableView reloadData];
    _filterCH = [[TextFilter alloc]init];
    [_filterCH SetFilter:_compnyTextField
               delegate:self
               maxCHLen:40
               allowNum:NO
                allowCH:YES
            allowLetter:YES
            allowLETTER:YES
            allowSymbol:YES
            allowOthers:@"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～"];
    [_filterCH SetFilter:_nametextField
                delegate:self
                maxCHLen:40
                allowNum:NO
                 allowCH:YES
             allowLetter:YES
             allowLETTER:YES
             allowSymbol:YES
             allowOthers:@"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～"];
    [self createRightBtn];
}
//返回首页和订单的下拉框
- (void)createRightBtn{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setImage:[UIImage imageNamed:@"50x40_02"] forState:UIControlStateNormal];
//    if (SH<=568) {
//        btn.frame = CGRectMake(245, 10, 40, 30);
//    }else if (SH>568){
//        btn.frame = CGRectMake(320, 10, 40, 30);
//    }
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
//    btn.tintColor = [UIColor grayColor];
//
//    [btn addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.bb = btn;
}
-(void)clickA
{
    //@property (strong, nonatomic) DropdownMenu *Menu ;
    //@property (strong, nonatomic)UIButton *bb;
    //MessageControllerDelegeta
//    _Menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    //    messageC.view.userInteractionEnabled = YES;
//    messageC.deleagte = self;
//    _Menu.contentController = messageC;
//    [_Menu showFrom:self.bb];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_Menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        
//    }else if (indexPath.row==1){
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
//        // @property (strong, nonatomic)UIButton *btn;
//        // @property (strong, nonatomic)XHIndetController *XHindetC;
//        _XHindetC = [[XHIndetController alloc]init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:_XHindetC];
//        
//        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_btn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [_btn setTintColor:ZXColor(83, 162, 38, 1)];
//        _btn.frame = CGRectMake(0, 0, 20, 20);
//        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
//        _XHindetC.navigationItem.leftBarButtonItem = leftItem;
//        
//        [self presentViewController:navigation animated:NO completion:nil];
//        
//    }
}
//- (void)click
//{
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
- (void)creatView
{
    
    self.phoneTextFiled.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
    //[self.ToJoinContract setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    //self.ToJoinContract.enabled = NO;
    if ([self.title isEqualToString:@"厨师加盟"]) {
        [self.ToJoinContract setTitle:@"厨师协议" forState:(UIControlStateNormal)];
        
    }
    self.view5.layer.borderWidth = 0.2;
    self.view5.layer.cornerRadius = 10;
    self.count = 0;
//    self.compnyTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"compny"];
//    self.nametextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
//    self.phoneTextFiled.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    self.weedLable.text = @"婚庆公司";
    self.SQButton.layer.cornerRadius = 10;
    self.SQButton.backgroundColor = ZXColor(82, 162, 35, 1);
    self.SQButton.backgroundColor = ZXColor(56, 172, 88, 1);
    [_chooseButton
     setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
}
- (void)request
{
//     [self.view showBusyHUD];
    NSString*url =[PREURL stringByAppendingString:@"JoinHandler.ashx?Action=GetCompanyCgy"];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (dic.count == 0) {
            return ;
        }else{
            NSArray *key = dic[@"行业"];
            for (NSDictionary *dics in key) {
                _ToModel = [[ToJionInModel alloc]init];
                [_ToModel setValuesForKeysWithDictionary:dics];
                [self.areaArray addObject:_ToModel];
                
            }
//            [self.view hideBusyHUD];
            [self.tableView reloadData];
        }
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
    
}

- (IBAction)ClickButton:(id)sender {
    [_textField resignFirstResponder];
    self.dropdownMenu = [[UIImageView alloc]init];
    self.dropdownMenu.userInteractionEnabled = YES;//开启交互功能
    self.dropdownMenu.image = [UIImage imageNamed:@"喜事堂_03(2).png"];
    self.dropdownMenu.frame = CGRectMake(160*SWIDTH_SCALE,_view5.frame.origin.y+95, 200*SWIDTH_SCALE, 170*SHEIGHT_DCALE);
    self.dropdownMenu.backgroundColor = [UIColor whiteColor];
    self.dropdownMenu.layer.cornerRadius= 15;
    self.dropdownMenu.layer.masksToBounds = YES;
    self.dropdownMenu.layer.borderWidth = 2;
    self.dropdownMenu.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.dropdownMenu];
    
    if ([self.title isEqualToString:@"公司加盟"])
    {
        [self addTableView];
    }else
    {
        [self addbtn];
    }
}
- (void)addTableView
{
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 0, 200*SWIDTH_SCALE, 170*SHEIGHT_DCALE);
    [self.dropdownMenu addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
}
- (void)addbtn
{
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, 9,self.dropdownMenu.width, 1)];
    line0.backgroundColor = [UIColor blackColor];
    [self.dropdownMenu addSubview:line0];
    UIButton *b1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, self.dropdownMenu.width, 60)];
    [b1 setTitle:@"个人" forState:(UIControlStateNormal)];
    b1.backgroundColor = [UIColor whiteColor];
    [b1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.dropdownMenu addSubview:b1];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, b1.bottom,b1.width, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.dropdownMenu addSubview:line];
    UIButton *b2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 71, self.dropdownMenu.width, 60)];
    [b2 setTitle:@"团队" forState:(UIControlStateNormal)];
    b2.backgroundColor = [UIColor whiteColor];
    [b2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, b2.bottom,b1.width, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [self.dropdownMenu addSubview:line1];
    [self.dropdownMenu addSubview:b2];
    [b2 addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];
    [b1 addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)bb:(UIButton*)sender
{
    self.str = sender.titleLabel.text;
    self.weedLable.text = self.str;
    [self.dropdownMenu removeFromSuperview];
}
#pragma mark 点击勾选按钮点击事件
- (IBAction)chooseClick:(id)sender {
    if (_count %2 != 0) {
        self.SQButton.enabled = NO;
        self.SQButton.backgroundColor = ZXColor(56, 172, 88, 1);
        [_chooseButton
         setImage:[UIImage imageNamed:@"gray_icon.png"] forState:(UIControlStateNormal)];
        
        //[self.ToJoinContract setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        //self.ToJoinContract.enabled = NO;
    }else
    {
        self.SQButton.enabled = YES;
        self.SQButton.backgroundColor = ZXColor(76, 220, 68, 1);
        [_chooseButton setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
        //监听勾选按钮改变加盟合同的状态
        //[self.ToJoinContract setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        //self.ToJoinContract.enabled = YES;

        
    }
    _count++;
    
    
}
#pragma 加盟合同点击事件
- (IBAction)ToJoinButtonClick:(id)sender {
    
    ContractController *contractVC = [[ContractController alloc]init];
    contractVC.titles = self.ToJoinContract.titleLabel.text;
    [self.navigationController pushViewController:contractVC animated:YES];
    
}


//选择日期之后的确认按钮的点击事件
- (void)confirmButton:(UIButton *)sender
{
    self.day.text = self.chooseDate;
    [self.clearView removeFromSuperview];
}

#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //实例变量存储当前操作的输入框对象
    
    
    _textField = textField;
    [self.dropdownMenu removeFromSuperview];
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +400);
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
/***
 记住上一次输入的
 
 */

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.dropdownMenu removeFromSuperview];
    [_textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +460);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
}
#pragma mark-------菜单栏tableview的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.areaArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    ToJionInModel *TOmodel = self.areaArray[indexPath.row];
    cell.textLabel.text = TOmodel.Name;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToJionInModel *model = self.areaArray[indexPath.row];
    self.str = model.Name;
    self.weedLable.text = self.str;
    self.Id = model.ID;
    //[[NSUserDefaults standardUserDefaults]setObject:self.str forKey:@"bbb"];
    if (tableView) {
        self.phoneTextFiled.secureTextEntry = NO;
    }
    [self.dropdownMenu removeFromSuperview];
    
}
- (IBAction)ApplyClick:(id)sender {
#pragma mark  申请点击事件
   
    
    ///NSString*str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
    if ([_phoneTextFiled.text isEqualToString:@""]) {
        [self showMessage:@"信息不完整"];
        return;
    }
    
    
    
    [_textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +460);
    
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
    
    if ([_phoneTextFiled.text isEqualToString:@""]) {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([_day.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
        
    }else if ([_nametextField.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if ([_compnyTextField.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }else if (![_phoneTextFiled.text verityTelepone]) {
        [self showMessage:@"手机格式不正确"];
        return;
    }else if ([_weedLable.text isEqualToString:@""])
    {
        [self showMessage:@"信息不完整"];
        return;
    }
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9\\u4e00-\\u9fa5]+$" options:0 error:nil];
    
    NSTextCheckingResult *result3 = [regex1 firstMatchInString:self.compnyTextField.text options:0 range:NSMakeRange(0, self.compnyTextField.text.length)];
    
    if (!result3) {
        [self showMessage:@"公司名称不能含有特殊符号"];
        return;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9\\u4e00-\\u9fa5]+$" options:0 error:nil];
    
    NSTextCheckingResult *result2 = [regex firstMatchInString:self.nametextField.text options:0 range:NSMakeRange(0, self.nametextField.text.length)];
    
    if (!result2) {
        [self showMessage:@"负责人名称不能含有特殊符号"];
        return;
    }
    
    NSString *urls = [NSString stringWithFormat:[PREURL stringByAppendingPathComponent:@"JoinHandler.ashx?Action=CompanyJoin&dateTime=%@&JoinselectID=%@&Company=%@&User=%@&Tel=%@"],self.day.text,self.Id,self.compnyTextField.text,self.nametextField.text,self.phoneTextFiled.text];
    
    NSLog(@"%@",self.Id);

    
    [zJRequestManager requestWithUrl:urls parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (!dic)
        {
            return ;
        }else
        {
            NSString *key = dic[@"提示"];
            if ([key isEqualToString:@"申请加盟成功"])
            {
               // NSLog(@"%@",key);
                [self showXHMessage:@"申请成功"];
            }else if ([key isEqualToString:@"申请失败,请重试"])
            {
                
                [self showMessage:@"申请失败,请重试"];
            }
            
        }
        
    } failedWithError:^(NSError *connectionError) {
        
        
    }];
    
}
- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
}
- (void)showZMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
         RegisterViewController*navVC = [[RegisterViewController alloc] init];
        
        [self.navigationController pushViewController:navVC animated:YES];
    }];
    
    [alert addAction:cancelAction];
}
- (void)showXHMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        self.view.window.rootViewController = [[XHTabBarController alloc]init];
        
    }];
    
    [alert addAction:cancelAction];
}
- (void)showLoginMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"登录" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
        
        [self presentViewController:navVC animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回首页" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.view.window.rootViewController = [[XHTabBarController alloc]init];
        
    }];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.compnyTextField == textField)
    {
        if ([toBeString length] > 30) {
            textField.text = [toBeString substringToIndex:29];
            return NO;
        }
    }
    NSString * toBeString2 = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.nametextField == textField)
    {
        if ([toBeString2 length] > 11) {
            textField.text = [toBeString2 substringToIndex:11];
            return NO;
        }
    }
   
    
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
   
//        if ([_compnyTextField.text length] > 17) {
//            _compnyTextField.text = [textField.text substringToIndex:15];
//            //[self showMessage:@"超出限制"];
//            return ;
//        }
//    
//    if ([_nametextField.text length] > 10) {
//        _nametextField.text = [textField.text substringToIndex:6];
//        //[self showMessage:@"超出限制"];
//        return ;
//    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.dropdownMenu removeFromSuperview];

}

@end
