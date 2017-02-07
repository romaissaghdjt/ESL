//
//  ESLBanerView.m
//  ESL
//
//  Created by 徐恒 on 8/11/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLBanerView.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"

#define UISCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define kHeight_SrcollVew 200* SCREEN_DCALE//轮播图高度

@interface ESLBanerView ()
@property (nonatomic, strong)NSArray*ary;
@end
@implementation ESLBanerView

- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)url Height:(CGFloat)Height
{
    
    if (self = [super initWithFrame:frame]) {
        [zJRequestManager requestWithUrl:url parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
            
            NSArray*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            DCPicScrollView  *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,0,self.width, Height) WithImageUrls:dic];
            
            picView1.backgroundColor = [UIColor clearColor];
            [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
                printf("你点到我了😳index:%zd\n",index);
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
            [self addSubview:picView1];
            
        } failedWithError:^(NSError *connectionError) {
            
        }];
    }
    return self;

}

@end
