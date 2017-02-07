//
//  ESLFoodInfoViewController.m
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLFoodInfoViewController.h"
#import "FoodHeaderView.h"
#import "ESLGoodsCell.h"
#import "PackageCollectionViewCell.h"
#import "AllCommentCell.h"
#import "PersonCommentCell.h"
#import "ESLChoseView.h"
#import "ESLBuyNetManager.h"
#import "FreashModel.h"
#import "ESLChooseController.h"
#import "GarnishesModel.h"
#import "ESLSingleProModel.h"
#import "ESLFreashNetworkingManager.h"
#import "ESLFoodDetailsViewController.h"

#define kHeight_SrcollVew 300* SCREEN_DCALE//轮播图高度
typedef enum
{
    PERSONCOMMENTCELL, ALLCOMMENTCELL
}CELLTYPE;
@interface ESLFoodInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, FoodInfoButtonDelegate,LoginViewControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ESLChoseView *choseView;
@property (nonatomic, assign)CGPoint center;
@property (nonatomic, strong)FreashModel *freashModel;
@property (nonatomic, strong)NSArray *garnishesModelArray;
@property (nonatomic, strong)UIImageView *imageHeaderView;
@property (nonatomic, strong)UILabel *buyNum;
@property (nonatomic, strong)UIButton *collectButton;
@property (nonatomic, strong)UIImageView *signImage;
@end

@implementation ESLFoodInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatHeaderView];
    [self creatFooterView];
    [self.view showBusyHUD];
    [ESLBuyNetManager getGetRobberyProductsInfoWithProID:self.buyModel.productID ProModule:@"Freash" CompletionHandler:^(FreashModel *freashModel, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.freashModel = freashModel;
            if ([self.freashModel.BaseData.Robberable isEqualToString:@"是"]) {
                self.isFromRob = YES;
            }
            else
            {
                self.isFromRob = NO;
            }
            if ([self.freashModel.BaseData.IsSeasonal isEqualToString:@"1"]) {
                self.signImage.hidden = NO;
            }
            else
            {
                self.signImage.hidden = YES;
            }
            self.title = freashModel.BaseData.Name;
            [self.imageHeaderView sd_setImageWithURL:[NSURL URLWithString:freashModel.BaseData.ImageUrl] placeholderImage:nil];
            [self.tableView reloadData];
            [ESLBuyNetManager getGarnishesWithProID:self.buyModel.productID CompletionHandler:^(NSArray *array, NSError *error) {
                if (error) {
                    [UIViewController showMessage:@"服务器繁忙" ViewController:self];
                }
                else
                {
                    self.garnishesModelArray = array;
                    self.choseView = [[ESLChoseView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
                    [self.choseView setInfoValueWithArray:array withModel:freashModel IsFromRob:self.isFromRob];
                    self.choseView.delegate = self;
                    //点击黑色透明视图choseView会消失
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissWithHiddenView)];
                    [self.choseView.alphaView addGestureRecognizer:tap];
                    [self.view addSubview:self.choseView];
                }
                [self.view hideBusyHUD];
            }];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //导航条的颜色
   // self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if ([info boolForKey:@"succeed"]) {
        [ESLFreashNetworkingManager getShopCartCountWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"服务器繁忙" ViewController:self];
            }
            else
            {
                if (result.integerValue >= 100) {
                    result = @"99+";
                }
                self.buyNum.text = result;
                if ([result isEqualToString:@""]) {
                    self.buyNum.hidden = YES;
                }
            }
        }];
        [ESLBuyNetManager postIsCollectWithUserTel:us UserPhyAdd:KUUID ProID:self.buyModel.productID ProductCgy:@"Freash" CompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"服务器繁忙" ViewController:self];
            }
            else
            {
                if ([result isEqualToString:@"已收藏"]) {
                    self.collectButton.selected = YES;
                }
            }
        }];
    }
    else
    {
        self.buyNum.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatHeaderView
{
    self.imageHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, kHeight_SrcollVew)];
    self.imageHeaderView.backgroundColor = [UIColor whiteColor];
    self.signImage = [[UIImageView alloc]initWithFrame:CGRectMake(KWIDTH-40-8, 8, 40, 40)];
    self.signImage.image = [UIImage imageNamed:@"slsx"];
    [self.imageHeaderView addSubview:self.signImage];
    self.tableView.tableHeaderView = self.imageHeaderView;
}

