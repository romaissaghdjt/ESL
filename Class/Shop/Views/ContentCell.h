//
//  ContentCell.h
//  ESL
//
//  Created by 徐恒 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLSureModel.h"
/*"RecvID":"16102716405901983392",
 "RecvTel":"18727823918",
 "RecvName":"ft ",
 "ProvinceName":"浙江省",
 "DistrictName":"宁波市",
 "CountyName":"鄞州区",
 "Details":"Charge"*/
@interface ContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *consignee;//收货人
@property (weak, nonatomic) IBOutlet UILabel *tel;//电话
@property (weak, nonatomic) IBOutlet UILabel *address;//地址
@property (strong , nonatomic)NSString *ProvinceName;//省
@property (strong , nonatomic)NSString *DistrictName;//市
@property (strong , nonatomic)NSString *CountyName;//区
@property (strong , nonatomic)NSString *RecvID;
@property (strong , nonatomic)NSString *Details;
@property (strong , nonatomic)ESLSureModel *Smodel;

@end
