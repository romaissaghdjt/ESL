//
//  PersonalController.m
//  YY
//
//  Created by 徐恒 on 16/6/30.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PersonalController.h"
#import "PersonalCell.h"
#import "LabelCell.h"
#import "BtnCell.h"
#import "LoginViewController.h"
#import "XHTabBarController.h"
#import "FindPassWordViewController.h"
#import "ShoppingAddressController.h"
#import "MyQRCodeView.h"
@interface PersonalController ()<
UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UITextFieldDelegate,LoginViewControllerDelegate>

@property (strong, nonatomic)UITableView *tabView;
@property (strong, nonatomic)UIButton *btn;
@property (strong, nonatomic)UIView *footerView;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UITextField *infoTextField;
@property (nonatomic, strong)UIButton *manBtn;
@property (nonatomic, strong)UIButton *womanBtn;
@property (nonatomic, assign)BOOL isNickNAME;
@property (nonatomic, strong)UILabel *manLabel;
@property (nonatomic, strong)UILabel *womanLabel;
//@property (strong, nonatomic) DropdownMenu *Menu ;
//@property (strong, nonatomic)UIButton *bb;
//@property (strong,nonatomic)XHTabBarController*tt;
//@property (strong,nonatomic)XHIndetController*XHindetC;
@property (strong, nonatomic)MyQRCodeView *MyQRView;
@property (strong ,nonatomic)UIView *coverView;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)UIImage *imageloaction;

@end

@implementation PersonalController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.tt  = nil;
//    self.XHindetC = nil;
    self.tabView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"个人资料";
    self.tabBarController.tabBar.hidden = YES;
    [self cerateTabView];
    [self creatHiddenView];
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
//    [btn addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.bb = btn;
}
-(void)clickA
{
//    //@property (strong, nonatomic) DropdownMenu *Menu ;
//    //@property (strong, nonatomic)UIButton *bb;
//    //MessageControllerDelegeta
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
//        XHTabBarController*tt = [[XHTabBarController alloc]init];
//        [self presentViewController:tt animated:NO completion:nil];
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
//        XHIndetController*XHindetC = [[XHIndetController alloc]init];
//        [self.navigationController pushViewController:XHindetC animated:YES];
//
//    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.infoTextField == textField)
    {
        if ([toBeString length] > 8) {
            textField.text = [toBeString substringToIndex:8];
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
            if (textField == self.infoTextField) {
                if (toBeString.length > 8) {
                    textField.text = [toBeString substringToIndex:8];
                }
            }
        }
    }
}

