//
//  CarInformationViewController.m
//  YY
//
//  Created by 徐恒 on 16/5/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CarInformationViewController.h"

@interface CarInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UIImageView *rightTableView;

@end
@implementation CarInformationViewController
- (NSMutableArray *)ary {
    if (!_ary) {
        _ary = [[NSMutableArray array]init];
    }
    return _ary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司简介";
    
    [self createrightTableView];
     
}
- (void)createrightTableView{
    _rightTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    
    _rightTableView.image = [UIImage imageNamed:@"jianjie.png"];
    [self.view addSubview:_rightTableView];
}
@end