-(void)creatFooterView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT - 40, KWIDTH, 40)];
    
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *buyButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [buyButton setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyShopCartClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyButton];
    
    self.buyNum = [[UILabel alloc]initWithFrame:CGRectMake(30, 2, 18, 18)];
    self.buyNum.layer.cornerRadius = 9;
    self.buyNum.layer.masksToBounds = YES;
    self.buyNum.backgroundColor = [UIColor redColor];
    self.buyNum.textAlignment = NSTextAlignmentCenter;
    self.buyNum.font = [UIFont systemFontOfSize:9];
    self.buyNum.textColor = [UIColor whiteColor];
    [view addSubview:self.buyNum];
    
    self.collectButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 5, 30, 30)];
    [self.collectButton setImage:[UIImage imageNamed:@"抢购-收藏未选中"] forState:UIControlStateNormal];
    [self.collectButton setImage:[UIImage imageNamed:@"抢购-收藏选中"] forState:UIControlStateSelected];
    [self.collectButton addTarget:self action:@selector(collectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.collectButton];
    
    UIButton *buyCarButton = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH - 100, 0, 100, 40)];
    buyCarButton.backgroundColor = ZXColor(109, 175, 55, 1);
    [buyCarButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyCarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [buyCarButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyCarButton];
//    //单位
//    UILabel *unitLabel = [[UILabel alloc]init];
//    [view addSubview:unitLabel];
//    unitLabel.text = @"500g";
//    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_top);
//        make.right.equalTo(buyCarButton.mas_left).with.offset(-5);
//        make.bottom.equalTo(view.mas_bottom);
//    }];
//    unitLabel.font = [UIFont systemFontOfSize:14];
//    unitLabel.textColor = ZXColor(218, 70, 92, 1);
//    //斜杠
//    UILabel *spritLabel = [[UILabel alloc]init];
//    [view addSubview:spritLabel];
//    spritLabel.text = @"/";
//    [spritLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_top);
//        make.right.equalTo(unitLabel.mas_left);
//        make.bottom.equalTo(view.mas_bottom);
//    }];
//    spritLabel.font = [UIFont systemFontOfSize:14];
//    spritLabel.textColor = ZXColor(218, 70, 92, 1);
//    //价格
//    UILabel *priceLabel = [[UILabel alloc]init];
//    [view addSubview:priceLabel];
//    priceLabel.text = @"23.80";
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_top);
//        make.right.equalTo(spritLabel.mas_left);
//        make.bottom.equalTo(view.mas_bottom);
//    }];
//    priceLabel.font = [UIFont systemFontOfSize:14];
//    priceLabel.textColor = ZXColor(218, 70, 92, 1);
//    //人民币符号
//    UILabel *signLabel = [[UILabel alloc]init];
//    [view addSubview:signLabel];
//    signLabel.text = @"¥";
//    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_top);
//        make.right.equalTo(priceLabel.mas_left);
//        make.bottom.equalTo(view.mas_bottom);
//    }];
//    signLabel.font = [UIFont systemFontOfSize:14];
//    signLabel.textColor = ZXColor(218, 70, 92, 1);
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    lineView.backgroundColor = ZXColor(233, 233, 233, 1);
    [view addSubview:lineView];
}
#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6+self.freashModel.EvaluateOverView.Details.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ESLGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
        
        if (cell == nil) {
            
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLGoodsCell" owner:nil options:nil].firstObject;
            [cell setValueWithModel:self.freashModel From:self.isFromRob];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row >0 && indexPath.row <= 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, KWIDTH, 1)];
        lineView.backgroundColor = ZXColor(233, 233, 233, 1);
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infocell"];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"请选择 配菜 规格";
            cell.detailTextLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"商品详情";
            cell.detailTextLabel.text = @"商品详情图片较多建议Wifi下浏览";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            cell.textLabel.text = @"为您推荐同类产品";
            lineView.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        [cell.contentView addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 4)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"packageCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"packageCell"];
            UICollectionView *collectView = [self creatCollectView:CGRectMake(0, 0, KWIDTH, 155)];
            [cell.contentView addSubview:collectView];
            [collectView registerNib:[UINib nibWithNibName:@"PackageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PackageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 5)
    {
        AllCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allCommentCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"AllCommentCell" owner:nil options:nil].firstObject;
        }
        cell.personNum.text = self.freashModel.EvaluateOverView.TotalCount;
        [self creatStarNum:self.freashModel.EvaluateOverView.AvStar Cell:cell Type:ALLCOMMENTCELL];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    Details *detailsModel = self.freashModel.EvaluateOverView.Details[indexPath.row - 6];
    PersonCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCommentCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PersonCommentCell" owner:nil options:nil].firstObject;
    }
    [self creatStarNum:self.freashModel.EvaluateOverView.AvStar Cell:cell Type:PERSONCOMMENTCELL];
    cell.telNum.text = [detailsModel.EvaluateTel stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    cell.dateLabel.text = detailsModel.EvaluateDt;
    cell.contentLabel.text = detailsModel.Remark;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        _center = self.tableView.center;
        _center.y -= 64;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration: 0.35 animations: ^{
            self.tableView.center = _center;
            self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
            
            self.choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        } completion: nil];
    }
    else if (indexPath.row == 2) {
        ESLFoodDetailsViewController *fdvc = [[ESLFoodDetailsViewController alloc]init];
        fdvc.proID = self.buyModel.productID;
        fdvc.titleStr = @"商品详情";
        fdvc.typeStr = @"Freash";
        [self.navigationController pushViewController:fdvc animated:YES];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    else if(indexPath.row >0 && indexPath.row <= 3)
    {
        return 44;
    }
    else if (indexPath.row == 4)
    {
        return 155;
    }
    else if (indexPath.row == 5)
    {
        return 44;
    }
    return 66;
}

