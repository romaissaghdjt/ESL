//
//  FeastShowController.m
//  YY
//
//  Created by 赵洁 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "FeastShowController.h"
#import "ShowCell.h"
#import "ShowDitallBottmView.h"
#import "FeastDitallController.h"
#import "PrivateMadeController.h"
#import "LoginViewController.h"
@interface FeastShowController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout, ShowDitallBottmViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ShowDitallBottmView *showBottmView;
@property (nonatomic,strong)NSMutableArray*array;
@property (nonatomic, strong)UIView *hiddenView;
@property (nonatomic, strong)UIView *changeView;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation FeastShowController
-(void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
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
    
    self.tabBarController.tabBar.hidden= YES;
    [self creatTablew];
    [self requestimg];
    if ([self.str isEqualToString:@"私人订制"]) {
        //reservationClick
        UIButton *BottmButton =[[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT-50, KWIDTH, 50)];
        BottmButton.backgroundColor = ZXColor(223, 120, 140, 1);
        [self.view addSubview:BottmButton];
        [BottmButton setTitle:@"我要预定" forState:(UIControlStateNormal)];
        [BottmButton addTarget:self action:@selector(reservationClick) forControlEvents:(UIControlEventTouchUpInside)];
     [self request];
    }else{
        [self creatBottmView];
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
- (void)click
{
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)creatBottmView
{
    _showBottmView = [[ShowDitallBottmView alloc]initWithFrame:CGRectMake(0, KHEIGHT-50, KWIDTH, 50)];
    _showBottmView.delgate = self;
    [self.view addSubview:_showBottmView];
    _showBottmView.PriceLable.text = self.price;
    [_showBottmView.YDButton setTitle:@"我要预定" forState:(UIControlStateNormal)];
    _showBottmView.backgroundColor = ZXColor(245,245,245, 1);
    
}
- (void)request
{
    NSString*url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryPersonalTailorPictures"];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*ary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        for (NSDictionary*dic in ary) {
            WeddingModel *model = [[WeddingModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)requestimg
{
    NSString*url = [PREURL stringByAppendingString:[NSString stringWithFormat:@"Other.ashx?Function=HttpQueryWiddingSetMealPictures&WeddingID=%@",self.ID]];
    NSLog(@"%@",url);
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*ary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        for (NSDictionary*dic in ary) {
            WeddingModel *model = [[WeddingModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}

- (void)creatTablew
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, KWIDTH, KHEIGHT) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;//隐藏 cell 的分割线
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.array.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else
    {
        return 200;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else
    {
        return 25;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *ID = @"Cell";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell =[[UITableViewCell alloc]init];
        }
        if ([self.str isEqualToString:@"私人订制"]) {
            cell.textLabel.text =@"价格项目表";
        }else{
          cell.textLabel.text = @"套餐详情";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         return cell;
    }else{
        static NSString *str = @"Scell";
        ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ShowCell" owner:nil options:nil].lastObject;
        }
        cell.displayView.layer.cornerRadius = 10;
        cell.displayView.layer.masksToBounds = YES;
        WeddingModel *model = self.array[indexPath.row];
        [cell.displayView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];

        return cell;
    }
    
   
    
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else
    {
        if ([self.str isEqualToString:@"私人订制"]) {
            return @"客片展示";
        }else{
            return @"图片展示";
  
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.str isEqualToString:@"私人订制"]) {
            PrivateMadeController*projectVC=[[PrivateMadeController alloc]init];
            
            [self.navigationController pushViewController:projectVC animated:YES];
        }else{
            FeastDitallController *FDvc = [[FeastDitallController alloc]init];
            FDvc.ID = self.ID;
            [self.navigationController pushViewController:FDvc animated:YES];
        }
        
    }
}

//我要预约
-(void)reservationClick
{
    if (!self.hiddenView) {
        self.hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        self.hiddenView.backgroundColor = [UIColor blackColor];
        self.hiddenView.alpha = 0.5;
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        
        [currentWindow addSubview:self.hiddenView];
        
        self.changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
        self.changeView.center = self.hiddenView.center;
        [currentWindow addSubview:self.changeView];
        
        self.changeView.backgroundColor = [UIColor whiteColor];
        UILabel *presentationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        presentationLabel.backgroundColor = [UIColor lightGrayColor];
        presentationLabel.textAlignment = NSTextAlignmentCenter;
        presentationLabel.text = @"预约提示";
        presentationLabel.textColor = [UIColor darkGrayColor];
        presentationLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.changeView addSubview:presentationLabel];
        
        UILabel *callLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 300, 30)];
        callLabel.font = [UIFont boldSystemFontOfSize:18];
        callLabel.text = @"请拨打我公司服务热线";
        callLabel.textAlignment = NSTextAlignmentCenter;
        [self.changeView addSubview:callLabel];
        
        UIButton *numBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 300, 30)];
        [numBtn setTitle:@"400-8261-707" forState:UIControlStateNormal];
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [numBtn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        numBtn.enabled = NO;
        [self.changeView addSubview:numBtn];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 150, 100, 40)];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitle:@"拨打" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:ZXColor(83, 162, 38, 1)];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(callTel:) forControlEvents:UIControlEventTouchUpInside];
        [self.changeView addSubview:sureBtn];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 150, 100, 40)];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:ZXColor(83, 162, 38, 1)];
        [cancelBtn addTarget:self action:@selector(callCancel:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.layer.masksToBounds = YES;
        [self.changeView addSubview:cancelBtn];
        
        self.changeView.layer.cornerRadius = 20;
        self.changeView.layer.masksToBounds = YES;
    }
    else
    {
        self.changeView.hidden = NO;
        self.hiddenView.hidden = NO;
    }
}

-(void)callCancel:(UIButton *)sender
{
    self.changeView.hidden = YES;
    self.hiddenView.hidden = YES;
}

-(void)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://400-8216-707"]];
}
@end
