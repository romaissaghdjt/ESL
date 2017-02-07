//
//  ESLCookerInfoViewController.m
//  ESL
//
//  Created by eyou on 16/11/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLCookerInfoViewController.h"
#import "ESLCookerNetworkingManager.h"
#import "PersonCommentCell.h"

//@interface ESLCookerInfoViewController ()<UITableViewDelegate, UITableViewDataSource,ESLCookerDescriptionCellDelegate>
@interface ESLCookerInfoViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView*webView;
//@property (nonatomic, strong)UITableView *tableView;
//@property (nonatomic, strong)NSArray *discussArray;
//@property (nonatomic, strong)ESLCookerInfoModel *cookerInfoModel;
//@property (nonatomic, assign)CGSize labelSize1;
//@property (nonatomic, assign)BOOL isBeyond;
//@property (nonatomic, assign)BOOL isClickDown;
//@property (nonatomic, assign)CGSize labelSize2;
@end

@implementation ESLCookerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"厨师";
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT - 64)];
    _webView.delegate = self;
    NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ess8222.nbeysx.com/views/CookArray.aspx"]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 22)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(22, -22, 20, 0)];
    [button setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBtn;
}
- (void)backBtnClick
{
    //判断是web还是系统自己的再做操作
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self creatTabelView];
//    self.isClickDown = NO;
//    self.navigationItem.title = [NSString stringWithFormat:@"%@厨师详情",self.cookerName];
//    [ESLCookerNetworkingManager getCookerInfoWithCookID:self.cookID CookCgy:@"Cook" CompletionHandler:^(ESLCookerInfoModel *cookerInfoModel, NSArray *discussArr, NSError *error) {
//        if (error) {
//            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
//        }
//        else
//        {
//            self.cookerInfoModel = cookerInfoModel;
//            self.discussArray = discussArr;
//            [self.tableView reloadData];
//        }
//        
//    }];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)creatTabelView
//{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2 + self.discussArray.count;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        ESLCookerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLCookerInfoCell"];
//        if (!cell) {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLCookerInfoCell" owner:nil options:nil].firstObject;
//        }
//        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:self.cookerInfoModel.imageUrl] placeholderImage:nil];
//        
//        cell.nameLabel.text = self.cookerInfoModel.name;
////        self.cookerName = cell.nameLabel.text;
//        cell.ageLabel.text = [NSString stringWithFormat:@"%@岁", self.cookerInfoModel.age];
//        cell.cookAgeLabel.text = [NSString stringWithFormat:@"%@年", self.cookerInfoModel.workingTime];
//        if ([self.cookerInfoModel.sex isEqualToString:@"1"]) {
//            cell.sexLabel.text = @"男";
//        }
//        else
//        {
//            cell.sexLabel.text = @"女";
//        }
//        if (self.isRecommend) {
//            cell.recommendImage.image = [UIImage imageNamed:@"甬尚鲜推荐"];
//        }
//        else
//        {
//            cell.recommendImage.hidden = YES;
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    if (indexPath.row == 1) {
//        ESLCookerDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESLCookerDescriptionCell"];
//        if (!cell) {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"ESLCookerDescriptionCell" owner:nil options:nil].firstObject;
//            cell.delegate = self;
//        }
//        cell.descriptionLabel.text = self.cookerInfoModel.resume;
//        cell.serverLimitsLabel.text = self.cookerInfoModel.serviceArea;
//        cell.maxNumLabel.text = [NSString stringWithFormat:@"%@桌", self.cookerInfoModel.maxRecvOrdAbility];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.labelSize1 = [cell.descriptionLabel.text     sizeWithFont:cell.descriptionLabel.font constrainedToSize:CGSizeMake(KWIDTH-16, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//        if (self.isClickDown == NO) {
//            if (self.labelSize1.height * self.labelSize1.width < 36 * (KWIDTH-16)) {
//                cell.downArrow.hidden = YES;
//                cell.lineView.hidden = YES;
//                self.isBeyond = NO;
//                cell.layoutConstraint.constant = 0;
//                cell.descriptionLabel.numberOfLines = 0;
//            }
//            else
//            {
//                cell.downArrow.hidden = NO;
//                cell.lineView.hidden = NO;
//                self.isBeyond = YES;
//                cell.layoutConstraint.constant = 30;
//                cell.descriptionLabel.numberOfLines = 2;
//            }
//
//        }
//        else
//        {
//            self.isBeyond = NO;
//            cell.descriptionLabel.numberOfLines = 0;
//        }
//        return cell;
//    }else
//    {
//        ESLDiscussModel *model = self.discussArray[indexPath.row - 2];
//        PersonCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCommentCell"];
//        if (!cell) {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"PersonCommentCell" owner:nil options:nil].firstObject;
//        }
//        
//        [self creatStarNum:model.starCount Cell:cell];
//        cell.telNum.text = [model.evaluateTel stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
//        cell.dateLabel.text = model.evaluateDt;
//        cell.contentLabel.text = model.remark;
//        self.labelSize2 = [cell.contentLabel.text sizeWithFont:cell.contentLabel.font constrainedToSize:CGSizeMake(KWIDTH-16, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return 130;
//    }
//    else if(indexPath.row == 1)
//    {
//        if (self.isBeyond == NO) {
//            return self.labelSize1.height + 70;
//        }
//        else
//        {
//            return self.labelSize1.height + 100;
//        }
//        
//    }
//    else
//    {
//        return self.labelSize2.height+40;
//    }
//}
//
//-(void)downArrowBtnClick:(ESLCookerDescriptionCell *)cell Button:(UIButton *)sender
//{
//    sender.selected = !sender.selected;
//    self.isClickDown = sender.selected;
//    [self.tableView reloadData];
//}
//
//
//-(void)creatStarNum:(NSString *)string Cell:(PersonCommentCell *)cell
//{
//        switch (string.integerValue) {
//            case 1:
//                cell.twoStar.hidden = YES;
//                cell.threeStar.hidden = YES;
//                cell.fourStar.hidden = YES;
//                cell.fiveStar.hidden = YES;
//                break;
//            case 2:
//                cell.threeStar.hidden = YES;
//                cell.fourStar.hidden = YES;
//                cell.fiveStar.hidden = YES;
//                break;
//            case 3:
//                cell.fourStar.hidden = YES;
//                cell.fiveStar.hidden = YES;
//                break;
//            case 4:
//                cell.fiveStar.hidden = YES;
//                break;
//            case 5:
//                break;
//            default:
//                cell.oneStar.hidden = YES;
//                cell.twoStar.hidden = YES;
//                cell.threeStar.hidden = YES;
//                cell.fourStar.hidden = YES;
//                cell.fiveStar.hidden = YES;
//                break;
//     
//        }
//}
//
@end
