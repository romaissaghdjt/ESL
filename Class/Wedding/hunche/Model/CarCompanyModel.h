//
//  CarCompanyModel.h
//  YY
//
//  Created by 陈龙 on 16/5/31.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarCompanyModel : NSObject
@property (nonatomic, strong)NSNumber *pkCompanyID;
@property (nonatomic, copy)NSString *CompanyName;
@property (nonatomic, copy)NSString *Adr;
@property (nonatomic, copy)NSString *LegalPerson;
@property (nonatomic, copy)NSString *Principal;
@property (nonatomic, copy)NSString *PrincipalTel;
@property (nonatomic, copy)NSString *ImgBLUrl;
@property (nonatomic, copy)NSString *ImgOCCUrl;
@property (nonatomic, copy)NSString *ImgPTEAAUrl;
@property (nonatomic, copy)NSString *ImgTRCUrl;
@property (nonatomic, strong)NSNumber *fkStatusID;
@property (nonatomic, copy)NSString *Scope;
@property (nonatomic, strong)NSNumber *fkCompanyCgyID;
@property (strong, nonatomic)NSString *Summary;//公司概要
@end
