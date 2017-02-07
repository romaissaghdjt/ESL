//
//  ESLSearchViewController.m
//  ESL
//
//  Created by 徐恒 on 2016/12/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLSearchViewController.h"
#import "ESLSearchViewCell.h"
#import "ESLSearchModel.h"
#import "ESLFeastDetailViewController.h"
#import "ESLFoodInfoViewController.h"
#import "ESLBuyModel.h"
#import "FeastAllModel.h"
#import "FeastDtiallController.h"
#import "StartFeastModel.h"
#import "ESLTopSearchCell.h"
#import "ESLTopSearchModel.h"
@interface ESLSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic)UITableView *Tableview;
@property (strong, nonatomic)UITableView *towTableView;
@property ( nonatomic)BOOL showsSearchResultsButton;
@property (strong, nonatomic)UITextField *searchBar;
@property (strong, nonatomic)NSMutableArray *arr;//搜索数组
@property (strong, nonatomic)NSMutableArray *array;//热门搜索数组
@property (strong, nonatomic)ESLFeastDetailViewController *feastDVC;
@property (strong, nonatomic)ESLFoodInfoViewController *foodIFVC;
@property (strong, nonatomic)FeastDtiallController *feastDC;
@property (strong, nonatomic) UILabel *lab;//热门搜索
@end

@implementation ESLSearchViewController
- (void)viewWillAppear:(BOOL)animated{
    if (_isYY == YES) {
        [_searchBar becomeFirstResponder];//成为第一响应者
        self.towTableView.hidden = NO;
        self.Tableview.hidden = YES;
    }else{
        [_searchBar resignFirstResponder];
//        if (self.searchBar.text == nil) {
//            self.towTableView.hidden = NO;
//            self.Tableview.hidden = YES;
//        }
        self.towTableView.hidden = YES;
        self.Tableview.hidden = NO;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(20, -22, 20, 0)];
        [button setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backBtn;
    
    [self createTableView];
    [self createTowTableView];
    [self createTowTableViewRequest];

    // 创建搜索框对象
    _searchBar = [[UITextField alloc] init];
    if (SW==320) {
        _searchBar.width = 260;
    }else if (SW==375){
        _searchBar.width = 315;
    }else if (SW>375){
        _searchBar.width = 354;
    }
    _searchBar.height = 25;
    _searchBar.delegate = self;
    _searchBar.font = [UIFont systemFontOfSize:15];
    _searchBar.tintColor = [UIColor blackColor];
    _searchBar.placeholder = @"请搜索你中意的商品";
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    
    //设置左边的放大镜图标 通过init来创建初始化绝大部分控件，控件都是没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.width = 30;
    searchIcon.height = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    _searchBar.leftView = searchIcon;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = _searchBar;
    
    
}
- (void)backBtnClick{
        [self.searchBar resignFirstResponder];
        [self.navigationController popViewControllerAnimated:NO];
}
//tableView的请求
- (void)createRequest:(NSString *)str{
    [self.arr removeAllObjects];
    //http://localhost:4850/ashx/Shopping.ashx?Function=Search
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Function=Search&KeyWords=%@"],str];
    NSLog(@"%@",str);
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (arr.count==0) {
            self.towTableView.hidden = NO;
            self.Tableview.hidden = YES;
            return ;
        }else{
            
            [[HUDView sharedInstanceWithView:self.view]showHUD];
        for (NSDictionary *dic in arr) {
            ESLSearchModel *model = [[ESLSearchModel alloc]init];
            model.Price = dic[@"Price"];
            model.ImageUrl = dic[@"ImageUrl"];
            model.Name = dic[@"Name"];
            model.ProductID = dic[@"ProductID"];
            model.Remark = dic[@"Remark"];
            model.ProductCgy = dic[@"ProductCgy"];
            [self.arr addObject:model];
        }
            NSLog(@"%@",arr);
      }
        [[HUDView sharedInstanceWithView:self.view]hiddenHUD];
        [_Tableview reloadData];
    } failedWithError:^(NSError *Error) {
        
    }];
}
//towTableView 的请求
//http://ess.nbeysx.com/ashx/Shopping.ashx?Function=HotKeys

