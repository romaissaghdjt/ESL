//
//  MyCollectionController.m
//  ESL
//
//  Created by 徐恒 on 16/9/27.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyCollectionController.h"
#import "ESLMyCollectionCell.h"
#import "MyCollectionModel.h"
#import "ESLFeastDetailViewController.h"
#import "ESLFoodInfoViewController.h"
#import "ShowMessageTools.h"
#import "ESLBagViewController.h"
#define W 0
@interface MyCollectionController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *TableView;
@property (strong, nonatomic)UIButton *headerBtn;//全选按钮
@property (strong, nonatomic)UIButton *bJBtn;//编辑
@property (strong, nonatomic)UILabel *lab;//全选
//@property (strong, nonatomic)UIButton *addBtn;
@property (strong, nonatomic)UIButton *deleteBtn;
@property (strong, nonatomic)UIView *headerView;
@property (strong, nonatomic)NSMutableArray<NSIndexPath *> *selectedIndexPath;//选中数组
@property (strong, nonatomic)NSMutableArray *dataArray;//商品数组
@property (strong, nonatomic)NSMutableArray *checkArr;//勾选数组
@property (strong, nonatomic)ESLFeastDetailViewController *feastDVC;
@property (strong, nonatomic)ESLFoodInfoViewController *foodIFVC;
@property (strong, nonatomic)ESLBagViewController *bagVC;
@property (strong, nonatomic)UIButton *backBtn;//


@end

