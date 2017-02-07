//
//  ESLTitleCell.h
//  ESL
//
//  Created by eyou on 17/1/4.
//  Copyright © 2017年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButtonDelegate.h"

@interface ESLTitleCell : UITableViewCell
@property (strong, nonatomic)UIButton *btn1;
@property (strong, nonatomic)UIButton *btn2;
@property (strong, nonatomic)UIButton *btn3;
@property (strong, nonatomic)UIButton *btn4;
@property (nonatomic, assign)id<HomeButtonDelegate>delegate;
-(void)creatTitleCell;
@end
