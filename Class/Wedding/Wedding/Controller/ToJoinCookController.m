//
//  ToJoinCookController.m
//  YY
//
//  Created by 赵洁 on 16/7/13.
//  Copyright © 2016年 徐恒. All rights reserved.
//厨师上传


#import "ToJoinCookController.h"
#import "PhotoSController.h"
//#import "XHHomeController.h"
#import "XHTabBarController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "TapRecongnizer.h"
@interface ToJoinCookController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *DJLable;
@property (strong, nonatomic) IBOutlet UILabel *CSLable;
@property (strong, nonatomic) IBOutlet UILabel *JKLable;
@property (strong, nonatomic) IBOutlet UILabel *SFLable;
@property (strong, nonatomic) IBOutlet UILabel *SZLable;
@property (strong, nonatomic) IBOutlet UITextField *IDTextF;
@property (strong, nonatomic) IBOutlet UIView *IDZView;
@property (strong, nonatomic) IBOutlet UIButton *IDZButton;
@property (strong, nonatomic) IBOutlet UIView *IDFView;
@property (strong, nonatomic) IBOutlet UIButton *IDFButton;
@property (strong, nonatomic) IBOutlet UIView *JKView;
@property (strong, nonatomic) IBOutlet UIButton *JKButton;
@property (strong, nonatomic) IBOutlet UIView *CooKView;
@property (strong, nonatomic) IBOutlet UIButton *CookButton;
@property (strong, nonatomic) IBOutlet UIView *DJView;
@property (strong, nonatomic) IBOutlet UIButton *DJButton;
@property (strong, nonatomic) IBOutlet UIButton *TJ;
@property (strong, nonatomic)UIImageView *SZimageView;
@property (strong, nonatomic)UIImageView *SFimageView;
@property (strong, nonatomic)UIImageView *JKimageView;
@property (strong, nonatomic)UIImageView *CSimageView;
@property (strong, nonatomic)UIImageView *DJimageView;
@property(strong , nonatomic)UITextField*textField;
@property (assign, nonatomic)NSInteger tag;
@property(nonatomic)BOOL isFullScreen;
@property (nonatomic)BOOL isFrist;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic)BOOL isFail;
@property(nonatomic, strong)NSMutableArray*StusatArray;
@property (nonatomic, strong)TapRecongnizer *singleTap;
@property (strong ,nonatomic)UIView *coverView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation ToJoinCookController

- (void)viewWillAppear:(BOOL)animated{
    NSFileManager *fm = [NSFileManager defaultManager];

    if (_isFrist == NO) {
        [self delete:@"SZ.png" fm:fm];
        [self delete:@"SF.png" fm:fm];
        [self delete:@"JK.png" fm:fm];
        [self delete:@"DJ" fm:fm];
        [self delete:@"CS.png" fm:fm];
        
       NSLog(@"%@",self.SZimageView.image);
        _isFrist =YES;
        
    }else if(_isFrist == YES){
       
        self.SZimageView.image = [self loadimage:@"SZ.png"];
        
        //self.SZimageView.image = [self imageYS:self.SZimageView.image];
        self.SFimageView.image = [self loadimage:@"SF.png"];
        
       // self.SFimageView.image = [self imageYS:self.SFimageView.image];
        
        self.JKimageView.image = [self loadimage:@"JK.png"];
        //self.JKimageView.image = [self imageYS:self.JKimageView.image];
        
        self.DJimageView.image = [self loadimage:@"DJ.png"];
        //self.DJimageView.image = [self imageYS:self.DJimageView.image];
        
        self.CSimageView.image = [self loadimage:@"CS.png"];
        //self.CSimageView.image = [self imageYS:self.CSimageView.image];
        NSLog(@"111111111%@",self.SZimageView.image);
        NSLog(@"111111111%@",self.SFimageView.image);
        NSLog(@"111111111%@",self.JKimageView.image);
        NSLog(@"111111111%@",self.CSimageView.image);


    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chanage) name:@"chanage" object:nil];
}
- (void)chanage
{
    if (_count == 1) {
        self.SZLable.text = @"选择完成";
        
    }else if (_count == 2)
    {
        
        
        self.SFLable.text = @"选择完成";
        //NSLog(@"----------------------%ld-------------------======",self.StusatArray.count);
    }else if (_count == 3)
    {
        //self.StusatArray = [NSMutableArray arrayWithObjects:@"1",@"3",@"2", nil];
        
        self.JKLable.text = @"选择完成";
        //NSLog(@"----------------------%ld-------------------======",self.StusatArray.count);
    }else if (_count == 4)
    {
        //self.StusatArray = [NSMutableArray arrayWithObjects:@"1",@"3",@"2",@"2", nil];
        self.CSLable.text = @"选择完成";
       // NSLog(@"----------------------%ld-------------------======",self.StusatArray.count);
    }else if(_count == 5)
    {
        self.DJLable.text = @"选择完成";
        self.StusatArray  = [NSMutableArray arrayWithObjects:@"2",@"3",@"3",@"3",@"3", nil];
        NSLog(@"----------------------%ld-------------------======",(unsigned long)self.StusatArray.count);
    }
}
- (void)dealloc
{
    //程序结束删除以前选定的
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PH"];
    NSFileManager *fm = [NSFileManager defaultManager];
    [self delete:@"SZ.png" fm:fm];
    [self delete:@"SF.png" fm:fm];
    [self delete:@"JK.png" fm:fm];
    [self delete:@"DJ" fm:fm];
    [self delete:@"CS.png" fm:fm];

    
}
- (void)delete:(NSString*)str fm:(NSFileManager*)fm
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    [fm removeItemAtPath:fullPath error:nil];
}


