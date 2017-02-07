//
//  ESLFoodDetailsViewController.m
//  ESL
//
//  Created by eyou on 16/11/25.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLFoodDetailsViewController.h"

@interface ESLFoodDetailsViewController ()

@end

@implementation ESLFoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT- 64)];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ess8222.nbeysx.com/Views/ProductDetails.aspx?ProductCgy=%@&ProID=%@", self.typeStr,self.proID]]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
