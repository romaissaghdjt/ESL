//
//  ESLTopHeaderViewController.m
//  ESL
//
//  Created by eyou on 17/1/22.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLTopHeaderViewController.h"

@interface ESLTopHeaderViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView*webView;
@end

@implementation ESLTopHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT - 64)];
    _webView.delegate = self;
    NSLog(@"%@", self.urlStr);
    NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.urlStr]]];
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
