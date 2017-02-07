//
//  ESLReplaceViewController.m
//  ESL
//
//  Created by 赵洁 on 16/12/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLReplaceViewController.h"
#import "FeastDtiallRightCell.h"
@interface ESLReplaceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView*tableView;

@end

@implementation ESLReplaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZXColor(0, 128, 0, 1);
    self.view.layer.cornerRadius = 10;
    self.view.layer.borderWidth = 2;
    self.view.layer.backgroundColor = [UIColor blackColor].CGColor;
    
    [self creatTableView];
}
- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 280, 250) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.view addSubview:self.tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID = @"Cell";
    FeastDtiallRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
    
        cell = [[NSBundle mainBundle]loadNibNamed:@"FeastDtiallRightCell" owner:nil options:nil].firstObject;
        
    }
    cell.ChooseButton.hidden = YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(getdata:CilckIndex:)]) {
        [self.delegate getdata:indexPath.row CilckIndex:self.CilckIndex];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"-=-=-=-==-=-=-=-=内存报警了-=----==-=-=-=-=--");
}
@end
