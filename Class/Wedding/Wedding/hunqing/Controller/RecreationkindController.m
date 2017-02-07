//
//  RecreationkindController.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "RecreationkindController.h"
#import "RecreationCell.h"
#import "WeddingKindModel.h"
#import "ProjectPriceController.h"
#import "LoginViewController.h"
@interface RecreationkindController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray*array;
@property (nonatomic,strong)NSMutableArray*imgAry;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation RecreationkindController
- (NSMutableArray *)imgAry
{
    if (!_imgAry) {
        _imgAry = [NSMutableArray array];
    }
    return _imgAry;
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
    self.title = self.str;
    [self creatTableView];
    if ([self.str isEqualToString:@"歌舞演艺"]) {
        [self request];
 
    }else{
      [self request1];
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
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}
- (void)request
{
    [zJRequestManager requestWithUrl:[WeddURL stringByAppendingString:@"weddingHandler.ashx?Action=SongAndDance"] parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*ARY = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        for (NSDictionary*dic in ARY) {
            WeddingKindModel *model = [[WeddingKindModel alloc]init];
           
            [model setValuesForKeysWithDictionary:dic];
            // NSLog(@"%@",model.ImageUrl);
            [self.array addObject:model];
        }
    
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)request1
{
    [zJRequestManager requestWithUrl:[WeddURL stringByAppendingString:@"weddingHandler.ashx?Action=Ceremony"] parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*ARY = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        for (NSDictionary*dic in ARY) {
            WeddingKindModel *model = [[WeddingKindModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
           
            [self.array addObject:model];
        }
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.str isEqualToString:@"歌舞演艺"]) {
        return _array.count;
    }else{
        return _array.count;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Rcell";
    RecreationCell *cell  = [tableView dequeueReusableCellWithIdentifier:str];
    tableView.separatorInset = UIEdgeInsetsMake(0, 70, 1, 1);

    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecreationCell" owner:nil options:nil].lastObject;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    WeddingKindModel *model = _array[indexPath.row];
    cell.name.text =model.Name;
    cell.img.layer.cornerRadius = cell.img.width/2;
    cell.img.layer.masksToBounds = YES;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.Icon]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectPriceController*pP = [[ProjectPriceController alloc]init];
    RecreationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    pP.str = cell.name.text;
    WeddingKindModel *model = _array[indexPath.row];
    pP.ary = model.ImageUrl;
    pP.price = model.Price;
    [self.navigationController pushViewController:pP animated:YES];
}
@end
