//
//  InfoOrderViewController.m
//  ESL
//
//  Created by eyou on 16/10/18.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "InfoOrderViewController.h"
#import "ESLFoodTitleCell.h"
#import "ESLMyNetworkingManager.h"
#import "ESLDishCell.h"

@interface InfoOrderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)NSArray *listArray;
@property (nonatomic, strong)UICollectionView *collectView;
@end

@implementation InfoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCollectView];
    [ESLMyNetworkingManager getCookerOrderInfoWithUserTel:us UserPhyAdd:KUUID OrderID:self.cookOrderModel.orderID CompletionHandler:^(NSArray *array, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.listArray = array;
            [self.collectView reloadData];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatCollectView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //1.1设置大小
    flowLayout.itemSize=CGSizeMake(74, 100);
    //1.2设置列间距(注意如果给定距离的间距,无法满足屏幕宽度,设置无效)
    flowLayout.minimumInteritemSpacing=0;
    float spacingCount = (KWIDTH - 4*74)/5.0;
    //1.3设置行间距
    flowLayout.minimumLineSpacing = spacingCount;
    //1.4设置滑动方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //1.7设置内边距
    flowLayout.sectionInset=UIEdgeInsetsMake(15, (KWIDTH - 4*74)/5.0, 15, (KWIDTH - 4*74)/5.0);
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) collectionViewLayout:flowLayout];
    self.collectView.showsVerticalScrollIndicator = NO;
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"ESLDishCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"dishCell"];
    CookerOrderInfoModel *model = self.listArray[indexPath.row];
    ESLDishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dishCell" forIndexPath:indexPath];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    cell.nameLabel.text = model.name;
    cell.numLabel.text = model.count;
    return cell;
}




@end
