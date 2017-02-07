//
//  ESLSureModel.h
//  ESL
//
//  Created by 徐恒 on 21/10/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESLSureModel : NSObject
@property (strong , nonatomic)NSString *RecvID;
@property (strong , nonatomic)NSString *RecvTel;
@property (strong , nonatomic)NSString *RecvName;
@property (strong , nonatomic)NSString *ProvinceName;
@property (strong , nonatomic)NSString *DistrictName;
@property (strong , nonatomic)NSString *CountyName;
@property (strong , nonatomic)NSString *Details;
@end