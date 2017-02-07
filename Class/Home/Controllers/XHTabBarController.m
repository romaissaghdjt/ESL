//
//  XHTabBarController.m
//  YY
//
//  Created by 徐恒 on 16/4/21.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "XHTabBarController.h"
#import "ESLHomeViewController.h"
#import "ESLAllViewController.h"
#import "ESLMyViewController.h"
//#import "ShoppingCarController.h"
//#import "ESLShopViewController.h"
#import "ESLPrivateViewController.h"

#import "ESLShopCartViewController.h"
@interface XHTabBarController ()<LoginViewControllerDelegate>
@property (nonatomic , strong)ESLHomeViewController *homeVC;
@property (nonatomic , strong)UINavigationController *homeNC;
@property (nonatomic , strong)ESLShopCartViewController *shopVC;
@property (nonatomic , strong)UINavigationController *shopNC;
@property (nonatomic , strong)ESLMyViewController *myVC;
@property (nonatomic , strong)UINavigationController *myNC;
@property (nonatomic , strong)ESLPrivateViewController *allVC;
@property (nonatomic , strong)UINavigationController *allNC;
@end

@implementation XHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = ZXColor(100, 172, 56, 1);
    [self configNCs];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AccountTakeUp) name:NotificationTakeUPKEY object:nil];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(btnClickClassName:) name:@"ClassName" object:nil];
    
}

-(void)btnClickClassName:(NSNotification *)dict
{
    self.allVC.className = dict.userInfo[@"className"];
    for (UIButton *btn in self.allVC.btnArray) {
        if ([btn.titleLabel.text isEqualToString:self.allVC.className]) {
            [self.allVC btnClick:btn];
        }
    }
}

- (void)AccountTakeUp
{
[[ShowMessageTools sharedInstance]showMessageBack:@"你的账号在另一台设备登录" controller:self block:^{
            [[TCPChannel getTcpChannel]disConnect];
            if (self.selectedIndex == 3) {
                LoginViewController*login = [[LoginViewController alloc] init];
                login.delegate = self;
                UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
               
                [self presentViewController:navVC animated:NO completion:nil];
            }
    
        }];
}
- (void)dismiss
{
    self.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
////调整tabbar的高度
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame; 
//    tabFrame.size.height = 43;
//    tabFrame.origin.y = self.view.frame.size.height - 43;
//    self.tabBar.frame = tabFrame;
//}
- (void)configNCs
{
    [self configHomeNC];
    [self configMyNC];
    [self configAllNC];
    [self configShopNC];
    // 关键代码:设置tabBarC管理的导航控制器
    self.viewControllers = @[_homeNC,_allNC, _shopNC, _myNC];
    // 设置默认显示的NC
    self.selectedIndex = 0;
}

- (void)configShopNC
{
    self.shopVC = [[ESLShopCartViewController alloc]init];
    self.shopNC = [[UINavigationController alloc]initWithRootViewController:_shopVC];
    _shopVC.navigationItem.title = @"购物车";
    _shopNC.tabBarItem.image = [UIImage imageNamed:@"gouwuche"];
    _shopNC.tabBarItem.title = @"购物车";
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [_shopNC.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
}

- (void)configHomeNC
{
    self.homeVC = [[ESLHomeViewController alloc]init];
    self.homeNC = [[UINavigationController alloc]initWithRootViewController:_homeVC];
    //_homeVC.navigationItem.title = @"主页";
    _homeNC.tabBarItem.image = [UIImage imageNamed:@"shouye"];
    _homeNC.tabBarItem.title = @"首页";
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [_homeNC.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
}
- (void)configAllNC
{
    self.allVC = [[ESLPrivateViewController alloc]init];
    self.allNC = [[UINavigationController alloc]initWithRootViewController:_allVC];
    _allVC.navigationItem.title = @"生鲜分类";
    _allNC.tabBarItem.image = [UIImage imageNamed:@"quanbu"];
    
    _allNC.tabBarItem.title = @"全部";
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [_allNC.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
//    _indetNC.tabBarItem.selectedImage = [UIImage imageNamed:@"order_red@3x.png"];
}
- (void)configMyNC
{
    
        self.myVC = [[ESLMyViewController alloc]init];
        self.myNC = [[UINavigationController alloc]initWithRootViewController:_myVC];
        _myVC.navigationItem.title = @"我的";
        _myNC.tabBarItem.image = [UIImage imageNamed:@"wode"];
        _myNC.tabBarItem.title = @"我的";
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        dic1[NSFontAttributeName] = [UIFont systemFontOfSize:11];
        [_myNC.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    
//    _myNC.tabBarItem.selectedImage = [UIImage imageNamed:@"red_mine@3x.png"];
}

//+(UIView *)createDashedLineWithFram:(CGRect)lineFrame lineLength:(int)length lingSpacing:(int)spacing lingColor:(UIColor *)color{
//    UIView *dashedLine =[[UIView alloc]initWithFrame:lineFrame];
//    dashedLine.backgroundColor=[UIColor clearColor];
//    CAShapeLayer *shapeLayer =[CAShapeLayer layer];
//    [shapeLayer setBounds:dashedLine.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame)/2, CGRectGetHeight(dashedLine.frame))];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    [shapeLayer setStrokeColor:color.CGColor];
//    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length],[NSNumber numberWithInt:spacing], nil]];
//    CGMutablePathRef path =CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    [dashedLine.layer addSublayer:shapeLayer];
//    
//    return dashedLine;
//}

@end
