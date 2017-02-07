//
//  WeddingController.m
//  YY
//
//  Created by 赵洁 on 16/7/4.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "WeddingController.h"
#import "WeddingCell.h"
#import "FeastListController.h"
#import "PrivateMadeController.h"
#import "RecreationkindController.h"
#import "WeddingModel.h"
#import "FeastShowController.h"
#import "ESLBanerView.h"
#import "ESLWeddingDressController.h"
#import "CarController.h"

#define kHeight_SrcollVew 230* SCREEN_DCALE//轮播图高度
@interface WeddingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView*tableView;
@property (nonatomic, strong)NSMutableArray*array;
@end

@implementation WeddingController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    

}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"甬尚鲜婚庆";
    self.tabBarController.tabBar.hidden= YES;

    [self creatTablewView];
    [self creat];
}
#pragma mark - Table view data source
- (void)creat
{
    UIView*bb = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, kHeight_SrcollVew)];
    [self.view addSubview:bb];
    NSString*url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpQueryWiddingTopPictrue"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSArray*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        DCPicScrollView  *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,0,KWIDTH,kHeight_SrcollVew ) WithImageUrls:dic];
        picView1.backgroundColor = [UIColor clearColor];
        [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("哎哟~~~😳index:%zd\n",index);
        }];
        picView1.AutoScrollDelay = 2.0f;
        
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        
        //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
        //error错误信息
        //url下载失败的imageurl
        [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
            NSLog(@"%@",error);
        }];
        [bb addSubview:picView1];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)creatTablewView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KHEIGHT-(KHEIGHT-(kHeight_SrcollVew+10)), KWIDTH, KHEIGHT-kHeight_SrcollVew) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight =KHEIGHT-kHeight_SrcollVew-70;
    
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"WCell";
    WeddingCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"WeddingCell" owner:nil options:nil].lastObject;
    }

    cell.HQButton.layer.cornerRadius = 10;
    cell.HQButton.layer.masksToBounds = YES;
    [cell.HQButton addTarget:self action:@selector(LeftTopButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.SRButton.layer.cornerRadius = 10;
    cell.SRButton.layer.masksToBounds = YES;

    [cell.SRButton addTarget:self action:@selector(RightTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.GeWButton.layer.cornerRadius = 10;
    cell.GeWButton.layer.masksToBounds = YES;

    [cell.GeWButton addTarget:self action:@selector(LeftBottmButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.GeWButton.tag = 100;
    cell.QDButton.layer.cornerRadius = 10;
    cell.QDButton.layer.masksToBounds = YES;

    [cell.QDButton addTarget:self action:@selector(LeftBottmButton:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.QDButton.tag = 101;
    cell.HSButton.layer.cornerRadius = 10;
    cell.HSButton.layer.masksToBounds = YES;

    [cell.HSButton addTarget:self action:@selector(HSButton) forControlEvents:(UIControlEventTouchUpInside)];
    cell.HSButton.tag = 102;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.huncheButton.layer.cornerRadius = 10;
    cell.huncheButton.layer.masksToBounds = YES;
    [cell.huncheButton addTarget:self action:@selector(huncheBnt) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
    
}

- (void)LeftTopButton
{
    FeastListController *feastVC= [[FeastListController alloc]init];
    
    [self.navigationController pushViewController:feastVC animated:YES];
}
- (void)RightTopButton:(UIButton*)sender
{
    FeastShowController *PrvateVC = [[FeastShowController alloc]init];
    PrvateVC.str = @"私人订制";
    
    
    [self.navigationController pushViewController:PrvateVC animated:YES];
}
//婚车
- (void)huncheBnt
{
    
    CarController *RecrVC = [[CarController alloc]init];
    [self.navigationController pushViewController:RecrVC animated:YES];
    
}
- (void)LeftBottmButton:(UIButton*)sender
{
    RecreationkindController *RecrVC = [[RecreationkindController alloc]init];
    if (sender.tag == 100) {
        RecrVC.str = @"歌舞演艺";
    }else if (sender.tag == 101)
    {
        RecrVC.str = @"庆典礼仪";
    }
    
    [self.navigationController pushViewController:RecrVC animated:YES];
}
- (void)RightBottmButton
{
    RecreationkindController *RecrVC = [[RecreationkindController alloc]init];
    [self.navigationController pushViewController:RecrVC animated:YES];
}
- (void)HSButton
{
    ESLWeddingDressController *wdVC = [[ESLWeddingDressController alloc]init];
    [self.navigationController pushViewController:wdVC animated:YES];
}
@end
