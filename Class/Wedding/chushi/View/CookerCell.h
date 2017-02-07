//
//  CookerCell.h
//  YY
//
//  Created by eyou on 16/4/27.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CookerCell : UITableViewCell
/*个人厨师*/
@property (strong, nonatomic)NSString *pkCookIDA;
@property (strong, nonatomic)NSString *fkStarLevelIDB;
@property (weak, nonatomic) IBOutlet UIImageView *image1;//头像
@property (weak, nonatomic) IBOutlet UILabel *name;//名字
@property (weak, nonatomic) IBOutlet UILabel *gender;//性别
@property (weak, nonatomic) IBOutlet UILabel *age;//年龄
@property (weak, nonatomic) IBOutlet UILabel *cookAge;//厨龄
//@property (weak, nonatomic) IBOutlet UILabel *tel;//电话
@property (weak, nonatomic) IBOutlet UILabel *cuisine;//菜系
//@property (weak, nonatomic) IBOutlet UILabel *offer;//报价
@property (weak, nonatomic) IBOutlet UILabel *largestOrder;//最大接单能力
//@property (weak, nonatomic) IBOutlet UILabel *address;//住址
@property (weak, nonatomic) IBOutlet UILabel *serviceScope;//服务范围

@property (weak, nonatomic) IBOutlet UILabel *numberService;//服务数目
@property (weak, nonatomic) IBOutlet UIImageView *imgView;//甬尚鲜推介
@property (weak, nonatomic) IBOutlet UIImageView *starLevel;//星级水平

@property (weak, nonatomic) IBOutlet UIImageView *praiseStar;//好评星数
@end
