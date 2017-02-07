//
//  ESLDefaultView.h
//  ESL
//
//  Created by eyou on 16/12/15.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESLDefaultViewDelegate <NSObject>

-(void)defaultViewBtnClick;

@end

@interface ESLDefaultView : UIView
@property (nonatomic, assign)id<ESLDefaultViewDelegate>delegate;
+(ESLDefaultView * )getDefaultView;
@end