- (UIImage*)imageYS:(UIImage*)image
{
    UIImage *SFimage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(60, 80)];
    
    NSData *Sdata = UIImageJPEGRepresentation(SFimage, 0.5);
     image = [UIImage imageWithData:Sdata];
    return image;
}

- (UIImage*)loadimage:(NSString*)str
{
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    return image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"厨师加盟";
    self.TJ.layer.cornerRadius = 6;
    self.TJ.layer.masksToBounds = YES;
    self.isFrist = NO;
    self.count = 0;
    self.isFail = NO;
    for (int i = 0 ; i < 5; i++) {
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*60, 390, 60, 60)];
        imageView.tag = 100+i;
        imageView.backgroundColor = [UIColor clearColor];
        
        imageView.userInteractionEnabled = YES;
        _singleTap = [[TapRecongnizer alloc] initWithTarget:self action:@selector(buttonpress:)];
        _singleTap.tag = imageView.tag;
        [imageView addGestureRecognizer:_singleTap];
        [self.view addSubview:imageView];
        
    }
    self.SZimageView = [self.view viewWithTag:100];
    
    self.SFimageView = [self.view viewWithTag:101];
    
    self.JKimageView = [self.view viewWithTag:102];;
    
    self.CSimageView = [self.view viewWithTag:103];;
    
    self.DJimageView = [self.view viewWithTag:104];
    self.StusatArray = [NSMutableArray array];
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
- (void)click
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#define 身份证正面
- (IBAction)IDZClick:(id)sender {
    [_textField resignFirstResponder];
    [self TapChooseFile:@"SZ.png" path:@"Documents"];

     _count= 1;
   

}
#define 身份证反面
- (IBAction)IDFClick:(id)sender {
    
    [self TapChooseFile:@"SF.png" path:@"Documents"];
    
    
     _count=2;
   

}
#define 健康证
- (IBAction)JKClick:(id)sender {
    [self TapChooseFile:@"JK.png" path:@"Documents"];
    
     _count=3;
    

}
#define 厨师证
- (IBAction)CookClick:(id)sender {
    [self TapChooseFile:@"CS.png" path:@"Documents"];
     _count=4;
    

}
#define 等级正
- (IBAction)DJClick:(id)sender {
    [self TapChooseFile:@"DJ" path:@"Documents"];
    _count=5;
   

}
- (void)request
{
    NSString*str = [WeddURL stringByAppendingString: [NSString stringWithFormat:@"JoinHandler.ashx?Action=CookJoin&CookOrGrp=Cook&ApplyTime=%@&PrincipalName=%@&PrincipalTel=%@&GoodAt=%@&Maximum=%@&ServiceArea=%@&IDNum=%@",self.SetUpDt,self.name,self.tel,self.caiXI,self.power,self.Fanwei,self.IDTextF.text]];//////
    NSString *string = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",str);
    // 其它参数可以不填  再只需要填写文件参数
    [manager POST:string parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"%@",self.SZimageView.image);
        if (self.SZimageView.image == nil||self.SFimageView.image == nil||self.JKimageView.image == nil||self.CSimageView.image == nil) {
            [self showmessage:@"信息不完整"];

            return ;
        }else{
            UIImage *SZimage = [self imageWithImageSimple:self.SZimageView.image scaledToSize:CGSizeMake(150, 150)];
            ///正面
            NSData *data = UIImageJPEGRepresentation(SZimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:data name:@"IDNumPosImg" fileName:@"SZ.png" mimeType:@"image/jpeg"];
            //反面
            UIImage *SFimage = [self imageWithImageSimple:self.SFimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Sdata = UIImageJPEGRepresentation(SFimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Sdata name:@"IDNumBackImg" fileName:@"SF.png" mimeType:@"image/jpeg"];
            //HealthImg
            UIImage *JKimage = [self imageWithImageSimple:self.JKimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Jdata = UIImageJPEGRepresentation(JKimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Jdata name:@"HealthImg" fileName:@"JK.png" mimeType:@"image/jpeg"];
            //CookImg
            UIImage *CSimage = [self imageWithImageSimple:self.CSimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Cdata = UIImageJPEGRepresentation(CSimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Cdata name:@"CookImg" fileName:@"CS.png" mimeType:@"image/jpeg"];
            //等级LevelImg
            UIImage *DJimage = [self imageWithImageSimple:self.DJimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Ddata = UIImageJPEGRepresentation(DJimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Ddata name:@"LevelImg" fileName:@"DJ.png" mimeType:@"image/jpeg"];
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString*str = responseObject[@"提示"];
        
        if ([str isEqualToString:@"你提交的信息不完整"]) {
            
            [self showmessage:@"你提交的信息不完整"];
            
        }else if ([str isEqualToString:@"该手机号已经加盟过了"]){
            [self showmessage:@"该手机号已经加盟过了"];
        }else if ([str isEqualToString:@"服务器忙碌"])
        {
            [self showmessage:@"服务器忙碌"];
        }else if ([str isEqualToString:@"加盟成功"])
        {
            [self showSmessage:@"加盟成功"];
        }else{
            [self showmessage:@"加盟失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)requestT
{
    NSString*str = [WeddURL stringByAppendingString:[NSString stringWithFormat:@"JoinHandler.ashx?Action=CookJoin&CookOrGrp=Grp&Name=%@&Tel=%@&GoodAt=%@&Maximum=%@&ServiceArea=%@&IDNum=%@&ApplyTime=%@",self.name,self.tel,self.caiXI,self.power,self.Fanwei,self.IDTextF.text,self.SetUpDt]];///////
    NSLog(@"%@",str);
    NSString *string = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",str);
    // 其它参数可以不填  再只需要填写文件参数
    [manager POST:string parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (self.SZimageView.image == nil||self.SFimageView.image == nil||self.JKimageView.image == nil||self.CSimageView.image == nil) {
            [self showmessage:@"信息不完整"];
            
            return ;
        }else{
            UIImage *SZimage = [self imageWithImageSimple:self.SZimageView.image scaledToSize:CGSizeMake(150, 150)];
            ///正面
            NSData *data = UIImageJPEGRepresentation(SZimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:data name:@"IDNumPosImg" fileName:@"SZ.png" mimeType:@"image/jpeg"];
            //反面
            UIImage *SFimage = [self imageWithImageSimple:self.SFimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Sdata = UIImageJPEGRepresentation(SFimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Sdata name:@"IDNumBackImg" fileName:@"SF.png" mimeType:@"image/jpeg"];
            //HealthImg
            UIImage *JKimage = [self imageWithImageSimple:self.JKimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Jdata = UIImageJPEGRepresentation(JKimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Jdata name:@"HealthImg" fileName:@"JK.png" mimeType:@"image/jpeg"];
            //CookImg
            UIImage *CSimage = [self imageWithImageSimple:self.CSimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Cdata = UIImageJPEGRepresentation(CSimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Cdata name:@"CookImg" fileName:@"CS.png" mimeType:@"image/jpeg"];
            //等级LevelImg
            UIImage *DJimage = [self imageWithImageSimple:self.DJimageView.image scaledToSize:CGSizeMake(150, 150)];
            
            NSData *Ddata = UIImageJPEGRepresentation(DJimage, 0.1);
            // data就是头像二进制数据 name是服务器上要求的头像参数名 filename 头像在服务器上的存储名  第四个参数图片类型
            [formData appendPartWithFileData:Ddata name:@"LevelImg" fileName:@"DJ.png" mimeType:@"image/jpeg"];
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString*str = responseObject[@"提示"];
        
        if ([str isEqualToString:@"你提交的信息不完整"]) {
            
            [self showmessage:@"你提交的信息不完整"];
            
        }else if ([str isEqualToString:@"该手机号已经加盟过了"]){
            [self showmessage:@"该手机号已经加盟过了"];
        }else if ([str isEqualToString:@"服务器忙碌"])
        {
            [self showmessage:@"服务器忙碌"];
        }else if ([str isEqualToString:@"加盟成功"])
        {
            [self showSmessage:@"加盟成功"];
        }else{
            [self showmessage:@"加盟失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
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
- (void)showmessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alert addAction:cancelAction];
}
- (void)showSmessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
       
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alert addAction:cancelAction];
}
#define 申请
- (IBAction)SQClick:(id)sender {
   // NSLog(@"%@",self.StusatArray.count);
    [self checkIdentityCardNo:_IDTextF.text];

    if (self.isFail == YES) {
        [self showmessage:@"身份证格式不对"];
        self.isFail = NO;
        return;
    }
    if (self.StusatArray.count < 5||self.StusatArray.count < 5) {
        [self showmessage:@"信息不完整"];
        return;
    }
    
    if ([self.IDTextF.text isEqualToString:@""]) {
        [self showmessage:@"信息不完整"];
        return;
    }
   
    if ([self.str isEqualToString:@"个人"]) {
        [self request];
    }else{
        [self requestT];
    }
    
}

#define 点击选择选取照片方式
- (void)TapChooseFile:(NSString*)str path:(NSString*)path
{
    PhotoSController *photoVC = [[PhotoSController alloc]init];
    photoVC.str = str;
    photoVC.path = path;
    
    [self.navigationController pushViewController:photoVC animated:NO];
    
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    
    UIGraphicsEndImageContext();
    
    // Return the new image.
    
    return newImage;
    
}
#pragma UITextFieldDelegate -- 键盘回收
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //实例变量存储当前操作的输入框对象
    
    _textField = textField;
    
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



//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#define 验证身份证
- (BOOL)checkIdentityCardNo:(NSString*)cardNo

{
    
    if (cardNo.length < 18) {
        //[self showmessage:@"证件号输入不够18位"];
        return  NO;
        
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    
    
    int val;
    
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    
    if (!isNum) {
        
        return NO;
    }
    
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
        
    }
    
    
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        
        return YES;
        
    }
    self.isFail = YES;
    return  NO;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.IDTextF == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:18];
            [self showmessage:@"身份证号码只有18位"];
            return NO;
        }
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_textField resignFirstResponder];
    CGFloat offset = self.view.frame.size.height - (_textField.frame.origin.y + _textField.frame.size.height +460);
    if (offset <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }


    
}
#define 查看上传的图片
- (void)buttonpress:(TapRecongnizer*)tap
{
//    if (tap.tag == 100)
//    {
//        [self aa:_SZimageView];
//        
//    }else if (tap.tag == 101)
//    {
//        [self aa:_SFimageView];
//    }else if (tap.tag == 102)
//    {
//        [self aa:_JKimageView];
//    }else if (tap.tag == 103)
//    {
//        [self aa:_CSimageView];
//    }else if (tap.tag == 104)
//    {
//        [self aa:_DJimageView];
//    }
}

- (void)aa:(UIImageView*)imageView
{
    _isFullScreen = !_isFullScreen;
   
    switch (imageView.tag) {
        case 100:
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (_isFullScreen) {
                // 放大尺寸
                
                imageView.frame = CGRectMake(0, 200, KWIDTH, 200);
                self.view.backgroundColor = [UIColor lightGrayColor];
            }
            else {
                // 缩小尺寸
                imageView.frame = CGRectMake(0, 390, 60, 60);
                self.view.backgroundColor = [UIColor whiteColor];
            }
            
            // commit动画
            [UIView commitAnimations];
            break;
        case 101:
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (_isFullScreen) {
                // 放大尺寸
                
                imageView.frame = CGRectMake(0, 200, KWIDTH, 200);
                self.view.backgroundColor = [UIColor lightGrayColor];
            }
            else {
                // 缩小尺寸
                imageView.frame = CGRectMake(70, 390, 60, 60);
                self.view.backgroundColor = [UIColor whiteColor];
            }
            
            // commit动画
            [UIView commitAnimations];
            break;
        case 102:
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (_isFullScreen) {
                // 放大尺寸
                
                imageView.frame = CGRectMake(0, 200, KWIDTH, 200);
                self.view.backgroundColor = [UIColor lightGrayColor];
            }
            else {
                // 缩小尺寸
                imageView.frame = CGRectMake(130, 390, 60, 60);
                self.view.backgroundColor = [UIColor whiteColor];
            }
            
            // commit动画
            [UIView commitAnimations];
            break;
        case 103:
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (_isFullScreen) {
                // 放大尺寸
                
                imageView.frame = CGRectMake(0, 200, KWIDTH, 200);
                self.view.backgroundColor = [UIColor lightGrayColor];
            }
            else {
                // 缩小尺寸
                imageView.frame = CGRectMake(190, 390, 60, 60);
                self.view.backgroundColor = [UIColor whiteColor];
            }
            
            // commit动画
            [UIView commitAnimations];
            break;
        case 104:
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (_isFullScreen) {
                // 放大尺寸
                
                imageView.frame = CGRectMake(0, 200, KWIDTH, 200);
                self.view.backgroundColor = [UIColor lightGrayColor];
            }
            else {
                // 缩小尺寸
                imageView.frame = CGRectMake(250, 390, 60, 60);
                self.view.backgroundColor = [UIColor whiteColor];
            }
            
            // commit动画
            [UIView commitAnimations];
            break;
        default:
            break;
    }
    
    
    
}
- (void)showmFessage:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
}
@end
