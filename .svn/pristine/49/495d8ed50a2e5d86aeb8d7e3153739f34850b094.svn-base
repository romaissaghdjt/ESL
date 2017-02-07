//
//  ESLShopCartViewController.m
//  ESL
//
//  Created by eyou on 16/11/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLShopCartViewController.h"
#import "ESLShopCartModel.h"
#import "ESLShopNetworkingManager.h"
#import "ESLFreashInfoCell.h"
#import "ESLShopCartHeaderCell.h"
#import "ESLEditShopCartCell.h"
#import "ConfirmOrderController.h"
#import "ESLSingleProModel.h"

@interface ESLShopCartViewController ()<UITableViewDataSource, UITableViewDelegate, ESLEditShopCartCellDelegate,ESLShopCartHeaderCellDelegate,LoginViewControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *shopCartList;
@property (nonatomic, assign)BOOL isEdit;
@property (nonatomic, assign)BOOL isEditComplete;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)UIView *hiddenView;
@end

@implementation ESLShopCartViewController

-(NSMutableArray *)shopCartList
{
    if (!_shopCartList) {
        _shopCartList = [NSMutableArray array];
    }
    return _shopCartList;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //判断是否登录
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.delegate = self;
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:naVC animated:YES completion:nil];
        return;
    }
    [ESLShopNetworkingManager getShopInfoWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.shopCartList = array.mutableCopy;
            [self judgeAboutShopCart];
            [self.tableView reloadData];
        }
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.allSelectBtn.selected = NO;
    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
        shopCartModel.groupSelected = NO;
        for (ShopCartContentModel *contentModel in shopCartModel.Content) {
            contentModel.singleSelected = NO;
        }
    }
    self.editView.hidden = YES;
    self.isEdit = NO;
    self.rightButton.selected = NO;
    self.totalPrice.text = @"0.00";
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.editView.hidden = YES;
    self.isEditComplete = YES;
    
    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ZXColor(255, 255, 255, 1);
    
    // 右上角编辑
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 40, 40);
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.rightButton addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *batbutton = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = batbutton;
    self.isEdit = NO;
    self.totalPrice.text = @"0.00";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//编辑按钮