- (void)cerateTabView{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.showsVerticalScrollIndicator = NO;
    //去掉多余的分割线
    [_tabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    [self.view addSubview:_tabView];
}

-(void)creatHiddenView
{
    self.hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    [self.view addSubview:self.hiddenView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.hiddenView addSubview:view];
    UIView *changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    changeView.center = self.hiddenView.center;
    [self.hiddenView addSubview:changeView];
    
    changeView.backgroundColor = [UIColor whiteColor];
    self.infoTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 80, 200, 40)];
    self.infoTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.infoTextField.backgroundColor = [UIColor lightGrayColor];
    self.infoTextField.delegate = self;
    [changeView addSubview:self.infoTextField];
    
    self.manBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 80, 30, 30)];
    self.manLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 80, 40, 30)];
    self.manLabel.text = @"男";
    self.womanBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 80, 30, 30)];
    self.womanLabel = [[UILabel alloc]initWithFrame:CGRectMake(185, 80, 40, 30)];
    self.womanLabel.text = @"女";
    [self.manBtn addTarget:self action:@selector(manCilck:) forControlEvents:UIControlEventTouchUpInside];
    [self.womanBtn addTarget:self action:@selector(womanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.manBtn setImage:[UIImage imageNamed:@"before_click1"] forState:UIControlStateNormal];
    [self.manBtn setImage:[UIImage imageNamed:@"after_click1"] forState:UIControlStateSelected];
    [self.womanBtn setImage:[UIImage imageNamed:@"before_click1"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"after_click1"] forState:UIControlStateSelected];
    [changeView addSubview:self.manBtn];
    [changeView addSubview:self.manLabel];
    [changeView addSubview:self.womanBtn];
    [changeView addSubview:self.womanLabel];
    
    UIButton *comfirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 180, 75, 40)];
    [comfirmBtn setTitle:@"修改" forState:UIControlStateNormal];
    [changeView addSubview:comfirmBtn];
    [comfirmBtn addTarget:self action:@selector(comfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    comfirmBtn.backgroundColor = ZXColor(83, 162, 38, 1);
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 180, 75, 40)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [changeView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.backgroundColor = ZXColor(83, 162, 38, 1);
    
    self.hiddenView.hidden = YES;
}

#pragma mark -- 选择男女
- (void)manCilck:(id)sender {
    _manBtn.selected = !_manBtn.selected;
    if (_manBtn.selected == YES) {
        _womanBtn.selected = NO;
    }
}

- (void)womanClick:(id)sender {
    _womanBtn.selected = !_womanBtn.selected;
    if (_womanBtn.selected == YES) {
        _manBtn.selected = NO;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)comfirmBtnClick
{
    [self.view endEditing:YES];
    if (self.isNickNAME == YES) {
        if ([((LabelCell *)[self.tabView viewWithTag:101]).rightName.text isEqualToString:self.infoTextField.text]) {
            self.hiddenView.hidden = YES;
            return;
        }
        if ([self.infoTextField.text isEqualToString:@""]) {
            [[ShowMessageTools sharedInstance]showSimplMessage:@"名字不能为空" controller:self];
            self.hiddenView.hidden = YES;
            return;
        }
        [self changeUserInfoWithUserTel:us UserPhyAdd:KUUID Sex:nil NickName:self.infoTextField.text Image:nil CompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [[ShowMessageTools  sharedInstance]showSimplMessage:@"服务器忙" controller:self];
            }
            else if([result isEqualToString:@"修改失败"])
            {
                [[ShowMessageTools  sharedInstance]showSimplMessage:@"修改失败" controller:self];
            }
            else
            {
                ((LabelCell *)[self.tabView viewWithTag:101]).rightName.text = self.infoTextField.text;
            [[NSUserDefaults standardUserDefaults]setObject:self.infoTextField.text forKey:@"name"];
                [[ShowMessageTools  sharedInstance]showSimplMessage:@"修改成功" controller:self];
            }
        }];
    
    }else
    {
        if ((self.womanBtn.selected == YES && [((LabelCell *)[self.tabView viewWithTag:102]).rightName.text isEqualToString:@"女"]) || (self.manBtn.selected == YES && [((LabelCell *)[self.tabView viewWithTag:102]).rightName.text isEqualToString:@"男"])) {
            self.hiddenView.hidden = YES;
            return;
        }
        if (self.womanBtn.selected == YES) {
            [self changeUserInfoWithUserTel:us UserPhyAdd:KUUID Sex:@"0" NickName:nil Image:nil CompletionHandler:^(NSString *result, NSError *error) {
                if (error) {
                    [[ShowMessageTools  sharedInstance]showSimplMessage:@"服务器忙" controller:self];
                }
                else if([result isEqualToString:@"修改失败"])
                {
                    [[ShowMessageTools  sharedInstance]showSimplMessage:@"修改失败" controller:self];
                }
                else
                {
                    ((LabelCell *)[self.tabView viewWithTag:102]).rightName.text = @"女";
                  [[NSUserDefaults standardUserDefaults]setObject:@"女" forKey:@"1"];
                   [[ShowMessageTools  sharedInstance]showSimplMessage:@"修改成功" controller:self];
                }
            }];
        }
        else
        {
            [self changeUserInfoWithUserTel:us UserPhyAdd:KUUID Sex:@"1" NickName:nil Image:nil CompletionHandler:^(NSString *result, NSError *error) {
                if (error) {
                    [self showmaessage:@"网络错误"];
                }
                else if([result isEqualToString:@"失败"])
                {
                    [self showmaessage:@"修改失败"];
                }
                else
                {
                    ((LabelCell *)[self.tabView viewWithTag:102]).rightName.text = @"男";
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"1"];
                    [self showmaessage:@"修改成功"];
                }
            }];
        
        }
    }
    self.hiddenView.hidden = YES;
    
}
-(void)cancleBtnClick
{
    [self.view endEditing:YES];
    self.hiddenView.hidden = YES;
    self.manBtn.selected = NO;
    self.womanBtn.selected = NO;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 4;
    }else{
        return 1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }else {
        return 50;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
            static NSString *ID = @"cella";
            PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"PersonalCell" owner:nil options:nil].firstObject;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
        }
        
            
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.umodel.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
            self.image = cell.imgView.image;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tag = 100;
            return cell;
        
        
       
    }else if(indexPath.section==1){
            static NSString *IDA = @"cellc";
        LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:IDA];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"LabelCell" owner:nil options:nil].firstObject;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.leftName.text = @"昵称";
                cell.rightName.text = self.umodel.NickName;
                cell.tag = 101;
                self.userName = cell.rightName.text;
            } else if (indexPath.row==1){
                cell.tag = 102;
                cell.leftName.text = @"性别";
                if ([self.userInfo.Sex isEqualToString:@""]) {
                    cell.rightName.text = @"";
                }
                else{
                    NSString*ss = self.umodel.Sex;
                    if ([ss isEqualToString:@"0"]) {
                        cell.rightName.text =@"女";
                    }else
                    {
                        cell.rightName.text =@"男";
                    }
                }
            } else if (indexPath.row==2){
                cell.leftName.text = @"修改密码";
            }
            else if (indexPath.row==3){
                cell.leftName.text = @"我的收货地址";
            }
           
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

        }else {
            //tuichu
                static NSString *IDA = @"celld";
                BtnCell *cell = [tableView dequeueReusableCellWithIdentifier:IDA];
                if (!cell) {
                    cell = [[NSBundle mainBundle]loadNibNamed:@"BtnCell" owner:nil options:nil].lastObject;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
        }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self headImageTap];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row==0) {
            self.isNickNAME = YES;
            self.infoTextField.text = ((LabelCell *)[self.tabView viewWithTag:101]).rightName.text;
            self.hiddenView.hidden = NO;
            [self judgeHiddenView];
        }
        else if (indexPath.row==1)
        {
            self.isNickNAME = NO;
            if ([((LabelCell *)[self.tabView viewWithTag:102]).rightName.text isEqualToString:@"女"]) {
                self.womanBtn.selected = YES;
            }
            else
            {
                self.manBtn.selected = YES;
            }
            self.hiddenView.hidden = NO;
            [self judgeHiddenView];
        }
        else if (indexPath.row == 2)//修改密码
        {
            FindPassWordViewController *wvc = [[FindPassWordViewController alloc]init];
            wvc.isLogin = YES;
            [self.navigationController pushViewController:wvc animated:YES];
        }
        else if (indexPath.row == 3){
            ShoppingAddressController*addressVC = [[ShoppingAddressController alloc]init];
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }
    else
    {
        
            //退出登录
            [self click];
        
    }
    
}
- (void)creatQRView
{
//    _coverView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
//    _coverView.backgroundColor = [UIColor blackColor];
//    [UIView animateWithDuration:1 animations:^{
//        
//        _MyQRView = [[MyQRCodeView alloc]initWithFrame:CGRectMake(20, 40, (KWIDTH -20*2), 500*SHEIGHT_DCALE)];
//        _MyQRView.icon.image = self.image ;
//        _MyQRView.name.text = self.userName;
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(_MyQRView. qrImg.width/2-35, _MyQRView. qrImg.height/2-35, 70, 70)];
////        img.image = [UIImage imageNamed:@"icon.png"];
//        [_MyQRView. qrImg addSubview:img];
//        [self.coverView addSubview:_MyQRView];
//        [self.tabView addSubview:_coverView];
//        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]init];
//        [tap2 addTarget:self action:@selector(tap2:)];
//        
//        [_coverView addGestureRecognizer:tap2];
//    }];
    
    
}
- (void)tap2:(UITapGestureRecognizer*)cc
{
    [self.coverView removeFromSuperview];
    
    
}
-(void)judgeHiddenView
{
    if (self.isNickNAME == YES) {
        self.manBtn.hidden = YES;
        self.womanBtn.hidden = YES;
        self.manLabel.hidden = YES;
        self.womanLabel.hidden = YES;
        self.infoTextField.hidden = NO;
    }
    else
    {
        self.manBtn.hidden = NO;
        self.womanBtn.hidden = NO;
        self.manLabel.hidden = NO;
        self.womanLabel.hidden = NO;
        self.infoTextField.hidden = YES;
    }
}

