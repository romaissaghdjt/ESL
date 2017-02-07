//
//  PictureController.m
//  YY
//
//  Created by 赵洁 on 16/6/22.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PictureController.h"
#import "PictrueCell.h"
#import "LoginViewController.h"

@interface PictureController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong ,nonatomic)UIView *coverView;
@property (strong, nonatomic)UIImageView*img;
@property (strong, nonatomic) UIImageView *dropdownMenu;

@property (assign, nonatomic) NSInteger a;
@property (assign, nonatomic) NSInteger b;
@property (nonatomic)BOOL isselect;
@property (nonatomic, assign)BOOL isCool;
//@property (strong, nonatomic) DropdownMenu *menu ;
  @property (strong, nonatomic)UIButton *btn;
//  @property (strong, nonatomic)XHIndetController *XHindetC;
@property (nonatomic,strong)UIScrollView*mainScrollView;
@property (nonatomic,strong)UIButton *coolButton;
@property (nonatomic,strong)UIButton *HotButton;

@end

@implementation PictureController
- (void)dealloc
{
//    self.menu = nil;
//    self.XHindetC = nil;
    self.btn = nil;
    self.dropdownMenu = nil;
    self.img = nil;
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"套餐展示";
    _a = 1;
    _b = _ary.count-1;
    self.isselect = YES;
    self.view.backgroundColor = ZXColor(220, 220, 220, 1);
    //self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"50x40_02"] style:(UIBarButtonItemStylePlain) target:self action:@selector(Click)]];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    self.isCool = YES;
       _img.userInteractionEnabled = YES;
    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(KWIDTH/2-50, KHEIGHT-40, 200, 40)];
    lable.text = @"*图片仅供参考";
    lable.textColor = [UIColor redColor];
    [self.view addSubview:lable];
    
    [self addButton];
    [self AddScrollView];

}
- (void)addButton{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,94, KWIDTH/2, 4)];
    view.backgroundColor = ZXColor(66, 150, 19, 1);
    view.tag = 10;
    [self.view addSubview:view];
    UIButton *newButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    newButton .frame = CGRectMake(0, 62, KWIDTH/2, 30);
    [newButton setTitle:@"冷菜" forState:(UIControlStateNormal)];
    [newButton setTitleColor:[UIColor blueColor]forState:(UIControlStateHighlighted)];
    [newButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:newButton];
    self.coolButton = newButton;
    self.coolButton.enabled = NO;
   // [newButton addTarget:self action:@selector(NewButton) forControlEvents:(UIControlEventTouchUpInside)];
    UIButton *hotButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    hotButton .frame = CGRectMake(KWIDTH-newButton.width, 62, KWIDTH/2, 30);
    [hotButton setTitle:@"热菜" forState:(UIControlStateNormal)];
    [hotButton setTitleColor:[UIColor blueColor]forState:(UIControlStateHighlighted)];
    [hotButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:hotButton];
    self.HotButton = hotButton;
    self.HotButton.enabled = NO;
    //[hotButton addTarget:self action:@selector(hotButton) forControlEvents:(UIControlEventTouchUpInside)];
}
//- (void)hotButton
//{
//    if (self.isCool == YES) {
//        self.isCool = NO;
//        //self.mainScrollView.contentOffset = CGPointMake(KWIDTH, 0);
//        [self.collectionView reloadData];
//        
//    }
//    self.isCool = NO;
//    [self add];
//    
//    [self.collectionView reloadData];
//    [UIView animateWithDuration:0.6 animations:^{
//        UIView *view = [self.view viewWithTag:10];
//        CGRect temp = view.frame;
//        temp.origin.x = KWIDTH/2;
//        view.frame = temp;
//        
//        
//    }];
//    
//    
//}
//- (void)NewButton
//{
//    if (self.isCool == NO) {
//        self.isCool = YES;
//        self.mainScrollView.contentOffset = CGPointMake(0, 0);
//        [self.collectionView reloadData];
//    }
//     self.isCool = YES;
//     [self add];
//    [self.collectionView reloadData];
//    [UIView animateWithDuration:0.6 animations:^{
//        UIView *view = [self.view viewWithTag:10];
//        CGRect temp = view.frame;
//        temp.origin.x = 0;
//        view.frame = temp;
//        
//        
//    }];
//    
//}
- (void)AddScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 97, KWIDTH, KHEIGHT-138)];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.alwaysBounceHorizontal = NO;
    _mainScrollView.alwaysBounceVertical = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    _mainScrollView.contentSize = CGSizeMake(KWIDTH *2, KHEIGHT-138);
    [self add];
    [self.view addSubview:_mainScrollView];
    
    
}
- (void)add
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置参数
    //列间距
    flowLayout.minimumInteritemSpacing = 10;
    //行间距
    flowLayout.minimumLineSpacing = 10;
    //3.创建 CollectionViwe对象.
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-138) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [_mainScrollView addSubview:self.collectionView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainScrollView) {
        NSLog(@"111111bbbbbb");
        CGFloat x = scrollView.contentOffset.x;
        if (x > 0) {
            //[self hotButton];
            self.isCool = NO;
            [self add];
            CGRect temp = self.collectionView.frame;
            temp.origin.x = KWIDTH;
            self.collectionView.frame = temp;
            [UIView animateWithDuration:0.6 animations:^{
                UIView *view = [self.view viewWithTag:10];
                CGRect temp = view.frame;
                temp.origin.x = KWIDTH/2;
                view.frame = temp;
                
                
            }];
            
        }else{
            
            //[self NewButton];
            self.isCool = YES;
            [self add];
            //[self.collectionView reloadData];
            [UIView animateWithDuration:0.6 animations:^{
                UIView *view = [self.view viewWithTag:10];
                CGRect temp = view.frame;
                temp.origin.x = 0;
                view.frame = temp;
                
            }];
            
        }
    }
}

