
//
//  GuideViewController.m
//  YY
//
//  Created by 徐恒 on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "GuideViewController.h"
#import "XHTabBarController.h"

#define KIMAGE_COUNT 4
@interface GuideViewController ()<UIScrollViewDelegate,UITabBarControllerDelegate>
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIPageControl *pageControl;

@end
@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建一个scrollView
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(KWIDTH * KIMAGE_COUNT , 0);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0 ; i < KIMAGE_COUNT; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView .image = [UIImage imageNamed:[NSString stringWithFormat:@"%d(1242_2208).png",i + 1]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(KWIDTH * i, 0, KWIDTH , KHEIGHT);
        
        if (i == 3) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"立即起航" forState: UIControlStateNormal];
            button.backgroundColor = ZXColor(159, 202, 88, 1);
            button.frame = CGRectMake(KWIDTH * 0.5 - 83*SCREEN_SCALE, KHEIGHT * 0.5 + 213*SCREEN_DCALE, 173*SCREEN_SCALE,  47*SCREEN_DCALE);
            [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:button];
        }
      
        [self.scrollView addSubview:imageView];
    }
   
}
/**
 button的点击事件
 */
- (void)Click:(UIButton *)sender
{
    self.XHtabBar = [[XHTabBarController alloc]init];
    [self presentViewController:self.XHtabBar animated:YES completion:nil];
//    NSLog(@"点击了这里");
}
//配置分页滚动时UIPageControl也跟随变动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class] ]) {
    }else
    {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;// 当前是第几个视图
        self.pageControl.currentPage = index;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
