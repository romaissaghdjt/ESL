//
//  ESLWeddingDressController.m
//  ESL
//
//  Created by 赵洁 on 16/11/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLWeddingDressController.h"

@interface ESLWeddingDressController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView*webView;
@end

@implementation ESLWeddingDressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"婚纱摄影";
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    _webView.delegate = self;
    NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ess.nbeysx.com/Views/WeddingPhotography.html"]];
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
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

@end
