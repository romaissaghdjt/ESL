//
//  ESLBagViewController.m
//  ESL
//
//  Created by eyou on 17/1/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLBagViewController.h"
#import "ESLBuyNetManager.h"
#import "ESLBagHeaderCell.h"
#import "AllCommentCell.h"
#import "PersonCommentCell.h"
#import "ESLBuyNetManager.h"
#import "ESLFoodDetailsViewController.h"


#define kHeight_SrcollVew 300* SCREEN_DCALE//轮播图高度

typedef enum
{
    PERSONCOMMENTCELL, ALLCOMMENTCELL
}CELLTYPE;

@interface ESLBagViewController ()<UITableViewDelegate, UITableViewDataSource,LoginViewControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *imageHeaderView;
@property (nonatomic, strong)UIButton *collectButton;
@property (nonatomic, strong)FreashModel *freashModel;
@end

@implementation ESLBagViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if ([info boolForKey:@"succeed"]) {
        [ESLBuyNetManager postIsCollectWithUserTel:us UserPhyAdd:KUUID ProID:self.ID ProductCgy:@"FreashPackage" CompletionHandler:^(NSString *result, NSError *error) {
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view showBusyHUD];
    [self creatTableView];
    [self creatHeaderView];
    [self creatFooterView];
    [self creatBackView];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [ESLBuyNetManager getGetRobberyProductsInfoWithProID:self.ID ProModule:@"FreashPackage" CompletionHandler:^(FreashModel *freashModel, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.title = freashModel.BaseData.Name;
            self.freashModel = freashModel;
            [self.imageHeaderView sd_setImageWithURL:[NSURL URLWithString:freashModel.BaseData.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
            [self.view hideBusyHUD];
            [self.tableView reloadData];
        }
        
    }];
}

-(void)creatBackView
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *carBtn = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH-50, 30, 40, 40)];
    [carBtn setImage:[UIImage imageNamed:@"carBtn"] forState:UIControlStateNormal];
    [carBtn addTarget:self action:@selector(carClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carBtn];
}

-(void)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)carClick:(UIButton *)sender
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)creatHeaderView
{
    self.imageHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, kHeight_SrcollVew)];
    self.imageHeaderView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.imageHeaderView;
}

-(void)creatFooterView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT - 40, KWIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.collectButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [self.collectButton setImage:[UIImage imageNamed:@"wsc"] forState:UIControlStateNormal];
    [self.collectButton setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateSelected];
    self.collectButton.contentMode = UIViewContentModeCenter;
    [self.collectButton addTarget:self action:@selector(collectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.collectButton];
    //加入购物车
    UIButton *joinCarButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, (KWIDTH-40)/2.0, 40)];
    joinCarButton.backgroundColor = ZXColor(109, 175, 55, 1);
    [joinCarButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    joinCarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [joinCarButton addTarget:self action:@selector(joinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:joinCarButton];
    
    UIButton *buyCarButton = [[UIButton alloc]initWithFrame:CGRectMake(40+(KWIDTH-40)/2.0, 0, (KWIDTH-40)/2.0, 40)];
    buyCarButton.backgroundColor = ZXColor(216, 137, 33, 1);
    [buyCarButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyCarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [buyCarButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyCarButton];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    lineView.backgroundColor = ZXColor(233, 233, 233, 1);
    [view addSubview:lineView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3+self.freashModel.EvaluateOverView.Details.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ESLBagHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bagHeaderCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLBagHeaderCell" owner:nil options:nil].firstObject;
        }
        [cell reloadCellInfo:self.freashModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, KWIDTH, 1)];
        lineView.backgroundColor = ZXColor(233, 233, 233, 1);
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infocell"];
        }
   
        cell.textLabel.text = @"礼品详情";
        cell.detailTextLabel.text = @"商品详情图片较多建议Wifi下浏览";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.row == 2)
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
    Details *detailsModel = self.freashModel.EvaluateOverView.Details[indexPath.row - 3];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        ESLFoodDetailsViewController *fdvc = [[ESLFoodDetailsViewController alloc]init];
        fdvc.proID = self.ID;
        fdvc.titleStr = @"商品详情";
        fdvc.typeStr = @"FreashPackage";
        [self.navigationController pushViewController:fdvc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 180;
    }
    else if(indexPath.row >0 && indexPath.row <= 2)
    {
        return 44;
    }
    else if (indexPath.row == 4)
    {
        return 44;
    }
    return 66;
}

//立即购买
-(void)buyButtonClick:(UIButton *)sender
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
    cfoc.type = BAG;
    FeastAllModel *model = [[FeastAllModel alloc]init];
    model.ID = self.ID;
    model.Name = self.freashModel.BaseData.Name;
    model.Price = [NSString stringWithFormat:@"%.02lf",[self.freashModel.BaseData.Price doubleValue]];
    model.ImageUrl = self.freashModel.BaseData.ImageUrl;
    model.totalCount = @"1";
    NSMutableArray *feastArray = [NSMutableArray array];
    [feastArray addObject:model];
    cfoc.feastArray = feastArray;
    [self.navigationController pushViewController:cfoc animated:YES];
}
//加入购物车
-(void)joinButtonClick:(UIButton *)sender
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }
    [ESLBuyNetManager addFreashToShopCartWithUserTel:us UserPhyAdd:KUUID ProID:self.ID GamishInfo:@[] TotalCount:@"1" ProModule:@"FreashPackage" CompletionHandler:^(NSString *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            [self.view showWarning:result];
        }
    }];
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
       
        [ESLBuyNetManager postCollectWithUserTel:us UserPhyAdd:KUUID ProID:self.ID ProductCgy:@"FreashPackage" ImageUrl:self.freashModel.BaseData.ImageUrl Remark:self.freashModel.BaseData.Name Price:self.freashModel.BaseData.Price CompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"服务器繁忙" ViewController:self];
            }
            else
            {
//                WK(weakSelf)
//                [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
//                [[HUDView sharedInstanceWithView:weakSelf.view]showOnlyTextHUD];
//                [HUDView sharedInstanceWithView:weakSelf.view].text = result;
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
                
//                });
                [self.view showWarning:@"收藏成功"];
            }
        }];
        
    }
}


-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
