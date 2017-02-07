//
//  Shopping_Add_New_AddressController.m
//  ESL
//
//  Created by 赵洁 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "Shopping_Add_New_AddressController.h"
#import "ESLChooseAddressPiceView.h"
#import "AddressBaseViewModel.h"
#import "CountryModel.h"

@interface Shopping_Add_New_AddressController ()<UITextFieldDelegate,UITextViewDelegate,UINavigationBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource,TextFilterDelegate>

@property (strong, nonatomic) IBOutlet UITextField *NameTF;
@property (strong, nonatomic) IBOutlet UITextField *PhoneTF;
;
@property (strong, nonatomic) IBOutlet UIButton *chooseCountryButton;
@property (strong, nonatomic) IBOutlet UISwitch *chosseSwitch;
@property (strong, nonatomic) IBOutlet UIView *SwitchBackView;
@property (strong, nonatomic) IBOutlet UIView *BigBackView;
@property (strong, nonatomic) IBOutlet UILabel *MORenLable;

@property (nonatomic, assign)BOOL isOpen;

@property (strong, nonatomic) IBOutlet UITextView *AddressTextV;
@property (strong, nonatomic) IBOutlet UIButton *Defaul_oR_DelegateAddressButton;

@property (nonatomic,strong)UITextField*textField;
@property (nonatomic, strong)ESLChooseAddressPiceView*piceView;
@property (nonatomic, strong) NSDictionary *pickerdic;
/** 省 **/
@property (nonatomic, strong) NSMutableArray *pickerAry;
/** 市 **/
@property (strong,nonatomic)NSMutableArray *cityList;
/** 区 **/
@property (strong,nonatomic)NSMutableArray *areaList;
/** 第一级选中的下标 **/
@property (assign, nonatomic)NSInteger selectOneRow;
/** 第二级选中的下标 **/
@property (assign, nonatomic)NSInteger selectTwoRow;
/** 第三级选中的下标 **/
@property (assign, nonatomic)NSInteger selectThreeRow;

@property (nonatomic)BOOL isEdtor;

@property (nonatomic,strong)TextFilter*filterCH;//设置字符
@end

@implementation Shopping_Add_New_AddressController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isAdd == NO) {
        _isEdtor = YES;
    }
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if (_isother == YES) {
       // self.BigBackView.y = 0;

    }else
    {
       // self.BigBackView.y = 64;
        if (_isFrist == YES) {
            self.SwitchBackView.hidden = YES;

        }else
        {
                  //  self.SwitchBackView.y = self.BigBackView.bottom+9;

        }
    }