@implementation MyCollectionController
- (NSMutableArray *)selectedIndexPath {
    if (!_selectedIndexPath) {
        _selectedIndexPath = [NSMutableArray array];
    }
    return _selectedIndexPath;
}
- (NSMutableArray *)checkArr {
    if (!_checkArr) {
        _checkArr = [NSMutableArray array];
    }
    return _checkArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self showBottomView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(22, -22, 20, 0)];
    [button setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Btn setTitle:@"编辑" forState: UIControlStateNormal];
    [Btn setTitle:@"完成" forState: UIControlStateSelected];
    [Btn setTitle:@"编辑" forState: UIControlStateDisabled];
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *editorBtn = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    self.navigationItem.rightBarButtonItem = editorBtn;
    self.bJBtn = Btn;
    self.bJBtn.selected = NO;
    self.isShow = YES;
    [self networkRequestCollectData];
    
    
}
//编辑
-(void)BtnClick:(UIButton *)bt{
    [self.selectedIndexPath removeAllObjects];
    [self.checkArr removeAllObjects];
     self.isShow = bt.selected;
   bt.selected  =! bt.selected;
    if (!self.bJBtn.selected ) {
        _TableView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT+85);
        self.headerBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }else if (self.bJBtn.selected){
        _TableView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT+35);
        self.headerBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
    }
    [self.TableView reloadData];
}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma ==网络请求==
- (void)networkRequestCollectData{
    //http://ess.nbeysx.com/ashx/User.ashx/?Function=HttpQueryCollection&UserTel=18727823918&UserPhyAdd=333333
    //User.ashx/?Function=HttpQueryCollection&UserTel=18727823918&UserPhyAdd=333333
    
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"User.ashx/?Function=HttpQueryCollection&UserTel=%@&UserPhyAdd=%@"],us,KUUID];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"arr===%@\n url===%@",arr,url);
        self.dataArray = [NSMutableArray array];
        
        NSArray *array = [MyCollectionModel mj_objectArrayWithKeyValuesArray:arr];
        
        [self.dataArray addObjectsFromArray:array];
        if (self.dataArray.count == 0) {
            self.headerBtn.hidden = YES;
            self.bJBtn.hidden = YES;
            self.lab.hidden = YES;
            UILabel *showLab = [[UILabel alloc]init];
            showLab.text = @"您还没有收藏的宝贝,赶紧去收藏吧~!";
            showLab.textAlignment = NSTextAlignmentCenter;
            showLab.textColor = [UIColor redColor];
            [self.view addSubview:showLab];
            [showLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(KWIDTH, 50));
                make.top.mas_equalTo(64);
            }];
        }
        NSLog(@"array===%@ self.dataArray==%@",array,self.dataArray);
        [self.TableView reloadData];

    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)showBottomView{
    
    self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT-50, KWIDTH, 50)];
    [self.deleteBtn setTitle:@"删除宝贝" forState: UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = [UIColor redColor];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBtn];
    self.deleteBtn.hidden = YES;

}
//删除
- (void)deleteBtnClick:(UIButton *)sender{
    if (self.headerBtn.selected == NO && self.selectedIndexPath.count==0) {
        [self showFailureMessage:@"没有可删除的宝贝"];
    }
    WK(weakSelf)
    [[ShowMessageTools sharedInstance]showMessage:@"确定要删除吗?" controller: weakSelf block:^{
         [weakSelf RequestDeleteData];
    } canclblock:^{
        return ;
    }];
    [self.TableView reloadData];
}
#pragma mark == 删除 ==
- (void)RequestDeleteData{
    NSLog(@"%@",self.checkArr);
    NSString*ss = @"";
    for (MyCollectionModel*model in self.checkArr) {
        ss=[ss stringByAppendingString:[NSString stringWithFormat:@"%@,",model.ID]];
    }
    if (ss==nil) {
        return;
    }
    NSString*aa = [NSString stringWithFormat:@"[%@]",[ss substringToIndex:ss.length-1]];
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"User.ashx/?Function=HttpRemoveCollections&UserTel=%@&UserPhyAdd=%@&CollectionIDs=%@"],us,KUUID,aa];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dica = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"url==%@\n dic===%@\n Reason===%@",url,dica,dica[@"Reason"]);
        if ([dica[@"提示"] isEqualToString:@"删除成功"]) {
            for (MyCollectionModel*model in self.checkArr ) {
                [self.dataArray removeObject:model];
                [self.selectedIndexPath removeAllObjects];
                if (self.dataArray.count==0) {
                    self.headerBtn.hidden = YES;
                    self.lab.hidden = YES;
                    self.deleteBtn.hidden = YES;
                    self.bJBtn.hidden = YES;
                }
                [self.TableView reloadData];
            }
        }
        if (self.dataArray.count == 0) {
            [self.dataArray removeAllObjects];
            [self.selectedIndexPath removeAllObjects];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failedWithError:^(NSError *connectionError) {
        NSLog(@"失败");
    }];
}
- (void)createTableView{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT+85) style:UITableViewStyleGrouped];
    _TableView.rowHeight = 80;
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.showsVerticalScrollIndicator = NO;
    _TableView.backgroundColor = [UIColor whiteColor];
    _TableView.tableFooterView = [UIView new];
    _TableView.allowsMultipleSelectionDuringEditing = YES;//可多选
    [self.view addSubview:_TableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == self.selectedIndexPath.count && self.selectedIndexPath.count > 0) {
        self.headerBtn.selected = YES;
    }else{
        self.headerBtn.selected = NO;
    }
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    ESLMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
            cell = [[ESLMyCollectionCell alloc] init];
    }
    cell.ChooseBtn.hidden = self.isShow;
    cell.showsReorderControl =YES;
    cell.indexpath = indexPath;
    [cell.ChooseBtn setImage:defaultImg forState:UIControlStateNormal];
    [cell.ChooseBtn setImage:seletedImg forState:UIControlStateSelected];
    
    MyCollectionModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    [_feastDVC.FeastDetailArray addObject:model];
    NSLog(@"%@",model);
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;//可选择的风格
    //cell 选中之后的状态
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kUIColorFromRGB(0xF6F6F6);
    cell.selectedBackgroundView = view;
    
    if (cell.ChooseBtn.hidden ==YES) {
        [cell.Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
        }];
    }else if(cell.ChooseBtn.hidden == NO){
        [cell.ChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.ChooseBtn.mas_right).with.offset(5);
        }];
    }
    [cell.ChooseBtn setSelected:[self.selectedIndexPath containsObject:indexPath]];
    
    WK(weakSelf)
    cell.butBlock = ^(NSIndexPath*indexPath){
        if ([weakSelf.selectedIndexPath containsObject:indexPath]) {
            [weakSelf.selectedIndexPath removeObject:indexPath];
            [weakSelf.checkArr removeObject:model];

        }else{
            [self.selectedIndexPath addObject:indexPath];
            [self.checkArr addObject:model];
            
        }
        [self.TableView reloadData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionModel*model = self.dataArray[indexPath.row];
    ESLBuyModel *buyModel = [[ESLBuyModel alloc]init];
        if ([model.ProductCgy isEqualToString:@"FreashSetMeal"]) {//人气套餐
            _feastDVC = [[ESLFeastDetailViewController alloc]init];
            FeastAllModel *feastAllmodel = [[FeastAllModel alloc]init];
            feastAllmodel.ID = model.ProID;
            _feastDVC.Allmodel = feastAllmodel;
            _feastDVC.ProId = model.ProID;
            [self.navigationController pushViewController:_feastDVC animated:YES];
       }else if ([model.ProductCgy isEqualToString:@"Freash"]){
           _foodIFVC = [[ESLFoodInfoViewController alloc]init];
           _foodIFVC.buyModel = buyModel;
           buyModel.productID = model.ProID;
           [self.navigationController pushViewController:_foodIFVC animated:YES];
       }else if ([model.ProductCgy isEqualToString:@"FreashPackage"]){//大礼包
           _bagVC = [[ESLBagViewController alloc]init];
           _bagVC.ID = model.ProID;
           [self.navigationController pushViewController:_bagVC animated:YES];
       }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.bJBtn.titleLabel.text isEqualToString:@"编辑"]) {
        _lab.frame = CGRectMake(10, 12.5, 40, 25);
    }else
    {
        _lab.frame = CGRectMake(40, 12.5, 40, 25);
    }
    return self.headerView;
}
//区头点击事件
- (void)ChooseClick:(UIButton *)bt{
    bt.selected = !bt.selected;
   // [self.selectedIndexPath removeAllObjects];
    if (bt.selected) {
        for (int row = 0 ; row<self.dataArray.count; row ++) {
            [self.selectedIndexPath addObject:[NSIndexPath indexPathForRow:row inSection:0]];
        }
        //收藏多个单品却不能删除 把下面的 for in 从上面的 for 循环中拿出来就好了
        for (MyCollectionModel*model in self.dataArray) {
            [self.checkArr addObject:model];
        }
    }else{
            [self.selectedIndexPath removeAllObjects];

        [self.checkArr removeAllObjects];
    }
    [self.TableView reloadData];
}
//设置 cell可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bJBtn.selected == YES) {
        return NO;
    }else{
    return YES;
}
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式,按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
            MyCollectionModel *model = self.dataArray[indexPath.section];
                [self.dataArray removeObjectAtIndex:indexPath.row];
                [self.TableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
                NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"User.ashx/?Function=HttpRemoveCollections&UserTel=%@&UserPhyAdd=%@&CollectionIDs=[%@]"],us,KUUID,@[model.ID]];
                NSLog(@"%@",url);
                [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
                    NSDictionary *dica = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
                    NSLog(@"%@",dica[@"Reason"]);
                    for (MyCollectionModel*model in self.checkArr ) {
                        [self.dataArray removeObject:model];
                        [self.selectedIndexPath removeAllObjects];
                    }
                        [self.TableView reloadData];
                } failedWithError:^(NSError *connectionError) {
                    NSLog(@"失败");
                }];
            if (self.dataArray.count==0&&self.selectedIndexPath.count==0) {
                self.headerBtn.hidden = YES;
                self.lab.hidden = YES;
                self.deleteBtn.hidden = YES;
                self.bJBtn.hidden = YES;
                [self.navigationController popViewControllerAnimated:YES];
            }
}
//修改编辑按钮文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 50)];
        UIButton *chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 12.5, 25, 25)];
        [chooseBtn setImage:defaultImg forState:UIControlStateNormal];
        [chooseBtn setImage:seletedImg forState:UIControlStateSelected];
        [chooseBtn addTarget:self action:@selector(ChooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:chooseBtn];
        
        self.headerBtn =chooseBtn;
        self.headerBtn.hidden = self.isShow;
        
        _lab = [[UILabel alloc]init];
        _lab.frame = CGRectMake(10, 12.5, 40, 25);
        _lab.text = @"全选";
        _lab.font = [UIFont systemFontOfSize:15];
        [_headerView addSubview:_lab];
    }
    return _headerView;
}
//删除
- (void)showFailureMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
