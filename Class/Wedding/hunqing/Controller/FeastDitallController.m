//
//  FeastDitallController.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastDitallController.h"
#import "FeastDitallCell.h"
#import "WeddingDtialModel.h"
#import "LoginViewController.h"
@interface FeastDitallController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView*tableView;
@property (nonatomic, strong)NSMutableArray*dataArray;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation FeastDitallController
-(void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"套餐详情";
    [self creatTableView];
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
//    _Menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    messageC.deleagte = self;
//    _Menu.contentController = messageC;
//    [_Menu showFrom:self.bb];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_Menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else if (indexPath.row==1){
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
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
//    }
}
//- (void)click
//{
////    [self dismissViewControllerAnimated:NO completion:nil];
//}
- (void)request
{
    NSString*str =[PREURL stringByAppendingString:[NSString stringWithFormat:@"Other.ashx?Function=HttpQueryWiddingSetMealDetails&WeddingID=%@",self.ID]];
    NSLog(@"%@",str);
    [zJRequestManager requestWithUrl:str parmDic:nil method:GET1 succeedWithData:^(NSData *data) {

        NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (ary.count == 0) {
            return ;
        }else{
            for (NSDictionary*dic in ary) {
                WeddingDtialModel *model = [[WeddingDtialModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"fDcell";
    FeastDitallCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDitallCell" owner:nil options:nil].lastObject;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.tag = 10+indexPath.row;
    WeddingDtialModel*model = _dataArray[indexPath.section];
    cell.Title.text = model.ContName;
    cell.summery.text =[model.Cont stringByReplacingOccurrencesOfString:@"@n" withString:@"\n"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.summery.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.summery.text length])];
    cell.summery.attributedText = attributedString;
    cell.summery.textAlignment = NSTextAlignmentLeft;
    [cell.summery sizeToFit];

    return cell;
}
@end
