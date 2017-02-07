//
//  ESLReplaceViewController.h
//  ESL
//
//  Created by 赵洁 on 16/12/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESLReplaceViewDelegate <NSObject>

- (void)getdata:(NSInteger)row CilckIndex:(NSInteger)CilckIndex;

@end
@interface ESLReplaceViewController : UIViewController
@property (nonatomic,strong)NSArray*dataArray;
@property (nonatomic,assign)id<ESLReplaceViewDelegate>delegate;
@property (nonatomic,assign)NSInteger CilckIndex;
@end