//- (void)Click
//{
//    [_coverView removeFromSuperview];
//    [self.dropdownMenu removeFromSuperview];
//    //@property (strong, nonatomic) DropdownMenu *menu ;
////MessageControllerDelegeta
//    _menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.y = 5;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    messageC.deleagte = self;
//    _menu.contentController = messageC;
//    [_menu showBFrom:self.view];
//    
//}
//- (void)dismiss:(NSIndexPath *)indexPath
//{
//    [_menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        
//    }else if (indexPath.row==1){
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
//        //  @property (strong, nonatomic)UIButton *btn;
//        //  @property (strong, nonatomic)XHIndetController *XHindetC;
//        _XHindetC = [[XHIndetController alloc]init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:_XHindetC];
//        
//        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_btn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [_btn setTintColor:ZXColor(83, 162, 38, 1)];
//        _btn.frame = CGRectMake(0, 0, 20, 20);
//        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
//        _XHindetC.navigationItem.leftBarButtonItem = leftItem;
//        
//        [self presentViewController:navigation animated:NO completion:nil];
//        
//    }
//}
- (void)click
{

}
//- (void)chanage:(UIBarButtonItem*)item
//{
//    [_menu dismiss];
//    [_coverView removeFromSuperview];
//    if (self.isselect == YES) {
//        self.dropdownMenu = [[UIImageView alloc]init];
//        self.dropdownMenu.userInteractionEnabled = YES;//开启交互功能
//        self.dropdownMenu.layer.cornerRadius = 10;
//        self.dropdownMenu.layer.masksToBounds = YES;
//        self.dropdownMenu.image = [UIImage imageNamed:@"喜事堂_03(2).png"];
//        self.dropdownMenu.frame = CGRectMake(KWIDTH-103,64, 100, 120);
//        self.dropdownMenu.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:self.dropdownMenu];
//        [self addButtonWithframe:CGRectMake(0, 0, self.dropdownMenu.width, 60) title:@"冷菜" tag:10];
//        [self addButtonWithframe:CGRectMake(0, 60, self.dropdownMenu.width, 60) title:@"热菜" tag:11];
//        //[self addButtonWithframe:CGRectMake(0, 80, self.dropdownMenu.width, 40) title:@"酒水" tag:12];
//        self.isselect = NO;
// 
//    }else
//    {
//        [self.dropdownMenu removeFromSuperview];
//        self.isselect = YES;
//    }
//}
//- (void)addButtonWithframe:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag
//{
//    ZJButton *bnt = [ZJButton buttonWithType:(UIButtonTypeCustom)
//                                       frame:frame
//                                       title:title
//                                       image:nil
//                                   textcolor:[UIColor blackColor]
//                                       click:^(UIButton *sender) {
//                                           if (tag == 10) {
//                                               self.isCool = YES;
//                                           }
//                                           else
//                                           {
//                                               self.isCool = NO;
//                                           }
//                                             self.isselect = YES;
//
//                                           [self.collectionView reloadData];
//                                           [self.dropdownMenu removeFromSuperview];
//                                       }];
//    bnt.backgroundColor = [UIColor lightGrayColor];
//    bnt.tag = tag;
//    [self.dropdownMenu addSubview:bnt];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.dropdownMenu removeFromSuperview];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isCool == YES) {
        return self.coolFoodArray.count;
    }
    else
    {
        return self.hotFoodArray.count;
    }
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"acell";

        [collectionView registerNib:[UINib nibWithNibName:@"PictrueCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"acell"];
        PictrueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    if (!cell) {
        cell = [[PictrueCell alloc]init];
    }
    DishModel *model = self.isCool ? self.coolFoodArray[indexPath.row] : self.hotFoodArray[indexPath.row];
    if ([model.ReplaceName isEqualToString:@""]) {
        cell.name.text = model.DishName;
        [cell.imga sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@"Replac_img.png"]];
    }else{
        cell.model = model;
    }
    cell.tag = 10+indexPath.row;
    cell.imga.layer.cornerRadius=6;
    cell.imga.layer.masksToBounds =YES;
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 93);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [_menu dismiss];
    PictrueCell *cell = [collectionView viewWithTag:10+indexPath.row];
    cell.imga.userInteractionEnabled = YES;
    _coverView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    _coverView.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:1 animations:^{
        _img = [[UIImageView alloc]init];
        _img.frame = CGRectMake(0, (KHEIGHT-200)/2, KWIDTH, 200);
        _img.image = cell.imga.image;
        _img.userInteractionEnabled = YES;
        [_coverView addSubview:_img];
        [self.view addSubview:_coverView];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]init];
        [tap2 addTarget:self action:@selector(tap2:)];
        _img.userInteractionEnabled = YES;
        [_coverView addGestureRecognizer:tap2];
    }];
}
- (void)tap2:(UITapGestureRecognizer*)cc
{
    [self.coverView removeFromSuperview];
    _img.userInteractionEnabled = YES;

    
}
@end