- (void)headImageTap{
    UIView *view = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    
    [UIActionSheet showInView:view
                    withTitle:nil
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"拍照",@"从手机相册选择"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex)
     {
         NSLog(@"%ld",(long)buttonIndex);
         switch (buttonIndex) {
             case 0:
                 [self takePhoto];
                 break;
             case 1:
                 [self choosePhoto];
                 break;
             case 2:
                 [self Cancel];
                 break;
             default:
                 break;
         }
         
     }];

//    WK(weakSelf)
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakSelf chooseHeadImage:(UIImagePickerControllerSourceTypePhotoLibrary)];
//    }];
//    UIAlertAction *actionCarema = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakSelf chooseHeadImage:(UIImagePickerControllerSourceTypeCamera)];
//    }];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    
//    [alert addAction:actionCancel];
//    [alert addAction:actionCarema];
//    [alert addAction:actionPhoto];
//    
//    [self presentViewController:alert animated:YES completion:nil];
}
- (void)Cancel
{
   // [self.navigationController popViewControllerAnimated:NO];
}
- (void)takePhoto
{
    if (![self hasAuthorizationForMediaType:AVMediaTypeVideo]) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)hasAuthorizationForMediaType:(NSString *)mediaType
{
    BOOL hasAuthorization = YES;
    
    if (IOS7_OR_LATER) {
        hasAuthorization = !([AVCaptureDevice authorizationStatusForMediaType:mediaType] == AVAuthorizationStatusDenied);
    }
    
    if (!hasAuthorization) {
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        
        NSString *message = [NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。", appName];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拍照"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return hasAuthorization;
}
- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)type
{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if (type == UIImagePickerControllerSourceTypeCamera && mediaTypes.count <= 0) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = type;
    picker.wantsFullScreenLayout = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
- (void)choosePhoto
{
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self changeUserInfoWithUserTel:us UserPhyAdd:KUUID Sex:nil NickName:nil Image:image CompletionHandler:^(NSString *result, NSError *error) {
        if (error) {
            [self showmaessage:@"网络错误"];
        }
        else if([result isEqualToString:@"修改失败"])
        {
            [self showmaessage:@"修改失败"];
        }
        else
        {
            ((PersonalCell *)[self. tabView viewWithTag:100]).imgView.image = image;
            [self dismissViewControllerAnimated:YES completion:nil];
            ((PersonalCell *)[self. tabView viewWithTag:100]).imgView.layer. cornerRadius = 30;
            ((PersonalCell *)[self. tabView viewWithTag:100]).imgView.layer. masksToBounds = YES;
            ((PersonalCell *)[self. tabView viewWithTag:100]).imgView.layer. borderWidth = 1;
            ((PersonalCell *)[self. tabView viewWithTag:100]).imgView.layer. borderColor = [UIColor grayColor].CGColor;
//            [self.tabView reloadData];
            [self showmaessage:@"修改成功"];
        }
    }];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    // 保存图片至本地，方法见下文
   // UIImage*images = [self imageYS:image];
    //self.image = [self saveImage:images str:@"tou" path:@"Documents"];
    
    
}
- (UIImage*)imageYS:(UIImage*)image
{
    UIImage *SFimage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(60, 80)];
    
    NSData *Sdata = UIImageJPEGRepresentation(SFimage, 0.5);
    image = [UIImage imageWithData:Sdata];
    return image;
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    
    
    UIGraphicsBeginImageContext(newSize);
    
  
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    
    return newImage;
    
}
- (UIImage*)saveImage:(UIImage*)image str:(NSString*)str path:(NSString*)path
{
    UIImage *newimage  = [[UIImage alloc]init];;
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:str];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:path] stringByAppendingPathComponent:str];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    newimage = savedImage;
    
    return newimage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}
