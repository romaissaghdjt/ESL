//
//  ESLCuisineController.m
//  ESL
//
//  Created by 徐恒 on 27/10/16.
//  Copyright © 2016年 cl. All rights reserved.
//



#import "ESLCuisineController.h"
#import "ESLDeliveryTime.h"
#import "ConfirmOrderController.h"
#import "ESLCuisineModel.h"
#import "ESLDetailsCuisineCell.h"
@interface ESLCuisineController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSArray *listData;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UITableViewCell *tableViewCell;
@property (strong , nonatomic)ESLDeliveryTime *Dtime;
@end

@implementation ESLCuisineController
- (NSArray *)listData {
    if (!_listData) {
        _listData = [[NSArray alloc]init];
    }
    return _listData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化表格
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    
    
    // 设置协议，意思就是UITableView类的方法交给了tabView这个对象，让完去完成表格的一些设置操作
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //把tabView添加到视图之上
    [self.view addSubview:self.tableView];
    [self request];
}

-(void)request{
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryCuisine"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
//        NSLog(@"arr==%@",arr);
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            ESLCuisineModel *model = [[ESLCuisineModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.listData =array ;
        [self.tableView reloadData];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //    用TableSampleIdentifier表示需要重用的单元
    ESLDetailsCuisineCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ESLDetailsCuisineCell" owner:nil options:nil].firstObject;
        }
    ESLCuisineModel * model = self.listData[indexPath.row];
    cell.ESLCuisineModel = model;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ESLCuisineModel * model = self.listData[indexPath.row];
    NSLog(@"%@",model.Name);
    self.block(model.Name);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil ];

}
@end
