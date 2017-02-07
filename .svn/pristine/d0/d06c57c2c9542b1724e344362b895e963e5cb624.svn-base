//
//  ESLHeadlineDetailsController.m
//  ESL
//
//  Created by 徐恒 on 2016/11/25.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLHeadlineDetailsController.h"
#import "ESLHeadlineDetails.h"
#import "ESLHeadlineDetailsCell.h"
@interface ESLHeadlineDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *TabelView;
@property (strong, nonatomic)NSMutableArray *arr;
@end

@implementation ESLHeadlineDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"喜宴头条";
    
    [self creterTableView];
    [self request];
}
- (void)request{
    [zJRequestManager requestWithUrl:[PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryAllHeadlines"] parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (array.count==0) {
            return ;
        }else{
            self.arr = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            ESLHeadlineDetails *headModel = [[ESLHeadlineDetails alloc]init];
            [headModel setValuesForKeysWithDictionary:dic];
            [self.arr addObject:headModel];
        }
        }
        [self.TabelView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)creterTableView{
    _TabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _TabelView.delegate = self;
    _TabelView.dataSource = self;
    _TabelView.rowHeight = KHEIGHT;
    _TabelView.showsVerticalScrollIndicator = NO;
    _TabelView.tableFooterView = [UIView new];
    [self.view addSubview:_TabelView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    ESLHeadlineDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ESLHeadlineDetailsCell" owner:nil options:nil].firstObject;
    }
    cell.img.image = [UIImage imageNamed:@"xytt.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
