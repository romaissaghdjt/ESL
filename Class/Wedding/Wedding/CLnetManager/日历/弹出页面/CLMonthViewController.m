//
//  CLMonthViewController.m
//  test
//
//  Created by 陈龙 on 16/5/24.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "CLMonthViewController.h"
#import "Masonry.h"


@interface CLMonthViewController ()<UITableViewDelegate, UITableViewDataSource>

/** <#属性#> */
@property (nonatomic, strong) UITableView *tableView;
/** <#属性#> */
@property (nonatomic, strong) NSMutableArray *monthList;


@end

@implementation CLMonthViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !_chooseBlock ?: _chooseBlock([self.monthList[indexPath.row] integerValue]);
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.monthList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.monthList[indexPath.row] integerValue]];
    return cell;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _monthList = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        [_monthList addObject:@(i)];
    }
    
    [self.tableView reloadData];
    if (self.indexP != 1) {
        [self scrollToTableViewLastRow];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollToTableViewLastRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.indexP - 2 inSection:0];
   
    // 控制表格滚动到最后一行对应的indexpath位置
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


@end
