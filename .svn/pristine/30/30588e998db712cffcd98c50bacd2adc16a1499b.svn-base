//
//  WeddingController.m
//  YY
//
//  Created by 赵洁 on 16/7/4.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "WeddingController.h"
#import "WeddingCell.h"
#import "FeastListController.h"
#import "PrivateMadeController.h"
#import "RecreationkindController.h"
#import "WeddingModel.h"
#import "FeastShowController.h"
@interface WeddingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView*tableView;
@property (nonatomic, strong)NSMutableArray*array;
@end

@implementation WeddingController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    

}
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"甬尚鲜婚庆";
    self.tabBarController.tabBar.hidden= YES;

    self.navigationController.navigationBar.tintColor= ZXColor(216, 86, 112, 1);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ZXColor(215, 86, 111, 0.8),
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor= ZXColor(255, 255, 255, 1);
    [self creatTablewView];
}
- (void)creatTablewView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    UIImageView*view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-KWIDTH-80)];
    view.image = [UIImage imageNamed:@"组1.png"];
    self.tableView.tableHeaderView = view;
    self.tableView.rowHeight = KWIDTH-40;
    
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"WCell";
    WeddingCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"WeddingCell" owner:nil options:nil].lastObject;
    }
    cell.LeftTopButton.layer.cornerRadius = 20;
    [cell.LeftTopButton addTarget:self action:@selector(LeftTopButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.RightTopButton.layer.cornerRadius = 20;
    [cell.RightTopButton addTarget:self action:@selector(RightTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.LeftBottmButton.layer.cornerRadius = 20;
    [cell.LeftBottmButton addTarget:self action:@selector(LeftBottmButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.LeftBottmButton.tag = 100;
    cell.RightBottmButton.layer.cornerRadius = 20;
    [cell.RightBottmButton addTarget:self action:@selector(LeftBottmButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.RightBottmButton.tag = 101;
    cell.CenterView.layer.cornerRadius = 25;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (void)LeftTopButton
{
    FeastListController *feastVC= [[FeastListController alloc]init];
    
    [self.navigationController pushViewController:feastVC animated:YES];
}
- (void)RightTopButton:(UIButton*)sender
{
    FeastShowController *PrvateVC = [[FeastShowController alloc]init];
    PrvateVC.str = @"私人订制";
    
    
    [self.navigationController pushViewController:PrvateVC animated:YES];
}
- (void)LeftBottmButton:(UIButton*)sender
{
    RecreationkindController *RecrVC = [[RecreationkindController alloc]init];
    if (sender.tag == 100) {
        RecrVC.str = @"歌舞演艺";
    }else if (sender.tag == 101)
    {
        RecrVC.str = @"庆典礼仪";
    }
    
    [self.navigationController pushViewController:RecrVC animated:YES];
}
- (void)RightBottmButton
{
    RecreationkindController *RecrVC = [[RecreationkindController alloc]init];
    [self.navigationController pushViewController:RecrVC animated:YES];
}
@end
