//
//  ESLFeastDetailViewController.m
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLHelpDetailViewController.h"
#import "BottmView.h"
#import "ESLTuiJianController.h"
#import "FasetShowCell.h"
#import "recFasetCell.h"
#import "FeastSubModel.h"
#import "FeastAllViewModel.h"
#import "ConfirmOrderController.h"
@interface ESLHelpDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *TopBackView;
@property (weak, nonatomic) IBOutlet UIView *TowView;
@property (weak, nonatomic) IBOutlet UIView *ThreeView;

@property (strong, nonatomic) IBOutlet UIImageView *FeastImg;
@property (strong, nonatomic) IBOutlet UILabel *TuiJLable;
@property (strong, nonatomic) IBOutlet UILabel *FeastName;
@property (strong, nonatomic) IBOutlet UILabel *FeastPrice;
@property (strong, nonatomic) IBOutlet UIImageView *FeastStart;
@property (strong, nonatomic) IBOutlet UILabel *FeastMonthSaclV;//月销量
@property (strong, nonatomic) IBOutlet UILabel *PJLable;
@property (strong, nonatomic) IBOutlet UILabel *FeastPJSummery;
@property (weak, nonatomic) IBOutlet UIButton *Collection;//收藏
//======================================
@property (strong, nonatomic) IBOutlet UILabel *FeastNoticeLable;
@property (strong, nonatomic) IBOutlet UILabel *FeastNoticeSummery;
@property (strong, nonatomic) IBOutlet UIButton *FeastNoticeButton;
//==================================================
@property (strong, nonatomic) IBOutlet UIButton *SummeryButton;

@property (strong, nonatomic) IBOutlet UIView *AnmationView;
@property (strong, nonatomic) IBOutlet UIButton *EvaluateButton;

@property (nonatomic,strong)BottmView*bottmView;
//===================================================
@property (strong, nonatomic) IBOutlet UIView *ChangeView;
@property (strong, nonatomic) IBOutlet UIView *ChangeSubBackView;
@property (strong, nonatomic) IBOutlet UIButton *MainFoodSumButton;
@property (strong, nonatomic) IBOutlet UIButton *MatchFeedChooseBuuton;
//====================================================
@property (strong, nonatomic) IBOutlet UIButton *Pei_button;
@property (assign, nonatomic)BOOL isChang;
@property (strong, nonatomic)ESLTuiJianController *cc;
@property (strong, nonatomic)UITableView*MainFeastTableView;
@property (strong, nonatomic)UITableView*MatchFeedTableView;
@property (strong, nonatomic)NSMutableArray*BntArray;
@property (nonatomic,strong)FeastAllViewModel*ViewModel;

@property (strong,nonatomic)NSMutableArray*MianArray;//主
@property (strong,nonatomic)NSMutableArray*SubIDArray;//配菜
@end