-(void)editBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.editView.hidden = !sender.selected;
    self.isEdit = sender.selected;
    if (sender.selected == NO) {
        [self countTotalPrice];
    }
    [self.tableView reloadData];
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT - 64 - 49 - 40) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    self.hiddenView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hiddenView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KWIDTH - 150 * SWIDTH_SCALE)/2.0, (KHEIGHT - 170*SHEIGHT_DCALE)/2.0, 150 * SWIDTH_SCALE, 170*SHEIGHT_DCALE)];
    imageView.image = [UIImage imageNamed:@"空购物车"];
    self.hiddenView.hidden = YES;
    [self.hiddenView addSubview:imageView];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shopCartList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return ((ESLShopCartModel *)self.shopCartList.firstObject).Content.count;
    }
    else
    {
        return ((ESLShopCartModel *)self.shopCartList.lastObject).Content.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLShopCartModel *shopCartModel = nil;
    if (indexPath.section == 0) {
        shopCartModel = self.shopCartList.firstObject;
    }
    else
    {
        shopCartModel = self.shopCartList.lastObject;
    }
    if (self.isEdit == NO) {
        ESLFreashInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLFreashInfoCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLFreashInfoCell" owner:nil options:nil].firstObject;
        }
        [cell setValueWithModel:shopCartModel.Content[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else
    {
        ESLEditShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLEditShopCartCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLEditShopCartCell" owner:nil options:nil].firstObject;
            cell.delegate = self;
        }
        [cell setValueWithModel:shopCartModel.Content[indexPath.row] index:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ESLShopCartModel *shopCartModel = nil;
    if (section == 0) {
        shopCartModel = self.shopCartList.firstObject;
    }
    else
    {
        shopCartModel = self.shopCartList.lastObject;
    }
    ESLShopCartHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLShopCartHeaderCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ESLShopCartHeaderCell" owner:nil options:nil].firstObject;
        cell.delegate = self;
    }
    if ([shopCartModel.Type isEqualToString:@"Feast"]) {
        cell.nameLabel.text = @"乡村喜宴";
        cell.iconImage.image = [UIImage imageNamed:@"乡村喜宴"];

    }
    else
    {
        cell.nameLabel.text = @"甬尚鲜生鲜";
        cell.iconImage.image = [UIImage imageNamed:@"甬尚鲜"];

    }
    cell.selectBtn.selected = shopCartModel.groupSelected;
    cell.indexPathSection = section;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLShopCartModel *shopCartModel = nil;
    if (indexPath.section == 0) {
        shopCartModel = self.shopCartList.firstObject;
    }
    else
    {
        shopCartModel = self.shopCartList.lastObject;
    }
    ShopCartContentModel *contentModel = shopCartModel.Content[indexPath.row];
    contentModel.singleSelected = !contentModel.singleSelected;
    shopCartModel.groupSelected = YES;
    for (ShopCartContentModel *model in shopCartModel.Content) {
        if (model.singleSelected == NO) {
            shopCartModel.groupSelected = NO;
            break;
        }
    }
    [self judgeAboutAllSelect];
    [self countTotalPrice];
    [self.tableView reloadData];
}
//编辑数量
-(void)editCellWithIndex:(NSIndexPath *)indexPath EditType:(EDITTYPE)type Cell:(ESLEditShopCartCell *)cell
{
    if (self.isEditComplete == NO) {
        return;
    }
    self.isEditComplete = NO;
    ESLShopCartModel *shopCartModel = self.shopCartList[indexPath.section];
    ShopCartContentModel *contentModel = shopCartModel.Content[indexPath.row];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"ProductCgy"] = contentModel.ProductCgy;
    dict[@"ID"] = contentModel.ID;
    if (type == SUBEDIT) {
        if ([contentModel.TotalCount isEqualToString:@"1"]) {
            self.isEditComplete = YES;
            return;
        }
        NSString *stringTemp = [NSString stringWithFormat:@"%ld", contentModel.TotalCount.integerValue-1];
        dict[@"Count"] = stringTemp;
        [array addObject:dict];
        [self setNetworkingShopCart:contentModel NSArray:array String:stringTemp];
    }
    else
    {
        if ([contentModel.TotalCount isEqualToString:@"99"]) {
            self.isEditComplete = YES;
            return;
        }
        NSString *stringTemp = [NSString stringWithFormat:@"%ld", contentModel.TotalCount.integerValue+1];
        dict[@"Count"] = stringTemp;
        [array addObject:dict];
        [self setNetworkingShopCart:contentModel NSArray:array String:stringTemp];
    }
}
//购物车请求设置数量
-(void)setNetworkingShopCart:(ShopCartContentModel *)contentModel NSArray:(NSArray *)array String:(NSString *)stringTemp
{
    [ESLShopNetworkingManager postEditShopInfoWithUserTel:us UserPhyAdd:KUUID ProInfo:array CompletionHandler:^(NSString *string, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            if ([string isEqualToString:@"设置成功"]) {
                contentModel.TotalCount = stringTemp;
            }
            else
            {
                [UIViewController showMessage:@"设置失败" ViewController:self];
            }
        }
        self.isEditComplete = YES;
        [self.tableView reloadData];
    }];
}
//结算
- (IBAction)gotoNext:(UIButton *)sender {
    ConfirmOrderController *confirmOC = [[ConfirmOrderController alloc]init];
    NSMutableArray *proArray = [NSMutableArray array];
    NSMutableArray *singleProArray = [NSMutableArray array];
    confirmOC.type = SHOPPING;
    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
        for (ShopCartContentModel *contentModel in shopCartModel.Content) {
            if (contentModel.singleSelected == YES) {
                if ([contentModel.ProductCgy isEqualToString:@"Freash"]) {
                    ESLSingleProModel *model = [[ESLSingleProModel alloc]init];
                    model.ImageUrl = contentModel.ImageUrl;
                    model.mainName = contentModel.Name;
                    model.mainCount = contentModel.TotalCount;
                    model.mainPrice = [NSString stringWithFormat:@"%.02lf", [contentModel.Price doubleValue]];
                    model.proID = contentModel.ID;
                    model.count = @"Freash";
                    NSMutableArray *tempArray = [NSMutableArray array];
                    for (int i = 0; i<contentModel.Gamish.count; i++) {
                        SingleSubModel *singleModel = [[SingleSubModel alloc]init];
                        singleModel.subName = ((ShopCartContentGamishModel *)contentModel.Gamish[i]).Name;
                        [tempArray addObject:singleModel];
                    }
                    model.gamishTotalPrice = contentModel.GamishTotalPrice;
                    model.subArray = tempArray;
                    
                    [singleProArray addObject:model];
                }
                else
                {
                    FeastAllModel *model = [[FeastAllModel alloc]init];
                    model.ImageUrl = contentModel.ImageUrl;
                    model.Name = contentModel.Name;
                    model.Price = contentModel.Price;
                    model.ProductCgy = contentModel.ProductCgy;
                    model.ID = contentModel.ID;
                    model.totalCount = contentModel.TotalCount;
                    [proArray addObject:model];
                }
            }
        }
    }
    confirmOC.feastArray = proArray;
    confirmOC.singleProArray = singleProArray;
    if (confirmOC.feastArray.count == 0 && confirmOC.singleProArray.count == 0) {
        return;
    }
    [self.navigationController pushViewController:confirmOC animated:YES];

}
//全选
- (IBAction)allSelectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
        shopCartModel.groupSelected = sender.selected;
        for (ShopCartContentModel *contentModel in shopCartModel.Content) {
            contentModel.singleSelected = sender.selected;
        }
    }
    [self countTotalPrice];
    [self.tableView reloadData];
}
//删除
- (IBAction)deleteBtnClick:(UIButton *)sender {
    if (self.isEditComplete == NO) {
        return;
    }
    self.isEditComplete = NO;
    NSMutableArray *allArray = [NSMutableArray array];
    NSMutableArray *feastArray = [NSMutableArray array];
    NSMutableArray *freashArray = [NSMutableArray array];
    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
        if ([shopCartModel.Type isEqualToString:@"Feast"]) {
            for (ShopCartContentModel *contentModel in shopCartModel.Content) {
                if (contentModel.singleSelected == YES) {
                    [feastArray addObject:contentModel];
                }
            }
        }
        else
        {
            for (ShopCartContentModel *contentModel in shopCartModel.Content) {
                if (contentModel.singleSelected == YES) {
                    [freashArray addObject:contentModel];
                }
            }
        }
        
    }
    [allArray addObjectsFromArray:feastArray];
    [allArray addObjectsFromArray:freashArray];
    if (allArray.count == 0) {
        self.isEditComplete = YES;
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [ESLShopNetworkingManager postDeleteSomeShopInfoWithUserTel:us UserPhyAdd:KUUID ProInfo:allArray CompletionHandler:^(NSString *string, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"连接失败" ViewController:self];
            }
            else
            {
                if ([string isEqualToString:@"清除成功"]) {
                    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
                        if ([shopCartModel.Type isEqualToString:@"Feast"]) {
                            [shopCartModel.Content removeObjectsInArray:feastArray];
                        }
                        else
                        {
                            [shopCartModel.Content removeObjectsInArray:freashArray];
                        }
                    }
                    NSMutableArray *shopCartArray = [NSMutableArray array];
                    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
                        if(shopCartModel.Content.count == 0)
                        {
                            [shopCartArray addObject:shopCartModel];
                        }
                    }
                    [self.shopCartList removeObjectsInArray:shopCartArray];
                }
                else
                {
                    [UIViewController showMessage:@"清除失败" ViewController:self];
                }
            }
            [self judgeAboutShopCart];
            self.isEditComplete = YES;
            [self.tableView reloadData];
        }];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}