-(void)chooseHeadImage:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //允许编辑图片
    imagePicker.allowsEditing = YES;
    //类型 是 相机  或  相册
    imagePicker.sourceType = type;
    //设置代理
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//加载本地        
- (UIImage*)loadimage:(NSString*)str
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    return image;
}
- (void)click{
    //断开通道<属于客户自己断开需要手动重连登陆操作>
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    
    //
    [[TCPChannel getTcpChannel]disConnect];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HUDView sharedInstanceWithView:self.view]hiddenHUD];

        [self.navigationController popViewControllerAnimated:NO];

    });

}


- (void)showmaessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
}

#pragma mark == cell 将要显示的时候就会调用此方法  使cell分割线右边的缺失部分补齐 ==
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//修改用户信息
-(void)changeUserInfoWithUserTel:(NSString *)userTel UserPhyAdd:(NSString*)UserPhyAdd Sex:(NSString *)sex NickName:(NSString *)nickName Image:(UIImage *)image CompletionHandler:(void (^)(NSString *result, NSError *error))completionHandler
{
    WK(weakSelf);
    NSString *url = [PREURL stringByAppendingString: @"User.ashx?"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Function"] = @"UpdateInfo";
    parameters[@"UserTel"] = userTel;
    parameters[@"UserPhyAdd"] = UserPhyAdd;

    parameters[@"Sex"] = sex;
    parameters[@"NickName"] = nickName;
    //UserPhyAdd
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            UIImage *iconImage = [weakSelf thumbnaiWithImage:image size:CGSizeMake(250, 250)];
            NSData *data = UIImagePNGRepresentation(iconImage);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:data name:@"ImageFile" fileName:@"headerImage.png" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"结果"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];

}
/** 压缩图片的方法 */
- (UIImage*) thumbnaiWithImage:(UIImage*) image size:(CGSize) size
{
    UIImage *newImage = nil;
    if (image) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}
@end
