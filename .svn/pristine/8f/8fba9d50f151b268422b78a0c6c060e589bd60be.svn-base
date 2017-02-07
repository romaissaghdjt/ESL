//
//  ESLPrivateViewController.m
//  ESL
//
//  Created by eyou on 16/9/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLPrivateViewController.h"
#import "ESLFreashNetworkingManager.h"
#import "ESLSingleFreashCell.h"
#import "ESLFoodInfoViewController.h"
#import "UIView+HUD.h"
#import "ESLShopCartViewController.h"
@interface ESLPrivateViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)NSArray *FreashTypeArray;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, strong)NSArray *singleFreashArray;
@property (nonatomic, strong)UILabel *numLabel;
@property (nonatomic, copy)NSString *numCount;

@end

@implementation ESLPrivateViewController

-(NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if ([info boolForKey:@"succeed"]) {
        [ESLFreashNetworkingManager getShopCartCountWithUserTel:us UserPhyAdd:KUUID CompletionHandler:^(NSString *result, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"服务器繁忙" ViewController:self];
            }
            else{
                self.numCount = result;
                if (self.numCount.integerValue >= 100) {
                    self.numCount = @"99+";
                }
                self.numLabel.text = self.numCount;
                if ([result isEqualToString:@""]) {
                    self.numLabel.hidden = YES;
                }
            }
        }];
    }
    else
    {
        self.numLabel.hidden = YES;
    }
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = ZXColor(60, 170, 40, 1);
    
    //设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //隐藏返回主页的主页两字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ZXColor(255, 255, 255, 1);

    self.view.backgroundColor = [UIColor whiteColor];
    [self creatScrollView];
    [self creatCollectView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 104, KWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    UIButton *shoppingCart = nil;
    shoppingCart = [[UIButton alloc]initWithFrame:CGRectMake(-20, KHEIGHT-40-49, 60, 60)];
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, KHEIGHT-40-49, 20, 20)];
    shoppingCart.backgroundColor = ZXColor(100, 172, 56, 1);
    shoppingCart.layer.cornerRadius = 30;
    shoppingCart.layer.masksToBounds = YES;
    [shoppingCart setImage:[UIImage imageNamed:@"左下购物车"] forState:UIControlStateNormal];
    shoppingCart.layer.borderColor = [UIColor whiteColor].CGColor;
    shoppingCart.layer.borderWidth = 3;
    [shoppingCart addTarget:self action:@selector(gotoShopCart:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLabel.backgroundColor = [UIColor redColor];
    self.numLabel.layer.cornerRadius = 10;
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.font = [UIFont systemFontOfSize:10];
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:shoppingCart];
    [self.view addSubview:self.numLabel];
    
    [ESLFreashNetworkingManager getFreashTypeWithCompletionHandler:^(NSArray *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            self.FreashTypeArray = result;
            [self addViewInScrollView:self.FreashTypeArray];
        }
        if (!self.className) {
            self.className = self.FreashTypeArray.firstObject;
        }
        [ESLFreashNetworkingManager getSingleFreashWithClassName:self.className CompletionHandler:^(NSArray *result, NSError *error) {
            if (error) {
                [UIViewController showMessage:@"服务器繁忙" ViewController:self];
            }
            else
            {
                self.singleFreashArray = result;
                [self.collectView reloadData];
            }
        }];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)creatScrollView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 40)];
    [self.view addSubview:self.headerView];
}

-(void)addViewInScrollView:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        NSString *string = array[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*KWIDTH/array.count, 0, KWIDTH/array.count, 40)];
        [btn setTitle:string forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:ZXColor(87, 169, 0, 1) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 100 + i;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(i*KWIDTH/array.count, 38, KWIDTH/array.count, 2)];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.tag = 200 + i;
        
        [self.headerView addSubview:lineView];
        [self.headerView addSubview:btn];
        [self.btnArray addObject:btn];
        if (self.className) {
            if ([self.className isEqualToString:btn.titleLabel.text]) {
                btn.selected = YES;
                lineView.backgroundColor = ZXColor(87, 169, 0, 1);
            }
        }
        else
        {
            if (btn.tag == 100) {
                btn.selected = YES;
                lineView.backgroundColor = ZXColor(87, 169, 0, 1);
            }
        }
        
    }
}

