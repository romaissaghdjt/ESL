//
//  ShowDitallBottmView.h
//  YY
//
//  Created by 赵洁 on 16/6/24.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowDitallBottmViewDelegate <NSObject>
-(void)reservationClick;
@end

@interface ShowDitallBottmView : UIView
@property (nonatomic,strong)UIButton *YDButton;
@property (nonatomic,strong)UILabel *PriceLable;
@property (nonatomic, assign)id<ShowDitallBottmViewDelegate>delgate;
@end
