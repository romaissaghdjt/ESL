//
//  ESLHelpViewController.m
//  ESL
//
//  Created by 赵洁 on 17/1/16.
//  Copyright © 2017年 cl. All rights reserved.
//

#import "ESLHelpViewController.h"
#import "ESLHelpCell.h"

#import "ESLFeastDetailViewController.h"
#import "ESLHelpViewModle.h"
@interface ESLHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)ESLHelpViewModle*ViewModle;
@property (nonatomic,strong)NSMutableArray* dataarray;

@end


@implementation ESLHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createleftTableView];
    self.title = @"你请我援";
    self.tabBarController.tabBar.hidden = YES;
    self.dataarray = [NSMutableArray array];
    _ViewModle = [[ESLHelpViewModle alloc]init];
    WK(weakSelf);
    _ViewModle.DataSourceBlock= ^(id DataSource)
    {
        weakSelf.dataarray = (NSMutableArray*)DataSource;
        [weakSelf.tableView reloadData];
    };
    [_ViewModle getFeastAllData];
    
}
- (void)createleftTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT+50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //分割线的颜色
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /**隐藏滚动条*/
    _tableView.showsVerticalScrollIndicator = NO;
    //去掉多余的分割线
    //[_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.backgroundColor = ZXColor(242, 242, 242, 1);
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataarray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID = @"FasetCell";
    ESLHelpCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"ESLHelpCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.fristBnt.layer.cornerRadius = 5;
    cell.fristBnt.layer.masksToBounds = YES;
    cell.secondBnt.layer.cornerRadius = 5;
    cell.secondBnt.layer.masksToBounds = YES;
    cell.thridBnt.layer.cornerRadius = 5;
    cell.thridBnt.layer.masksToBounds = YES;
    cell.fristBnt.tag = indexPath.row*10+10;
    cell.secondBnt.tag = indexPath.row*10+11;
    cell.thridBnt.tag = indexPath.row*10+12;
    [cell.fristBnt addTarget:self action:@selector(fristBntClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.secondBnt addTarget:self action:@selector(fristBntClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.thridBnt addTarget:self action:@selector(fristBntClick:) forControlEvents:(UIControlEventTouchUpInside)];
    if (indexPath.row == 0) {
        cell.img.image = [UIImage imageNamed:@"56"];
    }else if(indexPath.row == 1)
    {
        cell.img.image = [UIImage imageNamed:@"810"];

    }else
    {
        cell.img.image = [UIImage imageNamed:@"1012"];

    }
    cell.imgarray = self.dataarray[indexPath.row];
    
    return cell;
}
- (void)fristBntClick:(UIButton*)bnt
{
    NSInteger a =(bnt.tag-10)-(bnt.tag/10-1)*10;
    ESLFeastDetailViewController*HDVC = [[ESLFeastDetailViewController alloc]init];
    NSArray*arr = self.dataarray[bnt.tag/10-1];
    HDVC.Allmodel = arr[a];
    [self.navigationController pushViewController:HDVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
