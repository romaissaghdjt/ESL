//
//  StarController.m
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "StarController.h"
#import "CookStarCell.h"
#import "StarChoiceController.h"
@interface StarController ()
@property (nonatomic,strong)NSArray *array;
@end

@implementation StarController
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.rowHeight = 35;
    if (_type==TeamType) {
        self.array = @[@"团队",@"个人"];
    } else if (_type==StarsType){
        self.array =@[@"三星级",@"四星级",@"五星级"];
    }
    self.tableView.scrollEnabled = NO;

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    CookStarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CookStarCell" owner:nil options:nil].firstObject;
        //去掉多余的分割线
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        cell.backgroundColor = ZXColor(95, 95, 95, 1);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.starName.text = self.array[indexPath.row];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.array[indexPath.row];
  //1.block 回调
//    self.block(name);
    //2.代理
    if ([_delegeta respondsToSelector:@selector(starControllerWithTapName:type:)]) {
        [_delegeta starControllerWithTapName:name type:self.type];
    }
    
    
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
