//
//  ESLConfirmBottomView.h
//  ESL
//
//  Created by 徐恒 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLConfirmBottomView : UIView
@property (strong, nonatomic)UILabel *totalPrice;//总价
@property (strong, nonatomic)UIButton *submit;//提交订单
@property (strong, nonatomic)UILabel *freightLab;//邮寄费用
@property (strong, nonatomic)UILabel *combinedLab;//合计
@property (strong, nonatomic)UIButton *submitBtn;//提交订单
@end
