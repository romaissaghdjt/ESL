
//
//  FoodHeaderView.m
//  ESL
//
//  Created by eyou on 16/9/28.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FoodHeaderView.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"



@implementation FoodHeaderView

- (instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    if (self = [super initWithFrame:frame]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // switch to a background thread and perform your expensive operation
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // switch back to the main thread to update your UI
                
            });
            
        });
        NSLog(@"%lu", (unsigned long)array.count);
            DCPicScrollView  *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,0,self.width, frame.size.height) WithImageUrls:array];
            
            picView1.backgroundColor = [UIColor clearColor];
            [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
                printf("你点到我了😳index:%zd\n",index);
            }];
            picView1.AutoScrollDelay = 0.0f;
            
            //下载失败重复下载次数,默认不重复,
            [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
            
            //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
            //error错误信息
            //url下载失败的imageurl
            [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
                NSLog(@"%@",error);
            }];
            [self addSubview:picView1];

    }
    return self;
}
@end

