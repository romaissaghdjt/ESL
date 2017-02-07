//
//  HUDView.h
//  ffjjjfj
//
//  Created by 赵洁 on 16/11/22.
//  Copyright © 2016年 jie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OBLATE, 
    ROUND
} MODE;
@interface HUDView : UIView
@property (nonatomic,strong)UIView*BgView;
@property (nonatomic,strong)NSString*text;
@property (nonatomic)MODE type;
@property (nonatomic,strong)UIColor *color;
+ (HUDView*)sharedInstanceWithView:(UIView*)view;
//不带字的
- (void)showHUD;
- (void)hiddenHUD;
- (void)showOnlyTextHUD;
//带文字的缓冲条
- (void)showTextHUD;
//在你用的页面调用这个方法必须实现(不然第二次进去HUDView还是活的所以搞死他才能让他复活转起来)
- (void)destroy;
@end
