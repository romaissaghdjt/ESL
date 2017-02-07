//
//  MarriageCarController.m
//  YY
//
//  Created by 徐恒 on 16/5/12.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "MarriageCarController.h"
#import "LoginViewController.h"
#import "Name.h"
#import "LicenseCell.h"
#import "CarCompanyViewController.h"
#import "CarInformationViewController.h"
@interface MarriageCarController () <UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic )UITableView *tableView;

@property (nonatomic, strong)NSArray*ary;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation MarriageCarController
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车队推荐";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    [self request];
    [self createleftTableView];
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
- (void)request
{
   
    NSString *ss = [WeddURL stringByAppendingString:@"WedingCarHandler.ashx?Action=getCarList"];
    NSLog(@"%@", ss);
    [zJRequestManager requestWithUrl:ss parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        self.ary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"%ld", self.ary.count);
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)createleftTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _leftTableView.backgroundColor = [UIColor whiteColor];
    //分割线的颜色
    [_tableView setSeparatorColor:[UIColor grayColor ]];
    //分割线的样式
    //    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    /**隐藏滚动条*/
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 15, 2, 18)];
    line.backgroundColor = [UIColor greenColor];
    [cell addSubview:line];
    if (indexPath.row == 0) {
        cell.textLabel.text = @" 超跑系列";
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @" 豪华系列";
    }else if (indexPath.row == 2)
    {
        cell.textLabel.text = @" 加长系列";
    }else if (indexPath.row == 3)
    {
        cell.textLabel.text = @" 名车系列";
    }else if (indexPath.row == 4)
    {
        cell.textLabel.text = @" 七彩个性";
    }else
    {
        cell.textLabel.text = @" 推荐车队";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarCompanyViewController *CarCVC = [[CarCompanyViewController alloc]init];
    CarCVC.dict = self.ary[indexPath.row];
    [self.navigationController pushViewController:CarCVC animated:YES];
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"推荐车队组合";
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *Dlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KWIDTH, 44)];
    //Dlable.text = @"   推荐车队组合";
    Dlable.font = [UIFont systemFontOfSize:18];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, KWIDTH, 30)];
    lable.text = @"*注: 价格按照里程为准";
    lable.textAlignment = NSTextAlignmentCenter;
//    lable.font = [UIFont systemFontOfSize:12];
    
    lable.textColor = [UIColor redColor];
    [Dlable addSubview:lable];
    return Dlable;
}
#pragma mark = 补齐 cell 右边的缺失部分=
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
