//
//  ESLFreashArrayModel.h
//  ESL
//
//  Created by eyou on 16/12/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FreashArrayPromoteModel,FreashArrayContentModel;

@interface ESLFreashArrayModel : NSObject

@property (nonatomic, strong) NSArray<FreashArrayContentModel *> *Content;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, strong) FreashArrayPromoteModel *Promote;

@end
@interface FreashArrayPromoteModel : NSObject
@property (nonatomic, copy)NSString *PublicityID;
@property (nonatomic, copy)NSString *ProductID;
@property (nonatomic, copy)NSString *ProductCgy;
@property (nonatomic, copy)NSString *ImageUrl;
@end

@interface FreashArrayContentModel : NSObject

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, copy) NSString *Norm;

@property (nonatomic, copy) NSString *Robberable;

@property (nonatomic, copy) NSString *IsSeasonal;

@property (nonatomic, copy) NSString *ProUnit;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Price;

@property (nonatomic, copy) NSString *ID;

@end

