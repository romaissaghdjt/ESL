//
//  BanerView.h
//  YY
//
//  Created by 赵洁 on 16/8/9.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BanerViewDelegate <NSObject>

-(void)topImageClick:(NSInteger)index;

@end

@interface BanerView : UIView
@property (nonatomic, assign)id<BanerViewDelegate>delegate;

-(void)creatWithArray:(NSArray *)array;
@end
