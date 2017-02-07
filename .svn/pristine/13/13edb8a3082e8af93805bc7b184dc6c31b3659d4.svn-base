//
//  ESLEvaluateViewController.m
//  ESL
//
//  Created by 徐恒 on 12/11/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLEvaluateViewController.h"
#import "ESLEvaluateCell.h"
#import "LHRatingView.h"

@interface ESLEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,ESLEvaluateCellDelegate>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)NSString*textTV;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)BOOL isEavluated;
@property (nonatomic, strong)NSIndexPath*currentCellIndexpath;
@property (nonatomic,strong)NSMutableArray*arr;
@property (nonatomic)BOOL isClear;
@property (nonatomic,assign)NSInteger TAG;

@end

@implementation ESLEvaluateViewController

- (void)viewDidLoad {
    self.title = @"评价";
    [super viewDidLoad];
    _isClear  = NO;
    _count = 1;
    _TAG = 10000;
    self.arr = [NSMutableArray array];
    [self.arr  addObjectsFromArray:self.sectionArray];
    //    for (int i = 0;i <self.arr.count;i++) {
    //        MyOrederSubModel *model = self.arr[i];
    //        if ([model.IsEvaluate isEqualToString:@"已评价"]) {
    //            [self.arr removeObject:self.arr[i]];
    //
    //        }
    //    }
    [self CreatTableView];
}
- (void)CreatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 60)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13, 35, 35)];
    //    img.backgroundColor = [UIColor redColor];
    img.image = [UIImage imageNamed:@"粉丝订单图标.png"];
    [_headView addSubview:img];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 80, 30)];
    lable.text = @"订单号:";
    [_headView addSubview:lable];
    UILabel *orderLable = [[UILabel alloc]initWithFrame:CGRectMake(lable.right-20, 15, 200, 30)];
    orderLable.text =self.orderNum;
    [_headView addSubview:orderLable];
    self.tableView.tableHeaderView = _headView;
    [self.view addSubview: _tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Ecell";
    ESLEvaluateCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"ESLEvaluateCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.sumbitBnt.layer.cornerRadius = 3;
    cell.sumbitBnt.layer.masksToBounds = YES;
    cell.sumbitBnt.layer.borderWidth = 1;
    cell.sumbitBnt.layer.borderColor = ZXColor(253, 203, 157, 1).CGColor;
    //cell.oneStartBnt.userInteractionEnabled = NO;
    [cell.towStartBnt setImage:[UIImage imageNamed:@"starFore.png"] forState:(UIControlStateSelected)];
    [cell.threeStarBnt setImage:[UIImage imageNamed:@"starFore.png"] forState:(UIControlStateSelected)];
    [cell.frouStartBnt setImage:[UIImage imageNamed:@"starFore.png"] forState:(UIControlStateSelected)];
    [cell.fiveStartBnt setImage:[UIImage imageNamed:@"starFore.png"] forState:(UIControlStateSelected)];
    if (_isClear == YES) {
        cell.oneStartBnt.selected = NO;
        cell.towStartBnt.selected = NO;
        cell.threeStarBnt.selected = NO;
        cell.frouStartBnt.selected = NO;
        cell.fiveStartBnt.selected = NO;
    }
    
    cell.tag = 10+indexPath.section;
    [cell.oneStartBnt addTarget:self action:@selector(oneStar:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.towStartBnt addTarget:self action:@selector(towStar:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.threeStarBnt addTarget:self action:@selector(threeStar:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.frouStartBnt addTarget:self action:@selector(frouStar:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.fiveStartBnt addTarget:self action:@selector(fiveStar:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.oneStartBnt.tag = 10000+indexPath.section;
    cell.towStartBnt.tag = 10001+indexPath.section;
    cell.threeStarBnt.tag = 10002+indexPath.section;
    cell.frouStartBnt.tag = 10003+indexPath.section;
    cell.fiveStartBnt.tag = 10004+indexPath.section;
    cell.sumbitBnt.tag = 100+indexPath.section;
    
    [cell.sumbitBnt addTarget:self action:@selector(sumbit:) forControlEvents:(UIControlEventTouchUpInside)];
    MyOrederSubModel *model = self.arr[indexPath.section];
    
    cell.smodle = model;
    
    
    cell.delegate = self;
    WK(weakSelf);
    cell.cellTextViewTxBlock = ^(NSString*str){
        weakSelf.textTV = str;
    };
    
    if (model.TAG == 10004) {
        cell.towStartBnt.selected = YES;
        cell.threeStarBnt.selected = YES;
        cell.frouStartBnt.selected = YES;
        cell.fiveStartBnt.selected = YES;
        
    }
    if (model.TAG == 10003) {
        cell.towStartBnt.selected = YES;
        cell.threeStarBnt.selected = YES;
        cell.frouStartBnt.selected = YES;
        cell.fiveStartBnt.selected = NO;
    }
    if (model.TAG == 10002) {
        cell.threeStarBnt.selected = YES;
        cell.towStartBnt.selected = YES;
        cell.frouStartBnt.selected = NO;
        cell.fiveStartBnt.selected = NO;
    }
    if (model.TAG == 10001) {
        cell.towStartBnt.selected = YES;
        cell.threeStarBnt.selected = NO;
        cell.frouStartBnt.selected = NO;
        cell.fiveStartBnt.selected = NO;
    }
    if (model.TAG == 10000) {
        cell.towStartBnt.selected = NO;
        cell.threeStarBnt.selected = NO;
        cell.frouStartBnt.selected = NO;
        cell.fiveStartBnt.selected = NO;
    }
    //    if (self.smodel.isEavluated == YES) {
    //        cell.sumbitBnt.enabled = NO;
    //        cell.sumbitBnt.layer.borderColor = [UIColor grayColor].CGColor;
    //        [cell.sumbitBnt setTitle:@"已评价" forState:(UIControlStateNormal)];
    //        [cell.sumbitBnt setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    //    }
    return cell;
}
- (void)oneStar:(UIButton*)b_one
{
    MyOrederSubModel *model = self.arr[b_one.tag-10000];
    model.TAG = 10000;
    [self sumbitBnt:b_one];
    _count = 1;
    [self.tableView reloadData];
    
}
- (void)towStar:(UIButton*)b_tow
{
    MyOrederSubModel *model = self.arr[b_tow.tag-10001];
    model.TAG = 10001;
    [self sumbitBnt:b_tow];
    _count = 2;
    [self.tableView reloadData];
}
- (void)threeStar:(UIButton*)b_three
{
    MyOrederSubModel *model = self.arr[b_three.tag-10002];
    model.TAG = 10002;
    _count = 3;
    [self sumbitBnt:b_three];
    [self.tableView reloadData];
}
- (void)frouStar:(UIButton*)b_frou
{
    MyOrederSubModel *model = self.arr[b_frou.tag-10003];
    model.TAG = 10003;
    _count = 4;
    [self sumbitBnt:b_frou];
    [self.tableView reloadData];
    
}
- (void)fiveStar:(UIButton*)b_five
{
    MyOrederSubModel *model = self.arr[b_five.tag-10004];
    model.TAG = 10004;
    _count = 5;
    [self sumbitBnt:b_five];
    [self.tableView reloadData];
    ;
}
- (void)sumbitBnt:(UIButton*)bb
{
    if (bb.tag == 10000) {
        bb.selected = YES;
    }
    bb.selected = !bb.selected;
    
    
}

- (void)sumbit:(UIButton*)bb
{
    if (self.textTV == nil) {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"信息不完整" controller:self];
        return;
    }
    self.smodel = self.sectionArray[bb.tag -100];
    NSString*url = [PREURL stringByAppendingString:[NSString stringWithFormat:@"Shopping.ashx?Component=Product&ProModule=%@&Function=HttpToBeEvaluate&UserTel=%@&UserPhyAdd=%@&ProID=%@&StarCount=%@&OrderID=%@&Remark=%@",self.smodel.ProductCgy,us,KUUID,self.smodel.ID,[NSString stringWithFormat:@"%ld",_count],self.orderNum,self.textTV]];
    
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary*DIC = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString*str = DIC[@"提示"];
        if ([str isEqualToString:@"评价失败"]) {
            NSString*reason = DIC[@"Reason"];
            [[ShowMessageTools sharedInstance]showMessage:reason controller:self block:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            } canclblock:^{
                NSLog(@"jkjkjkjk") ;
                
            }];
        }else
        {
            [[ShowMessageTools sharedInstance]showMessageBack:str controller:self block:^{
                _count = 0;
                _isClear = YES;
                [self.tableView reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
    
    
    
    
}

- (void)getcell:(ESLEvaluateCell *)cell
{
    
    CGFloat offset = self.tableView.frame.size.height - (cell.y +160+360)+self.tableView.contentOffset.y;
    NSLog(@"-=-=-=-=-=-==%f",offset);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.tableView.frame;
            frame.origin.y = offset;
            self.tableView.frame = frame;
            
        }];
    }
}
- (void)recovercell:(ESLEvaluateCell *)cell
{
    self.textTV = cell.summeryTV.text;
    cell.summeryTV.textColor = [UIColor blackColor ];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.tableView.frame;
        frame.origin.y = 0;
        self.tableView.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    [self.view endEditing:YES];
    
}


@end
