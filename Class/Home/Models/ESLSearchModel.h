//
//  ESLSearchModel.h
//  ESL
//
//  Created by 徐恒 on 2016/12/22.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 ImageUrl = "http://ess.nbeysx.com/UploadFile/Data/_0100_Lengcai/_010049_muyudakao1.jpg";
 Name = "\U76ee\U9c7c\U5927\U70e4";
 PraiseRate = "0%";
 Price = "28.0000";
 ProductCgy = FeastSingle;
 ProductID = 235;
 Remark = "";
 */
@interface ESLSearchModel : NSObject
@property (strong, nonatomic)NSString *ImageUrl;
@property (strong, nonatomic)NSString *Name;
@property (strong, nonatomic)NSString *PraiseRate;
@property (strong, nonatomic)NSString *Price;
@property (strong, nonatomic)NSString *ProductCgy;
@property (strong, nonatomic)NSString *ProductID;
@property (strong, nonatomic)NSString *Remark;

@end
