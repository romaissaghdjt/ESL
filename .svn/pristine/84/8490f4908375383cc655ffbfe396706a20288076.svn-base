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
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"num.plist"]

@interface CLCheckViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *numOKArray;
@property (nonatomic, strong)NSMutableArray *firstPrizeArray;
@property (nonatomic, strong)NSMutableArray *secondPrizeArray;
@property (nonatomic, strong)NSMutableArray *thirdPrizeArray;
@end

@implementation CLCheckViewController
-(NSMutableArray *)numOKArray
{
    if (!_numOKArray) {
        _numOKArray = [NSMutableArray array];
    }
    return _numOKArray;
}
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

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 250*SHEIGHT_DCALE, 375*SWIDTH_SCALE, 350*SHEIGHT_DCALE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    if (self.isFromCustom == NO) {
        self.numOKArray = [NSArray arrayWithContentsOfFile:kFilePath].mutableCopy;
    }
    [_tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.numOKArray writeToFile:kFilePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstPrizeArray.count;
    }
    else if (section == 1)
    {
        return self.secondPrizeArray.count;
    }
    else
    {
        return self.thirdPrizeArray.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"一等奖";
    }
    else if (section == 1)
    {
        return @"二等奖";
    }
    else
    {
        return @"三等奖";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NumCell" owner:nil options:nil].lastObject;
    }
    if (indexPath.section == 0) {
        cell.numLabel.text = ((CLCheckNumModel *)self.firstPrizeArray[indexPath.row]).WinnerTel;

    }
    else if (indexPath.section == 1)
    {
        cell.numLabel.text = ((CLCheckNumModel *)self.secondPrizeArray[indexPath.row]).WinnerTel;
    }
    else
    {
        cell.numLabel.text = ((CLCheckNumModel *)self.thirdPrizeArray[indexPath.row]).WinnerTel;
    }
    if (self.isFromCustom == YES) {
        cell.numLabel.textColor = [UIColor redColor];
        
        cell.numLabel.text = [cell.numLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        cell.rightBtn.hidden = YES;
        cell.wrongBtn.hidden = YES;
    }
    else
    {
        if ([self.numOKArray containsObject:cell.numLabel.text]) {
            cell.numLabel.textColor = [UIColor redColor];
        }
        else
        {
            cell.numLabel.textColor = ZXColor(1, 205, 126, 1);
        }
        [cell.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.wrongBtn addTarget:self action:@selector(wrongBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtn:(UIButton *)sender
{
    ((NumCell *)sender.superview.superview).numLabel.textColor = [UIColor redColor];
    [self.numOKArray addObject:((NumCell *)sender.superview.superview).numLabel.text];
    sender.enabled = NO;
    ((NumCell *)sender.superview.superview).wrongBtn.enabled = YES;
    
}
- (void)wrongBtn:(UIButton *)sender
{
    ((NumCell *)sender.superview.superview).numLabel.textColor = ZXColor(1, 205, 126, 1);
    [self.numOKArray removeObject:((NumCell *)sender.superview.superview).numLabel.text];
    sender.enabled = NO;
    ((NumCell *)sender.superview.superview).rightBtn.enabled = YES;
}

@end
