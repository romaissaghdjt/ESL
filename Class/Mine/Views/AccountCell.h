//
//  AccountCell.h
//  ESL
//
//  Created by 徐恒 on 16/9/23.
//  Copyright © 2016年 cl. All rights reserved.
// 个人信息

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *userAccountLable;
@property (strong, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end
