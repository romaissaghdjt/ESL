//
//  TeamChefsDetailsCell.h
//  YY
//
//  Created by 徐恒 on 16/6/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
/*团队厨师*/
@interface TeamChefsDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *num2;
@property (weak, nonatomic) IBOutlet UILabel *realName;
//@property (weak, nonatomic) IBOutlet UILabel *tel;
//@property (weak, nonatomic) IBOutlet UILabel *scoreID;
@property (weak, nonatomic) IBOutlet UILabel *NumberService;//服务数目

@property (weak, nonatomic) IBOutlet UILabel *bornDateTime;
@property (weak, nonatomic) IBOutlet UILabel *workingTime;
@property (weak, nonatomic) IBOutlet UILabel *goodAt;
//@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *maximum;
@property (weak, nonatomic) IBOutlet UILabel *address;//服务范围
@property (weak, nonatomic) IBOutlet UIImageView *Recommend;
@property (strong, nonatomic)NSString *CookGrpID;
@property (weak, nonatomic) IBOutlet UIImageView *NumberStars;//好评星数

@property (weak, nonatomic) IBOutlet UIImageView *StarLevel;//星级水平



@end