//    self.BigBackView.y = 0;
    if ([self.model.isDefault isEqualToString:@"true"]) {
        self.SwitchBackView.hidden = YES;
        self.Defaul_oR_DelegateAddressButton.frame = CGRectMake(0,self.BigBackView.bottom+9 , KWIDTH, 30) ;
    }else
    {
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isOpen = NO;
    _isEdtor= NO;
    
    self.chosseSwitch.on = NO;
    self.AddressTextV.text = @"请填写详细地址信息.至少5个字";
    self.selectOneRow = 0;
    self.selectTwoRow = 0;
    self.selectThreeRow = 0;
    if (_isAdd == NO) {
        self.title = @"编辑地址";
        self.NameTF.text = self.model.RecvName;
        self.PhoneTF.text = self.model.RecvTel;
        [self.Defaul_oR_DelegateAddressButton setTitle:@"删除地址" forState:(UIControlStateNormal)];
        [self.Defaul_oR_DelegateAddressButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.Defaul_oR_DelegateAddressButton addTarget:self action:@selector(delateButton:) forControlEvents:(UIControlEventTouchUpInside)];
        NSString*ss = [[NSString stringWithFormat:@"%@%@%@",self.model.ProvinceName,self.model.DistrictName,self.model.CountyName] stringByAppendingString:@"  >"];
        [self.chooseCountryButton setTitle:ss forState:(UIControlStateNormal)];
        self.AddressTextV.text = self.model.Details;
        
    }else
    {
        self.title = @"新建地址";
        self.Defaul_oR_DelegateAddressButton.hidden  =YES;
        self.Defaul_oR_DelegateAddressButton.enabled = NO;
        if (self.isFrist == YES) {
            self.SwitchBackView.hidden = YES;
        }
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(save)];
    //self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 将BarButtonItem添加到LeftBarButtonItem上
    self.navigationItem.leftBarButtonItem = backButton;
    _filterCH = [[TextFilter alloc]init];
    [_filterCH SetFilter:self.NameTF
                delegate:self
                maxCHLen:30
                allowNum:NO
                 allowCH:YES
             allowLetter:YES
             allowLETTER:YES
             allowSymbol:YES
             allowOthers:@"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～"];
    
    [self creatPickerView];
    
}
-(void)backBarButtonPressed
{
    if (_textField.text.length >0||_isEdtor == YES) {
        
        [[ShowMessageTools sharedInstance]showMessage:@"信息是否需要保存" controller:self block:^{
            
        } canclblock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)creatPickerView
{
    _piceView =[[NSBundle mainBundle]loadNibNamed:@"ESLChooseAddressPiceView" owner:nil options:nil].lastObject;
    
    
    _piceView.frame = CGRectMake(0, KHEIGHT, KWIDTH, 240);
    [_piceView.CanlButton
     addTarget:self action:@selector(cancelBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [_piceView.SureButton
     addTarget:self action:@selector(sureBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_piceView];
    _piceView.PicekerView.delegate = self;
    _piceView.PicekerView.dataSource = self;
    
    [self Dataparsing];
    //    [self getAreaDate:0];
    //    [self getCitydate:0];
    //不选默认数据写死暂时
    self.address = @"浙江省宁波市海曙区";
}
- (void)Dataparsing{
    
    NSString*url = [PREURL stringByAppendingPathComponent:@"Other.ashx?Function=GetAllCounty"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.pickerAry = [NSMutableArray array];
        self.cityList = [NSMutableArray array];
        self.areaList = [NSMutableArray array];
        for (NSDictionary*dic in array) {
            CountryModel*model = [[CountryModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            [self.pickerAry addObject:model];
            NSArray*ar = dic[@"Data"];
            for (NSDictionary*dics in ar) {
                CountryModel*model = [[CountryModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dics];
                [self.cityList addObject: model];
                NSArray*arra = dics[@"Data"];
                for (NSDictionary*dica in arra) {
                    CountryModel*model = [[CountryModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dica];
                    [self.areaList addObject:model];
                }
            }
            
        }
        [self.piceView.PicekerView reloadAllComponents];
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
}
//////取到市
//- (void)getCitydate:(NSInteger)row{
//
//    NSArray*arra = self.pickerAry[row][@"Data"];
//    for (NSDictionary*dic in arra) {
//        AddressMolde*model = [[AddressMolde alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [self.cityList addObject:model];
//    }
//   // self.cityList = cityList;
//    NSLog(@"self.cityList======%@",self.cityList);
//}
//- (void)getAreaDate:(NSInteger)row{
//    NSArray*arra = self.cityList[row][@"Data"];
//    for (NSDictionary*dic in arra) {
//        AddressMolde*model = [[AddressMolde alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [self.areaList addObject:model];
//    }
//
//}


- (void)sureBtn{
    [self.chooseCountryButton setTitle:[self.address stringByAppendingString:@"  >"]forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.5 animations:^{
        self.piceView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 240);
    } completion:^(BOOL finished) {
    }];
    
}

- (void)cancelBtn{
    [UIView animateWithDuration:0.5 animations:^{
        self.piceView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 240);
    } completion:^(BOOL finished) {
        //        [self.bgview removeFromSuperview];
    }];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        NSLog(@"-----%ld",self.self.pickerAry.count);
        
        return self.pickerAry.count;
    }else if (component == 1){
        NSLog(@"===%ld",self.self.cityList.count);
        
        return self.cityList.count;
    }else{
        NSLog(@"-=-=-=%ld",self.self.areaList.count);
        
        return self.areaList.count;
    }
    return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        CountryModel*model = self.pickerAry[row];
        return model.Name;;
    }
    if (component == 1){
        CountryModel*model = self.cityList[row];
        
        return model.Name;;
    }
    if (component == 2){
        CountryModel*model = self.areaList[row];
        
        return model.Name;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    static NSInteger oneRow = 0;
    static NSInteger tweRow = 0;
    static NSInteger threeRow = 0;
    
    
    if (component == 2){
        
        self.selectThreeRow = row;
        threeRow = row;
    }
    
    NSMutableString *regionAddress = [[NSMutableString alloc] init];
    
    if (oneRow != 0) {
        CountryModel*model =self.pickerAry[self.selectOneRow];
        [regionAddress appendFormat:@"%@",model.Name];
    }else{
        CountryModel*model =self.pickerAry[0];
        [regionAddress appendFormat:@"%@",model.Name];
    }
    if (tweRow != 0){
        CountryModel*model =self.cityList[self.selectTwoRow];
        [regionAddress appendFormat:@"%@",model.Name];
        
    }else{
        CountryModel*model =self.cityList[0];
        [regionAddress appendFormat:@"%@",model.Name];
    }
    if (threeRow != 0){
        CountryModel*model =self.areaList[self.selectThreeRow];
        [regionAddress appendFormat:@"%@",model.Name];
    }else{
        CountryModel*model =self.areaList[0];
        [regionAddress appendFormat:@"%@",model.Name];
    }
    
    self.address = regionAddress ;
    NSLog(@"=========%@",self.address);
}
- (IBAction)chooseCountryCilck:(id)sender {
    [self.view endEditing:YES];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +480);
    //    NSLog(@"aa %f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
    [UIView animateWithDuration:1 animations:^{
        CGRect tt = _piceView.frame;
        tt.origin.y = KHEIGHT-240;
        _piceView.frame = tt;
        NSLog(@"%f",_piceView.frame.origin.y);
    }];
}
- (void)save
{
    if (![self.PhoneTF.text verityTelepone]) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"手机格式不正确" controller:self];
        return;
    }
    if (self.NameTF.text.length == 0)
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"信息不完整" controller:self];
        return;
    }else if (self.PhoneTF.text.length == 0)
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"信息不完整" controller:self];
        return;
    }else if (_isEdtor == NO)
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"信息不完整" controller:self];
        return;
    }else if (self.AddressTextV.text.length < 5)
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"详细信息至少5个字" controller:self];
        return;
    }
    else
    {
        [[HUDView sharedInstanceWithView:self.view]showHUD];
        if (_isAdd == YES) {
            
            if ([_delegate respondsToSelector:@selector(getAddDataWithModel:isOpen:)])
            {
                AddressMolde*model = [[AddressMolde alloc]init];
                model.RecvName =self.NameTF.text ;
                model.RecvTel =self.PhoneTF.text ;
                CountryModel*model0 = self.pickerAry[self.selectOneRow];
                CountryModel*model1 = self.cityList[self.selectTwoRow];
                CountryModel*model2 = self.areaList[self.selectThreeRow];
                model.ProvinceName = model0.Name;
                model.DistrictName = model1.Name;
                model.CountyName = model2.Name;
                model.Details = self.AddressTextV.text;
                [_delegate getAddDataWithModel:model isOpen:_isOpen];
                AddressBaseViewModel*ViewModel = [[AddressBaseViewModel alloc]init];
                ViewModel.NewAddBlock = ^(id AddNewDataSucroe)
                {
                    
                };
                model = self.areaList[self.selectThreeRow];
                NSString*str = @"";
                if (_isOpen == YES)
                {
                    str = @"true";
                    
                }else
                {
                    str = @"false";
                    
                }
                if (self.isFrist == YES)
                {
                     [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:nil CountyID:model2.ID Details:self.AddressTextV.text IsDefault:@"true" isAdd:YES];
                }else
                {
                    [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:nil CountyID:model2.ID Details:self.AddressTextV.text IsDefault:str isAdd:YES];
                }
                
            }
        }else
        {
            if ([_delegate respondsToSelector:@selector(getEditoredAddress:withModel:isOpen:)]) {
                CountryModel*model0 = self.pickerAry[self.selectOneRow];
                CountryModel*model1 = self.cityList[self.selectTwoRow];
                CountryModel*model2 = self.areaList[self.selectThreeRow];
                
                self.model.RecvName =self.NameTF.text ;
                self.model.RecvTel =self.PhoneTF.text ;
                self.model.ProvinceName =model0.Name;
                self.model.DistrictName = model1.Name;
                self.model.CountyName = model2.Name;
                
                [_delegate getEditoredAddress:self.index withModel:self.model isOpen:_isOpen];
                AddressBaseViewModel*ViewModel = [[AddressBaseViewModel alloc]init];
                
                ViewModel.NewAddBlock= ^(id AddNewDataSucroe)
                {
                    
                };
                if (_isEdtor == YES)
                {
                    if ([self.model.isDefault isEqualToString:@"true"])
                    {
                        self.model.Details = self.AddressTextV.text;
                        
                        [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.AddressTextV.text IsDefault:self.model.isDefault isAdd:NO];
                    }else
                    {
                        if (_isOpen == YES)
                        {
                            self.model.Details = self.AddressTextV.text;
                            
                            [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.AddressTextV.text IsDefault:@"true" isAdd:NO];
                        }else
                        {
                            self.model.Details = self.AddressTextV.text;
                            
                            [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.AddressTextV.text IsDefault:@"false" isAdd:NO];
                        }
                        
                    }
                    
                }else
                {
                    if ([self.model.isDefault isEqualToString:@"true"]) {
                        self.model.Details = self.model.Details;
                        
                        [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.model.Details IsDefault:self.model.isDefault isAdd:NO];
                    }else
                    {
                        if (_isOpen == YES) {
                            self.model.Details = self.model.Details;
                            
                            [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.model.Details IsDefault:@"true" isAdd:NO];
                        }else
                        {
                            self.model.Details = self.model.Details;
                            
                            [ViewModel AddNew_Or_ModifiyRequestWithUserTel:us UUID:KUUID RecvTel:self.PhoneTF.text RecvName:self.NameTF.text RecvID:self.model.RecvID CountyID:model2.ID Details:self.model.Details IsDefault:@"false" isAdd:NO];
                        }
                    }
                }
            }
        }
        [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.isComplete = YES;
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }
    
}
- (void)delateButton:(UIButton*)bb
{

    
    WK(weakSelf);
    AddressBaseViewModel*viewmodel = [[AddressBaseViewModel alloc]init];
    [[ShowMessageTools sharedInstance]showMessage:@"确定删除地址" controller:weakSelf block:^{
        viewmodel.NewAddBlock = ^(id AddNewDataSucroe){
            
        };
        [viewmodel DeleteAddressDataWithUserTel:us UserPhyAdd:KUUID RecvAddrID:weakSelf.model.RecvID];
        if ([_delegate respondsToSelector:@selector(deleteThisAddressWith:)]) {
            [_delegate deleteThisAddressWith:self.index];
            
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } canclblock:^{
        
        return ;
        
    }];
    
}


- (IBAction)openOrCloseClick:(UISwitch*)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _isOpen = YES;
    }else{
        _isOpen = NO;
    }
    
    
    
}
#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //实例变量存储当前操作的输入框对象
    self.textField = textField;
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +400);
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
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 64;
            self.view.frame = frame;
        }];
    }
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_textField resignFirstResponder];
    [self.view endEditing:YES];
    
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +480);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 64;
            self.view.frame = frame;
        }];
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_NameTF == textField)
    {
        if ([toBeString length] > 10) {
            
            textField.text = [toBeString substringToIndex:10];
            return NO;
        }
    }
    if (_PhoneTF == textField) {
        if ([toBeString length] > 11) {
            
            textField.text = [toBeString substringToIndex:11];
            
            return NO;
        }
    }
    return YES;
    
}

#pragma mark UITextViewDelegate
//textView按return退键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
        
    {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
    
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    
    if ([_AddressTextV.text isEqualToString:@"请填写详细地址信息.至少5个字"]) {
         _AddressTextV.text=@"";

    }
    _isEdtor = YES;

    _AddressTextV.textColor = [UIColor blackColor];
    
    return YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];

}
@end
