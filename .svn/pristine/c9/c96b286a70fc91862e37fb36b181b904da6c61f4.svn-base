//
//  PriceRangeController.m
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PriceRangeController.h"
#import "StarController.h"
#import "PriceCell.h"
#import "LoginViewController.h"
#define kCONENTWIDTH  [UIScreen mainScreen].bounds.size.width / 3

@interface PriceRangeController ()<UITableViewDelegate,UITableViewDataSource,StarControllerDelegeta>
{
    NSInteger tag1;
}
@property (strong, nonatomic)UIView  *headerView;//顶部 View
@property (nonatomic, strong)UIScrollView *scrollView;
@property (strong, nonatomic)UIImageView *leftTabView;
@property (strong, nonatomic)UIImageView *currentTabView;
@property (strong, nonatomic)UIImageView *rightTabView;
@property (strong, nonatomic)NSArray *array;
@property (strong, nonatomic)UIButton *btn;
//@property (strong, nonatomic)XHIndetController *XHindetC;
//@property (strong, nonatomic) DropdownMenu *menu ;
@property (strong, nonatomic)UIButton *btn1;
@end

@implementation PriceRangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"厨师价格表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createHeaderView];
    [self createRightTableView];
    tag1=1003;
    [self.view addSubview:self.btn];
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
//    self.btn1 = btn;
}
-(void)clickA{
    //_menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    //    messageC.view.userInteractionEnabled = YES;
//    messageC.deleagte = self;
//    _menu.contentController = messageC;
//    [_menu showFrom:self.btn1];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_menu dismiss];
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
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createHeaderView{
    _headerView = [[UIView alloc] init];
    _headerView.frame = CGRectMake(0, 64, KWIDTH, 44);
    _headerView.backgroundColor = [UIColor whiteColor];
    UIView *grView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, KWIDTH, 1)];
    grView.backgroundColor = ZXColor(192, 192, 192, 0.5);
    [_headerView addSubview:grView];
    
    NSArray *ary = @[@"三星级",@"四星级",@"五星级"];
    for (int i = 3; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(kCONENTWIDTH *(i-3), 0, kCONENTWIDTH, _headerView.frame.size.height);
        btn.tag = 1000+i;
        btn.tintColor = ZXColor(160, 206, 85, 1);
        [btn setTitle:ary[i - 3] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:btn];
    }
    
    UIButton *btn1 = (UIButton *)[_headerView viewWithTag:1003];
    btn1.tintColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
}
- (void)click:(UIButton *)sender
{
    if (tag1 != sender.tag) {
        UIButton *btn = (UIButton *)[_headerView viewWithTag:tag1];
        btn.tintColor = ZXColor(160, 206, 85, 1);
        tag1 = sender.tag;
    }
    switch (sender.tag) {
        case 1003:
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(0, 0)animated:NO];
            break;
        case 1004:
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(KWIDTH, 0)animated:NO];
            break;
        case 1005:
            sender.tintColor = [UIColor blackColor];
            [self.scrollView setContentOffset:CGPointMake(KWIDTH*2, 0)animated:NO];
            break;
        default:
            break;
    }
}
- (void)createRightTableView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, KWIDTH,KHEIGHT-110)];
    _scrollView.contentSize = CGSizeMake(KWIDTH * 3, KHEIGHT-110);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    self.leftTabView = [self setTableViewWithRect:CGRectMake(40,20,KWIDTH-80,KHEIGHT-250)];
    self.leftTabView.image = [UIImage imageNamed:@"3xing"];
    [self.scrollView addSubview:_leftTabView];
    
    self.currentTabView = [self setTableViewWithRect:CGRectMake(KWIDTH+40,20,KWIDTH-80,KHEIGHT-250)];
    self.currentTabView.image = [UIImage imageNamed:@"4xing"];
    [self.scrollView addSubview:_currentTabView];
    
    self.rightTabView = [self setTableViewWithRect:CGRectMake(KWIDTH * 2+40,20,KWIDTH-80,KHEIGHT-250)];
    self.rightTabView.image = [UIImage imageNamed:@"5xing"];
    [self.scrollView addSubview:_rightTabView];
}
-(UIImageView *)setTableViewWithRect:(CGRect)rect
{
    UIImageView *tableView  = [[UIImageView alloc]initWithFrame:rect];

    return tableView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[_headerView viewWithTag:1003] setTintColor:ZXColor(160, 206, 85, 1)];
    [[_headerView viewWithTag:1004] setTintColor:ZXColor(160, 206, 85, 1)];
    [[_headerView viewWithTag:1005] setTintColor:ZXColor(160, 206, 85, 1)];
    NSInteger tag = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width) + 1003;
    [[_headerView viewWithTag:tag] setTintColor:[UIColor blackColor]];
}

@end
