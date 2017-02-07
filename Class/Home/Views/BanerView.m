
//
//  BanerView.m
//  YY
//
//  Created by 赵洁 on 16/8/9.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "BanerView.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "ESLSingleArrayModel.h"

#define UISCREENWIDTH  [UIScreen mainScreen].bounds.size.width
@interface BanerView ()
@property (nonatomic, strong)NSArray*ary;
@property (nonatomic, strong)DCPicScrollView  *picView1;
@end

@implementation BanerView

-(void)creatWithArray:(NSArray *)array
{
    WK(weakSelf)
    if (!array) {
        
    }
    [_picView1 removeFromSuperview];
    _picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,0,self.width, self.frame.size.height) WithImageUrls:array];
    _picView1.backgroundColor = [UIColor clearColor];
    [_picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
        [weakSelf.delegate topImageClick:index];
        printf("哎哟~~😳index:%zd\n",index);
    }];
    _picView1.AutoScrollDelay = 2.0f;
    
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    [self addSubview:_picView1];

}
@end
