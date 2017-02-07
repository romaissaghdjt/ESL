//
//  PrivateMadeController.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PrivateMadeController.h"
#import "ShowCell.h"
#import "PrtiveTableViewCell.h"
#import "LoginViewController.h"
@interface PrivateMadeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *LeftTableView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation PrivateMadeController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"价格表";
    [self creatLeftTableView];
    [self createRightBtn];
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      //  dispatch_async(dispatch_get_main_queue(), ^{
            [self requestPavSmmery];
       // });
    //});
}
- (void)requestPavSmmery
{
    /**
     */
    NSString*url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryPersonalTailorCont"];
    NSLog(@"%@",url);
    
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        for (NSDictionary*dic in array) {
            _model = [[WeddingModel alloc]init];
            [_model setValuesForKeysWithDictionary:dic];
        }
        [self.LeftTableView reloadData];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
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
//-(void)clickA
//{
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
//}
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
//    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)creatLeftTableView
{
    self.LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:(UITableViewStylePlain)];
    self.LeftTableView.delegate = self;
    self.LeftTableView.dataSource = self;
    self.LeftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.LeftTableView.scrollEnabled = NO;
    self.LeftTableView.backgroundColor = [UIColor clearColor];
    UIImageView*view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    view.image = [UIImage imageNamed:@"jiagebiao.png"];
    [self.view addSubview:view];
    [self.view addSubview:self.LeftTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.model) {
        return 0;
    }else{
        return 1;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"PCell";
    PrtiveTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PrtiveTableViewCell" owner:nil options:nil].firstObject;
    }
    
     cell.lable.text = [self.model.Cont stringByReplacingOccurrencesOfString:@"@n" withString:@"\n"];
    cell.lable.textColor = [UIColor whiteColor];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.lable.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (KHEIGHT <=580) {
      [paragraphStyle setLineSpacing:18];//调整行间距
    }else{
        [paragraphStyle setLineSpacing:30];//调整行间距
    }
    
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.lable.text length])];
    cell.lable.attributedText = attributedString;
    cell.lable.textAlignment = NSTextAlignmentCenter;
    [cell.lable sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    return KHEIGHT;
}
@end
