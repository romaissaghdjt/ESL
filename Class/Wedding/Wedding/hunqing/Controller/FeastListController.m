//
//  FeastListController.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastListController.h"
#import "showPCell.h"
#import "FeastShowController.h"
#import "WeddingKindModel.h"
#import "LoginViewController.h"
@interface FeastListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray*array;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation FeastListController

- (void)dealloc
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐列表";
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor= ZXColor(223, 120, 140, 1);
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator= NO;
    self.tableView.showsHorizontalScrollIndicator= NO;
   [self request];
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
- (void)request
{
    NSString*url =[WeddURL stringByAppendingString:@"weddingHandler.ashx?Action=GetSetMealList"];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (array.count == 0) {
            return ;
        }
        for (NSDictionary*dic in array) {
            WeddingKindModel*model = [[WeddingKindModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
        [self.tableView reloadData];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(  UITableView *)tableView
{
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"acell";
    showPCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"showPCell" owner:nil options:nil].lastObject;
    }
    cell.backgroundColor = ZXColor(233,230 , 230, 1);
    cell.layer.cornerRadius= 20;
    cell.layer.masksToBounds = YES;
    cell.Pimg.layer.cornerRadius = 10;
    cell.Pimg.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeddingKindModel*model = _array[indexPath.section];
    cell.name.text = model.Name;
    cell.PriceLable.text = [NSString stringWithFormat:@"¥%@", model.Price];
    [cell.Pimg sd_setImageWithURL:[NSURL URLWithString:model.Icon]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeddingKindModel*model = _array[indexPath.section];
    FeastShowController *FsVC = [[FeastShowController alloc]init];
    FsVC.str =  model.Name;
    FsVC.price = model.Price;
    FsVC.ID = model.WeddingItemID;
    FsVC.imgArray = model.ImageUrl;
    [self.navigationController pushViewController:FsVC animated:YES];
}
@end