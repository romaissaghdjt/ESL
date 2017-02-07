//
//  PhotoSController.h
//  YY
//
//  Created by 赵洁 on 16/7/15.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MYBLOCK)(UIImageView *imageView);
@protocol PhotoSControllerDelegate <NSObject>

- (void)getImagView:(UIImageView*)Imagview;

@end

@interface PhotoSController : UIViewController
@property (nonatomic, strong)id<PhotoSControllerDelegate>delegate;
@property (nonatomic, strong)NSString*path;//路劲
@property (nonatomic,strong)NSString *str;//文件名
@property (nonatomic, copy)MYBLOCK myblock;
@end