//区头选中点击
-(void)headerCellSelectBtnClick:(NSInteger)indexPathSection Button:(UIButton *)sender
{
    sender.selected = !sender.selected;
    ESLShopCartModel *shopCartModel = self.shopCartList[indexPathSection];
    shopCartModel.groupSelected = sender.selected;
    for (ShopCartContentModel *contentModel in shopCartModel.Content) {
        contentModel.singleSelected = sender.selected;
    }
    [self judgeAboutAllSelect];
    [self countTotalPrice];
    [self.tableView reloadData];
}
//判断是否全部选中
-(void)judgeAboutAllSelect
{
    for (ESLShopCartModel *shopCart in self.shopCartList) {
        self.allSelectBtn.selected = YES;
        if (shopCart.groupSelected == NO) {
            self.allSelectBtn.selected = NO;
            break;
        }
    }
}
//计算总价
-(void)countTotalPrice
{
    float priceNum = 0.00;
    for (ESLShopCartModel *shopCartModel in self.shopCartList) {
        for (ShopCartContentModel *contentModel in shopCartModel.Content) {
            if (contentModel.singleSelected == YES) {
                priceNum = priceNum + contentModel.Price.floatValue*contentModel.TotalCount.integerValue + contentModel.GamishTotalPrice.floatValue;
            }
        }
    }
    self.totalPrice.text = [NSString stringWithFormat:@"%.02f", priceNum];
}

//登陆返回代理
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//判断购物车里是否有商品
-(void)judgeAboutShopCart
{
    if (self.shopCartList.count == 0) {
        self.rightButton.hidden = YES;
        self.hiddenView.hidden = NO;
    }
    else
    {
        self.rightButton.hidden = NO;
        self.hiddenView.hidden = YES;
    }
}

@end