@implementation ESLHelpDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        [self.Collection setImage:[UIImage imageNamed:@"未选中收藏"] forState:UIControlStateNormal];

        return;
    }
    
    if (self.ProId) {
        [self.Collection setImage:[UIImage imageNamed:@"选中收藏"] forState:UIControlStateNormal];
    }
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.Allmodel.Name;
    self.FeastName.text = _Allmodel.Name;
    [self.FeastImg sd_setImageWithURL:[NSURL URLWithString:_Allmodel.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img"]];
    self.FeastPrice.text = [NSString stringWithFormat:@"¥%d",_Allmodel.Price.intValue];
    self.tabBarController.tabBar.hidden = YES;
    [self removNavigationBarBottomBlackLine];
    [self setUpSubView];
    [self CreatBottmView];
    STScrollBar *bar = [[STScrollBar alloc]initWithFrame:CGRectMake(self.FeastNoticeLable.right+10, self.FeastNoticeLable.top, self.TowView.width-self.FeastNoticeLable.width+20, self.FeastNoticeLable.height)];
    bar.colorText = [UIColor whiteColor];
    
    bar.text = @"温馨提示:为了您能尽快享受甬尚鲜美食,建议提前半个月预定.                   ";
    [self.TowView addSubview:bar];
    self.isChang = NO;
    _BntArray = [NSMutableArray array];
    _SubIDArray = [NSMutableArray array];
    self.FeastName.width = 30;
    [self.Collection setImage:[UIImage imageNamed:@"未选中收藏"] forState:UIControlStateNormal];
    [self.Collection setImage:[UIImage imageNamed:@"选中收藏"] forState:UIControlStateSelected];
    
    UIBarButtonItem*rightB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shoppingCart"] style:(UIBarButtonItemStylePlain) target:self action:@selector(Go_To_Shop)];
    
    self.navigationItem.rightBarButtonItem = rightB;

}
//去购物车
- (void)Go_To_Shop
{

    self.tabBarController.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)setUpSubView
{
    self.TopBackView.backgroundColor = ZXColor(60, 170, 40, 0.85);
    self.FeastImg.layer.cornerRadius = 6;
    self.FeastImg.layer.masksToBounds = YES;
    self.TuiJLable.layer.cornerRadius = 5;
    self.TuiJLable.layer.masksToBounds = YES;
    self.PJLable.layer.cornerRadius = 5;
    self.PJLable.layer.masksToBounds = YES;
    self.FeastNoticeLable.layer.cornerRadius = 4;
    self.FeastNoticeLable.layer.masksToBounds = YES;
    [self.SummeryButton
                                       setTitleColor:ZXColor(0, 129, 0, 1) forState:(UIControlStateNormal)];
    [self.SummeryButton
                                       addTarget:self action:@selector(SButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.EvaluateButton
                                       addTarget:self action:@selector(EButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.ChangeView.backgroundColor = [UIColor redColor];
    self.FeastName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.FeastPrice.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];

    [self.MainFoodSumButton
                                       addTarget:self action:@selector(MainFSumButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.MainFoodSumButton.backgroundColor = [UIColor whiteColor];
    [self.MatchFeedChooseBuuton
                                       addTarget:self action:@selector(MatchFodChoBuuton) forControlEvents:(UIControlEventTouchUpInside)];
    [self creatTableview];
    self.MianArray = [NSMutableArray array];
   

    
}
- (void)creatTableview
{
    _MainFeastTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 0,KWIDTH-80, KHEIGHT-275) style:(UITableViewStylePlain)];
    _MainFeastTableView.delegate = self;              
    _MainFeastTableView.dataSource  = self;
    [self.ChangeView addSubview:_MainFeastTableView];
}
- (void)CreatBottmView
{
    
    _bottmView = [[BottmView alloc]initWithFrame:CGRectMake(0,KHEIGHT-50, KWIDTH, 50)];
    [_bottmView.JoinShopCarButton
                                       addTarget:self action:@selector(JoinShopCarButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottmView.BuyNowBuuton
                                       addTarget:self action:@selector(BuyNowBuuton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottmView];
}
//删除导航栏下的黑线
- (void)removNavigationBarBottomBlackLine
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}


#define tableViewDatasoce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isChang == YES) {
         return 50;
    }else
    {
         return 80;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isChang == NO) {
        static NSString*ID = @"MainCell";
        FasetShowCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle
                                       mainBundle]loadNibNamed:@"FasetShowCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
       
        cell.FeastImage.layer.cornerRadius = 6;
        cell.FeastImage.layer.masksToBounds = YES;
        return cell;
    }else
    {
        static NSString*ID = @"MatchCell";
        recFasetCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle
                                       mainBundle]loadNibNamed:@"recFasetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (SW == 320) {
            cell.FeastNameLable.font = [UIFont systemFontOfSize:14];
        }else
        {
            cell.KuCLable.font = [UIFont systemFontOfSize:14];
            
        }
        [cell.ChooseBnt
                                       addTarget:self action:@selector(ChooseButton:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.ChooseBnt.tag = indexPath.row;
        if ([_BntArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
              [cell.ChooseBnt
                                       setImage:[UIImage imageNamed:@"green_icon.png"] forState:(UIControlStateNormal)];
        }
        cell.ChooseBnt.tag = indexPath.row+10;
        return cell;
        
    }
}
//主菜详情点击事件==============================
- (void)MainFSumButton
{
    _isChang = NO;
    self.MianArray = [NSMutableArray array];
    
        
    

    self.MainFoodSumButton.backgroundColor = [UIColor whiteColor];
    self.MatchFeedChooseBuuton.backgroundColor = ZXColor(217, 217, 217, 1);
    self.Pei_button.backgroundColor = ZXColor(217, 217, 217, 1);

    [self.MainFeastTableView reloadData];
    

}
//冷菜选择点击事件=============================
- (void)MatchFodChoBuuton
{
    
    NSLog(@"这里是冷-=-=-=");
    _isChang = NO;
    self.MianArray = [NSMutableArray array];
    WK(weakSelf);
    
    
    self.Pei_button.backgroundColor =ZXColor(217, 217, 217, 1);
    self.MatchFeedChooseBuuton.backgroundColor = [UIColor whiteColor];
    self.MainFoodSumButton.backgroundColor = ZXColor(217, 217, 217, 1);
    
    [self.MainFeastTableView reloadData];
    
}

//配菜===============================
- (IBAction)pei_buttonclick:(id)sender {
    _isChang = YES;
    WK(weakSelf);
    
    [self.MainFeastTableView reloadData];
    self.Pei_button.backgroundColor = [UIColor whiteColor];
    self.MainFoodSumButton.backgroundColor = ZXColor(217, 217, 217, 1);
    self.MatchFeedChooseBuuton.backgroundColor = ZXColor(217, 217, 217, 1);
}
//配菜勾选
- (void)ChooseButton:(UIButton*)CB

{
    CB.selected = !CB.selected;

    
}
//内容点击事件
- (void)SButton
{
    if (_ChangeView == NO) {
        
    }else
    {
        if (_isChang == YES) {
           _isChang = YES;
        }else
        {
            _isChang = NO;
        }
      
        self.ChangeView.hidden = NO;
        [_cc removeFromParentViewController];
        [_cc.view removeFromSuperview];
    }
    
    [self.SummeryButton setTitleColor:ZXColor(0, 129, 0, 1) forState:(UIControlStateNormal)];
    [self.EvaluateButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

    [UIView animateWithDuration:1 animations:^{
        CGRect xx = self.AnmationView.frame;
        xx.origin.x = 80;
        self.AnmationView .frame = xx;
    }];
    
}
//评价点击事件
- (void)EButton
{
    [self.EvaluateButton
                                            setTitleColor:ZXColor(0, 129, 0, 1) forState:(UIControlStateNormal)];
    [self.SummeryButton
                                            setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [UIView animateWithDuration:1 animations:^{
        CGRect xx = self.AnmationView.frame;
        xx.origin.x = KWIDTH-120;
        self.AnmationView .frame = xx;
    }];
    if (self.ChangeView.hidden == YES) {
        return;
        
    }else
    {
        self.ChangeView.hidden = YES;;

        _cc = [[ESLTuiJianController  alloc]init];
        _cc.view.frame = self.ChangeView.frame;
      
            _cc.ID = self.Allmodel.ID;
            
        
        [self.view addSubview:_cc.view];
        [self addChildViewController:_cc];
    }
    
    
   
    
}
//加入购物车
- (void)JoinShopCarButton:(UIButton*)Join
{
    WK(weakSelf);
    [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    
}
//立即购买
- (void)BuyNowBuuton
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }else{
       
    }
    
}
//收藏
- (IBAction)Collection:(id)sende{
    WK(weakSelf);
    [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:Login_Suc]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:NO completion:nil];
        return;
    }
    if(self.ProId) {
        [HUDView sharedInstanceWithView:weakSelf.view].text = @"";
        [[HUDView sharedInstanceWithView:weakSelf.view]showOnlyTextHUD];
        [HUDView sharedInstanceWithView:weakSelf.view].text = @"你已经收藏过了";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
            });
    }else{
        
    }
}
- (void)request:(NSString *)str{
    WK(weakSelf);
    [zJRequestManager requestWithUrl:str parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [[HUDView sharedInstanceWithView:weakSelf.view]showOnlyTextHUD];
        [HUDView sharedInstanceWithView:weakSelf.view].text = dic[@"提示"];
        NSLog(@"dic==%@",dic[@"提示"]);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        });
        self.Collection.selected = YES;
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
#pragma mark==查询收藏==

//登陆返回代理
- (void)dismiss
{
    
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc
{
    _cc = nil;
    _cc.view = nil;
    self.MainFeastTableView.delegate = nil;
    self.MainFeastTableView.dataSource = nil;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
}
@end