#pragma mark -- UICollectionViewDelegate
-(UICollectionView *)creatCollectView:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //1.1设置大小
    flowLayout.itemSize=CGSizeMake(100*SWIDTH_SCALE, 150*SHEIGHT_DCALE);
    //1.2设置列间距(注意如果给定距离的间距,无法满足屏幕宽度,设置无效)
    flowLayout.minimumInteritemSpacing=0;
    //1.3设置行间距
    flowLayout.minimumLineSpacing = 20;
    //1.4设置滑动方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //1.7设置内边距
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 20, 0, 20);
    
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    collectView.backgroundColor = [UIColor whiteColor];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.showsHorizontalScrollIndicator = NO;
    return collectView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.freashModel.RecommendFreash.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendFreash *model = self.freashModel.RecommendFreash[indexPath.row];
    PackageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackageCell" forIndexPath:indexPath];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:nil];
    cell.titleName.text = model.Name;
    NSString * tempString = [NSString stringWithFormat:@"¥%.02f/%@",[model.Price floatValue],model.Norm];
    NSInteger len = [model.Norm length]+1;
    NSRange rang = [tempString rangeOfString:@"/"];
    NSInteger loc = rang.location;
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:tempString];
    
    [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(loc, len)];
    
    ((UILabel *)cell.priceLabel).attributedText = mutableString;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view showBusyHUD];
    RecommendFreash *model = self.freashModel.RecommendFreash[indexPath.row];
    [ESLBuyNetManager getGetRobberyProductsInfoWithProID:model.ID ProModule:@"Freash" CompletionHandler:^(FreashModel *freashModel, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.freashModel = freashModel;
            if ([self.freashModel.BaseData.Robberable isEqualToString:@"是"]) {
                self.isFromRob = YES;
            }
            else
            {
                self.isFromRob = NO;
            }
            if ([self.freashModel.BaseData.IsSeasonal isEqualToString:@"1"]) {
                self.signImage.hidden = NO;
            }
            else
            {
                self.signImage.hidden = YES;
            }
            self.title = freashModel.BaseData.Name;
            self.buyModel.productID = model.ID;
            self.buyModel.imageUrl = model.ImageUrl;
            [self.imageHeaderView sd_setImageWithURL:[NSURL URLWithString:freashModel.BaseData.ImageUrl] placeholderImage:nil];
            [ESLBuyNetManager getGarnishesWithProID:model.ID CompletionHandler:^(NSArray *array, NSError *error) {
                if (error) {
                    [UIViewController showMessage:@"服务器繁忙" ViewController:self];
                }
                else
                {
                    self.garnishesModelArray = array;
                    [self.choseView setInfoValueWithArray:array withModel:freashModel IsFromRob:self.isFromRob];
                }
                [self.view hideBusyHUD];
            }];
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self.tableView reloadData];
        }
    }];
    
}