- (void)createTowTableViewRequest{
  NSString *url = [PREURL stringByAppendingString:@"Shopping.ashx?Function=HotKeys"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%ld",arr.count);
        if (arr.count==0) {
            self.towTableView.hidden = NO;
            self.Tableview.hidden = YES;
        }else{
            self.array = [[NSMutableArray alloc]init];
            [self.array addObjectsFromArray:arr];
        }
    } failedWithError:^(NSError *Error) {
        
    }];

}
- (void)createTableView{
    _Tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _Tableview.delegate = self;
    _Tableview.dataSource = self;
    _Tableview.rowHeight = 100;
    _Tableview.showsVerticalScrollIndicator = NO;
    _Tableview.tableFooterView = [UIView new];
    [self.view addSubview:_Tableview];
}
- (void)createTowTableView{
    _towTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _towTableView.delegate = self;
    _towTableView.dataSource = self;
    _towTableView.rowHeight = 116;
    _towTableView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _towTableView.tableFooterView = [UIView new];
    [self.view addSubview:_towTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.Tableview]) {
        return self.arr.count;
    }else{
        return 1;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.Tableview]) {
        static NSString *ID = @"cell";
        ESLSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLSearchViewCell" owner:nil options:nil].firstObject;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (self.arr.count == 0) {
            return cell;
        }else{
            cell.ESLSearchModel = self.arr[indexPath.row];
            return cell;
        }
    }else if ([tableView isEqual:self.towTableView]){
        static NSString *AA = @"ESLTopSearchCell";
        ESLTopSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:AA];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLTopSearchCell" owner:nil options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.oneBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.oneBtn.tag = 1000+0;
        [cell.towBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.towBtn.tag = 1000+1;
        [cell.threeBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.threeBtn.tag = 1000+2;
        [cell.fourBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.fourBtn.tag = 1000+3;
        [cell.fiveBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.fiveBtn.tag = 1000+4;
        [cell.sixBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.sixBtn.tag = 1000+5;
        return cell;
    }
    return nil;
}

#define   oneBtn 白鲳鱼 ====
- (void)BtnClick:(UIButton *)sender{
    self.searchBar.text = self.array[sender.tag-1000];
    [self createRequest:self.array[sender.tag-1000]];
    [self.searchBar resignFirstResponder];
    self.towTableView.hidden = YES;
    self.Tableview.hidden = NO;
    NSLog(@"%@",self.array[sender.tag-1000]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.towTableView]) {
        return 30;
    }else{
        return 0;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.towTableView]) {
        NSString *str = @"  热门搜索";
        UILabel *lab = [[UILabel alloc]init];
        lab.text = str;
        lab.font = [UIFont systemFontOfSize:15];
        self.towTableView.tableHeaderView = lab;
        lab.backgroundColor = ZXColor(246, 246, 246, 1);
        self.lab = lab;
    }
    return self.lab;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (self.searchBar.text.length == 0) {
////        [self towTableView];
//        self.towTableView.hidden = NO;
//        self.Tableview.hidden = YES;
//    }
//    else{
//    [self createTableView];
//    //字符转换成字符串
//    NSString *ss = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    [self createRequest:ss];
//    }
    
//    return YES;
//    
//}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.towTableView.hidden = NO;
    self.Tableview.hidden = YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.towTableView.hidden = YES;
    self.Tableview.hidden = NO;
    [self createRequest:textField.text ];
    //隐藏键盘
    [self.searchBar resignFirstResponder];

    return YES;
}
- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [[NSMutableArray alloc]init];
    }
    return _arr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.Tableview deselectRowAtIndexPath:[self.Tableview indexPathForSelectedRow] animated:YES];//取消cell 的选中状态
  [self.searchBar resignFirstResponder];
    if ([tableView isEqual:self.Tableview]) {
        _isYY = NO;
        ESLSearchModel *model = self.arr[indexPath.row];
        if ([model.ProductCgy isEqualToString:@"FreashSetMeal"]) {//人气套餐
            _feastDVC = [[ESLFeastDetailViewController alloc]init];
            FeastAllModel *feastAllmodel = [[FeastAllModel alloc]init];
            feastAllmodel.ID = model.ProductID;
            _feastDVC.Allmodel = feastAllmodel;
            _feastDVC.ProId = model.ProductID;
            [self.navigationController pushViewController:_feastDVC animated:YES];
        }
        else if ([model.ProductCgy isEqualToString:@"Freash"]){//单品
            _foodIFVC = [[ESLFoodInfoViewController alloc]init];
            ESLBuyModel *buyModel = [[ESLBuyModel alloc]init];
            _foodIFVC.buyModel = buyModel;
            buyModel.productID = model.ProductID;
            [self.navigationController pushViewController:_foodIFVC animated:YES];
        }
        else if ([model.ProductCgy isEqualToString:@"FeastSetMeal"]){//喜宴套餐
            _feastDC = [[FeastDtiallController alloc]init];
            StartFeastModel*start = [[StartFeastModel alloc]init];
            _feastDC.model = start;
            start.SetMealID = model.ProductID;
            [self.navigationController pushViewController:_feastDC animated:YES];
        }
    }
}
//补齐 cell 右边缺失的线条
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
//可以用来设置光标与占位的间距 控制placeHolder的位置，左右缩20
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 20, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width +10, bounds.size.height);//更好理解些
//    return inset;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
