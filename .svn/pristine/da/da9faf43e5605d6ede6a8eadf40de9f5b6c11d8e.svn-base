//
//  ESLAccountDetailViewController.m
//  ESL
//
//  Created by eyou on 16/11/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLAccountDetailViewController.h"
#import "ESLMyNetworkingManager.h"
#import "AccountDetailCell.h"
@interface ESLAccountDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *listArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ESLAccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收支明细";
    [self creatTableView];
    [ESLMyNetworkingManager getAccountInfoWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSArray *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.listArray = result;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESLBalanceModel *model = self.listArray[indexPath.row];
    AccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AccountDetailCell" owner:nil options:nil].firstObject;
    }
    cell.numLabel.text = [NSString stringWithFormat:@"%.02lf", model.valueStr.floatValue];
    cell.dateLabel.text = model.dateStr;
    cell.balanceLabel.text = [NSString stringWithFormat:@"%.02lf", model.resualtValueStr.floatValue];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

@end
