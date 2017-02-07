//
//  CLCheckViewController.m
//  YY
//
//  Created by 陈龙 on 16/7/7.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLCheckViewController.h"
#import "NumCell.h"
#import "CLXiShiTangNetanager.h"
#import "CLCheckNumModel.h"

@interface CLCheckViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *firstPrizeArray;
@property (nonatomic, strong)NSMutableArray *secondPrizeArray;
@property (nonatomic, strong)NSMutableArray *thirdPrizeArray;
@property (nonatomic, strong)UILabel *currentNum;
@end

@implementation CLCheckViewController

-(NSMutableArray *)firstPrizeArray
{
    if (!_firstPrizeArray) {
        _firstPrizeArray = [NSMutableArray array];
    }
    return _firstPrizeArray;
}
-(NSMutableArray *)secondPrizeArray
{
    if (!_secondPrizeArray) {
        _secondPrizeArray = [NSMutableArray array];
    }
    return _secondPrizeArray;
}
-(NSMutableArray *)thirdPrizeArray
{
    if (!_thirdPrizeArray) {
        _thirdPrizeArray = [NSMutableArray array];
    }
    return _thirdPrizeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375*SCREEN_SCALE, 667*SCREEN_DCALE)];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgImageView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(75*SCREEN_SCALE, 20*SCREEN_DCALE, 225*SCREEN_SCALE, 150*SCREEN_DCALE)];
    imageView.image = [UIImage imageNamed:@"wenzi"];
    [self.view addSubview:imageView];
    //当前中奖者
    UILabel *currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 190*SCREEN_DCALE, KWIDTH, 30*SCREEN_DCALE)];
    currentLabel.text = @"当前中奖者";
    currentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:currentLabel];
    
    //当前中奖号码
    self.currentNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 225*SCREEN_DCALE, KWIDTH, 30*SCREEN_DCALE)];
    if (self.isFromCustom == YES) {
        self.currentNum.text = [((CLCheckNumModel *)self.numArr.lastObject).WinnerTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    else
    {
        self.currentNum.text = ((CLCheckNumModel *)self.numArr.lastObject).WinnerTel;
    }
    self.currentNum.textAlignment = NSTextAlignmentCenter;
    self.currentNum.textColor = [UIColor redColor];
    [self.view addSubview:self.currentNum];
    
    UILabel *historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*SCREEN_SCALE, 260*SCREEN_DCALE, 200*SCREEN_SCALE, 30*SCREEN_DCALE)];
    historyLabel.text = @"历史中奖者记录如下";
    [self.view addSubview:historyLabel];
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(290*SCREEN_SCALE, 260*SCREEN_DCALE, 60*SCREEN_SCALE, 30*SCREEN_DCALE)];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    if (self.isFromCustom == YES) {
        //刷新按钮
        UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(210*SCREEN_SCALE, 260*SCREEN_DCALE, 60*SCREEN_SCALE, 30*SCREEN_DCALE)];
        [refreshBtn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:refreshBtn];
    }
    for (CLCheckNumModel *model in self.numArr) {
        if ([model.NameS isEqualToString:@"一等奖"]) {
            [self.firstPrizeArray addObject:model];
        }
        else if ([model.NameS isEqualToString:@"二等奖"])
        {
            [self.secondPrizeArray addObject:model];
        }
        else
        {
            [self.thirdPrizeArray addObject:model];
        }
    }
    [_tableView reloadData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(75*SWIDTH_SCALE, 300*SHEIGHT_DCALE, 225*SWIDTH_SCALE, 300*SHEIGHT_DCALE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshClick:(UIButton *)sender
{
    [CLXiShiTangNetanager getCurrentNumWithDrowID:[[NSUserDefaults standardUserDefaults] objectForKey:@"securityCode"] Tel:us CompletionHandler:^(NSArray *array, NSError *error) {
        self.numArr = array;
        if (self.isFromCustom == YES) {
            self.currentNum.text = [((CLCheckNumModel *)self.numArr.lastObject).WinnerTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        else
        {
            self.currentNum.text = ((CLCheckNumModel *)self.numArr.lastObject).WinnerTel;
        }
        [self.firstPrizeArray removeAllObjects];
        [self.secondPrizeArray removeAllObjects];
        [self.thirdPrizeArray removeAllObjects];
        for (CLCheckNumModel *model in self.numArr) {
            if ([model.NameS isEqualToString:@"一等奖"]) {
                [self.firstPrizeArray addObject:model];
            }
            else if ([model.NameS isEqualToString:@"二等奖"])
            {
                [self.secondPrizeArray addObject:model];
            }
            else
            {
                [self.thirdPrizeArray addObject:model];
            }
        }
        [self.tableView reloadData];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.firstPrizeArray.count == 0) {
            return 1;
        }
        return self.firstPrizeArray.count;
    }
    else if (section == 1)
    {
        if (self.secondPrizeArray.count == 0) {
            return 1;
        }
        return self.secondPrizeArray.count;
    }
    else
    {
        if (self.thirdPrizeArray.count == 0) {
            return 1;
        }
        return self.thirdPrizeArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NumCell" owner:nil options:nil].lastObject;
    }
    if (indexPath.section == 0) {
        if (self.firstPrizeArray.count == 0) {
            cell.numLabel.text = @"";
        }
        else
        {
            cell.numLabel.text = ((CLCheckNumModel *)self.firstPrizeArray[indexPath.row]).WinnerTel;
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        if (self.secondPrizeArray.count == 0) {
            cell.numLabel.text = @"";
        }
        else
        {
            cell.numLabel.text = ((CLCheckNumModel *)self.secondPrizeArray[indexPath.row]).WinnerTel;
        }
    }
    else
    {
        if (self.thirdPrizeArray.count == 0) {
            cell.numLabel.text = @"";
        }
        else
        {
            cell.numLabel.text = ((CLCheckNumModel *)self.thirdPrizeArray[indexPath.row]).WinnerTel;
        }
    }
    if (self.isFromCustom == YES) {
        if (![cell.numLabel.text isEqualToString:@""]) {
            cell.numLabel.text = [cell.numLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
    }
    cell.numLabel.textColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 275*SWIDTH_SCALE, 40)];
    if (section == 0) {
        label.text = @"一等奖";
    }
    else if (section == 1)
    {
        label.text = @"二等奖";
    }
    else
    {
        label.text = @"三等奖";
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = kUIColorFromRGB(0xFFD39B);
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
@end
