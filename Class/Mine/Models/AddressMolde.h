//
//  AddressMolde.h
//  ESL
//
//  Created by 赵洁 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//dizhi

#import <Foundation/Foundation.h>

@interface AddressMolde : NSObject
@property (nonatomic,strong)NSString*Name;
@property (nonatomic,strong)NSString*ID;
@property (nonatomic,strong)NSString*address;
@property (nonatomic,strong)NSString*phone;

@property (nonatomic,assign)BOOL ischange;
//==============================
@property (nonatomic,strong)NSString*isDefault;
@property (nonatomic,strong)NSString*RecvID;
@property (nonatomic,strong)NSString*RecvTel;
@property (nonatomic,strong)NSString*RecvName;
@property (nonatomic,strong)NSString*ProvinceName;//省
@property (nonatomic,strong)NSString*DistrictName;//市
@property (nonatomic,strong)NSString*CountyName;//县
@property (nonatomic,strong)NSString*Details;
@property (nonatomic,strong)NSString*CountyID;


@end
