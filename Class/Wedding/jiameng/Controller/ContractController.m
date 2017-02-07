//
//  ContractController.m
//  YY
//
//  Created by 赵洁 on 16/6/28.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "ContractController.h"
#import "LoginViewController.h"
@interface ContractController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
@property (nonatomic,strong)UIButton *BottomButton;
@property (strong, nonatomic)UIButton *btn;
//@property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation ContractController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titles;
    if ([self.titles isEqualToString:@"加盟合同"]) {
        self.textView.text = @"";
    }else
    {
        [self creatTextView];
        [self creatBottomButton];
    }
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
//       // @property (strong, nonatomic)XHIndetController *XHindetC;
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
- (void)creatTextView
{
    

    self.textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.textView.contentOffset = CGPointMake(0, -300);
    self.textView.editable = NO;
    self.textView.selectable = NO;
    //self.textView.frame = CGRectMake(0, 1000, KHEIGHT, KHEIGHT);
    //self.textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小

    //self.textView.scrollEnabled = YES;//是否可以拖动
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
}
- (void)creatBottomButton
{
    self.BottomButton = [[UIButton alloc]init];
    self.BottomButton.frame = CGRectMake(0, KHEIGHT-40, KWIDTH, 40);
    self.BottomButton.backgroundColor = ZXColor(95, 176, 56, 1);
    [self.BottomButton setTitle:@"同意" forState:(UIControlStateNormal)];
    [self.BottomButton addTarget:self action:@selector(BottomButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.BottomButton];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)BottomButton:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TY" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