-(void)btnClick:(UIButton *)sender
{
    [ESLFreashNetworkingManager getSingleFreashWithClassName:sender.titleLabel.text CompletionHandler:^(NSArray *result, NSError *error) {
        if (error) {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            [self.collectView setContentOffset:CGPointMake(0, 0) animated:YES];
            self.singleFreashArray = result;
            [self.collectView reloadData];
        }
    }];
    for (int i = 0; i < self.FreashTypeArray.count; i++) {
        UIButton *btn = [self.headerView viewWithTag:100+i];
        UIView *lineView = [self.headerView viewWithTag:200+i];
        if (sender.tag == 100 + i) {
            btn.selected = YES;
            lineView.backgroundColor = ZXColor(87, 169, 0, 1);
        }
        else
        {
            btn.selected = NO;
            lineView.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(void)creatCollectView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake((KWIDTH - 30)/2, (KWIDTH - 30)/2 + 60);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 50, 10);
    
    self.title = @"全部";
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 105, KWIDTH, KHEIGHT - 105 - 49) collectionViewLayout:flowLayout];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = ZXColor(236, 236, 236, 1);
    [self.view addSubview:self.collectView];

    [self.collectView registerNib:[UINib nibWithNibName:@"ESLSingleFreashCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:@"ESLSingleFreashCell"];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singleFreashArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESLSingleFreashModel *model = self.singleFreashArray[indexPath.row];
    ESLSingleFreashCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESLSingleFreashCell" forIndexPath:indexPath];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    cell.nameLabel.text = model.name;
    if ([model.isSeasonal isEqualToString:@"1"]) {
        cell.signImage.hidden = NO;
    }
    else
    {
        cell.signImage.hidden = YES;
    }
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.02lf", [model.price floatValue]];
    cell.unitLabel.text = [NSString stringWithFormat:@"%@/%@",model.norm, model.proUnit];
    cell.shopCartBtn.tag = indexPath.row;
    [cell.shopCartBtn addTarget:self action:@selector(shoppingCartClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESLSingleFreashModel *model = self.singleFreashArray[indexPath.row];
    ESLFoodInfoViewController *fivc = [[ESLFoodInfoViewController alloc]init];
    fivc.type = FREASH;
    fivc.isFromRob = NO;
    ESLBuyModel *buyModel = [[ESLBuyModel alloc]init];
    buyModel.productID = model.ID;
    fivc.buyModel = buyModel;
    [self.navigationController pushViewController:fivc animated:YES];
}

-(void)shoppingCartClick:(UIButton *)sender
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"succeed"]) {
        LoginViewController*login = [[LoginViewController alloc] init];
        login.delegate = self;
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }
    ESLSingleFreashModel *model = self.singleFreashArray[sender.tag];
    [ESLFreashNetworkingManager getJoinShopCartWithUserTel:us UserPhyAdd:KUUID ProID:model.ID CompletionHandler:^(NSString *result, NSError *error) {
        if(error)
        {
            [UIViewController showMessage:@"服务器繁忙" ViewController:self];
        }
        else
        {
            [self.view showWarning:result];
            if([result isEqualToString:@"添加成功"])
            {
                self.numLabel.hidden = NO;
                self.numCount = [NSString stringWithFormat:@"%ld", [self.numCount integerValue]+1];
                if (self.numCount.integerValue >= 100) {
                    self.numCount = @"99+";
                }
                self.numLabel.text = self.numCount;
                [UIView animateWithDuration:0.5 animations:^{
                    self.numLabel.transform = CGAffineTransformMakeScale(1.5, 1.5);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.numLabel.transform = CGAffineTransformMakeScale(1, 1);
                    }];
                }];
            }
        }
    }];
    
}

-(void)gotoShopCart:(UIButton *)sender
{
    self.tabBarController.selectedIndex=2;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