-(void)dismissWithHiddenView
{
    _center.y += 64;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        self.choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        self.tableView.center = _center;
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    } completion: nil];
}
//立即购买
-(void)GotoBuyClick:(NSArray *)array MainCount:(NSString *)mainCount
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    ConfirmOrderController *cfoc = [[ConfirmOrderController alloc]init];
    cfoc.type = self.type;
    ESLSingleProModel *model = [[ESLSingleProModel alloc]init];
    model.mainName = self.freashModel.BaseData.Name;
    model.mainCount = mainCount;
    if (self.isFromRob == YES) {
        model.mainPrice = [NSString stringWithFormat:@"%.02lf", [self.freashModel.RobData doubleValue]];
        model.count = self.buyModel.productCgy;
    }
    else
    {
        model.mainPrice = [NSString stringWithFormat:@"%.02lf", [self.freashModel.BaseData.Price doubleValue]];
        model.count = @"Freash";
    }
    model.proID = self.buyModel.productID;
    
    model.ImageUrl = self.freashModel.BaseData.ImageUrl;
    CGFloat gamishTotalPrice = 0.0;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        SingleSubModel *singleModel = [[SingleSubModel alloc]init];
        if ([((UILabel *)array[i]).text isEqualToString:@"0"]) {
            continue;
        }
        NSString *subCount = ((UILabel *)array[i]).text;
        singleModel.subName = ((GarnishesModel *)self.garnishesModelArray[i]).name;
        singleModel.ID = ((GarnishesModel *)self.garnishesModelArray[i]).ID;
        singleModel.subNum = subCount;
        CGFloat subPrice = [((GarnishesModel *)self.garnishesModelArray[i]).price doubleValue];
        gamishTotalPrice = gamishTotalPrice + [subCount integerValue]*subPrice;
        [tempArray addObject:singleModel];
    }
    model.gamishTotalPrice = [NSString stringWithFormat:@"%.02lf", gamishTotalPrice];
    model.subArray = tempArray;
    NSMutableArray *singleProArray = [NSMutableArray array];
    [singleProArray addObject:model];
    cfoc.singleProArray = singleProArray;
    [self.navigationController pushViewController:cfoc animated:YES];
}
//加入购物车
-(void)addShopCartClick:(NSArray *)array MainCount:(NSString *)mainCount
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if ([((UILabel *)array[i]).text isEqualToString:@"0"]) {
            continue;
        }
        NSString *subCount = ((UILabel *)array[i]).text;
        dict[@"ID"] = ((GarnishesModel *)self.garnishesModelArray[i]).ID;
        dict[@"Count"] = subCount;
        [tempArray addObject:dict];
    }
    [ESLBuyNetManager addFreashToShopCartWithUserTel:us UserPhyAdd:KUUID ProID:self.buyModel.productID GamishInfo:tempArray TotalCount:mainCount ProModule:@"Freash" CompletionHandler:^(NSString *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            [UIViewController showMessage:result ViewController:self];
            if ([result isEqualToString:@"添加成功"]) {
                if (self.buyNum.text.integerValue+mainCount.integerValue >= 100) {
                    self.buyNum.text = @"99+";
                }
                else
                {
                    self.buyNum.text = [NSString stringWithFormat:@"%ld", self.buyNum.text.integerValue+mainCount.integerValue];
                }
                self.buyNum.hidden = NO;
            }
        }
    }];
}

