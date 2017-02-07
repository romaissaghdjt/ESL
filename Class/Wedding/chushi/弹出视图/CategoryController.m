//
//  CategoryController.m
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CategoryController.h"
#import "StarController.h"
@interface CategoryController ()
@property (strong, nonatomic)NSArray *array;
@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"团队",@"个人"];
    self.view.backgroundColor = ZXColor(95, 95, 95, 1);
    self.tableView.scrollEnabled = NO;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        //去掉多余的分割线
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        cell.backgroundColor = ZXColor(236, 236, 236, 1);
        cell.textLabel.textColor = [UIColor whiteColor];
        
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.array[indexPath.row];
    self.block1(name);
}
#pragma mark == cell 将要显示的时候就会调用此方法  使cell分割线右边的缺失部分补齐 ==
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