-(void)buyButtonClick:(UIButton *)sender
{
    _center = self.tableView.center;
    _center.y -= 64;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        self.tableView.center = _center;
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        
        self.choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//收藏按钮
-(void)collectButtonClick:(UIButton *)sender
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:navVC animated:NO completion:nil];
    }else{
        if (!sender.selected) {
            sender.selected = YES;
        }
        if (self.isFromRob == YES) {
            [ESLBuyNetManager postCollectWithUserTel:us UserPhyAdd:KUUID ProID:self.buyModel.productID ProductCgy:self.buyModel.productCgy ImageUrl:self.buyModel.imageUrl Remark:self.freashModel.BaseData.Name Price:self.freashModel.RobData CompletionHandler:^(NSString *result, NSError *error) {
                if (error) {
                    [UIViewController showMessage:@"服务器繁忙" ViewController:self];
                }
                else
                {
                    WK(weakSelf)
                    [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
                    [[HUDView sharedInstanceWithView:weakSelf.view]showOnlyTextHUD];
                    [HUDView sharedInstanceWithView:weakSelf.view].text = result;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
                        
                    });
                   // [UIViewController showMessage:result ViewController:self];
                }
            }];
        }
        else{
            [ESLBuyNetManager postCollectWithUserTel:us UserPhyAdd:KUUID ProID:self.buyModel.productID ProductCgy:@"Freash" ImageUrl:self.freashModel.BaseData.ImageUrl Remark:self.freashModel.BaseData.Name Price:self.freashModel.BaseData.Price CompletionHandler:^(NSString *result, NSError *error) {
                if (error) {
                    [UIViewController showMessage:@"服务器繁忙" ViewController:self];
                }
                else
                {
                    WK(weakSelf)
                    [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
                    [[HUDView sharedInstanceWithView:weakSelf.view]showOnlyTextHUD];
                    [HUDView sharedInstanceWithView:weakSelf.view].text = result;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
                        
                    });
                  //  [UIViewController showMessage:result ViewController:self];
                }
            }];
        }
    }
}
//点击购物车
-(void)buyShopCartClick:(UIButton *)sender
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }
    self.tabBarController.selectedIndex=2;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)creatStarNum:(NSString *)string Cell:(UITableViewCell *)cell Type:(CELLTYPE)type
{
    if (type == PERSONCOMMENTCELL) {
        switch (string.integerValue) {
            case 1:
                ((AllCommentCell *)cell).twoStar.hidden = YES;
                ((AllCommentCell *)cell).threeStar.hidden = YES;
                ((AllCommentCell *)cell).fourStar.hidden = YES;
                ((AllCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 2:
                ((AllCommentCell *)cell).threeStar.hidden = YES;
                ((AllCommentCell *)cell).fourStar.hidden = YES;
                ((AllCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 3:
                ((AllCommentCell *)cell).fourStar.hidden = YES;
                ((AllCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 4:
                ((AllCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 5:
                break;
            default:
                ((AllCommentCell *)cell).oneStar.hidden = YES;
                ((AllCommentCell *)cell).twoStar.hidden = YES;
                ((AllCommentCell *)cell).threeStar.hidden = YES;
                ((AllCommentCell *)cell).fourStar.hidden = YES;
                ((AllCommentCell *)cell).fiveStar.hidden = YES;
                break;
        }

    }
    else{
        switch (string.integerValue) {
            case 1:
                ((PersonCommentCell *)cell).twoStar.hidden = YES;
                ((PersonCommentCell *)cell).threeStar.hidden = YES;
                ((PersonCommentCell *)cell).fourStar.hidden = YES;
                ((PersonCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 2:
                ((PersonCommentCell *)cell).threeStar.hidden = YES;
                ((PersonCommentCell *)cell).fourStar.hidden = YES;
                ((PersonCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 3:
                ((PersonCommentCell *)cell).fourStar.hidden = YES;
                ((PersonCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 4:
                ((PersonCommentCell *)cell).fiveStar.hidden = YES;
                break;
            case 5:
                break;
            default:
                ((PersonCommentCell *)cell).oneStar.hidden = YES;
                ((PersonCommentCell *)cell).twoStar.hidden = YES;
                ((PersonCommentCell *)cell).threeStar.hidden = YES;
                ((PersonCommentCell *)cell).fourStar.hidden = YES;
                ((PersonCommentCell *)cell).fiveStar.hidden = YES;
                break;
        }

    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
}
@end
