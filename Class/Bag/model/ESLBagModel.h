//
//  ESLBagModel.h
//  ESL
//
//  Created by eyou on 17/1/18.
//  Copyright © 2017年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ESLBagBaseDateModel;

@interface ESLBagModel : NSObject
@property (nonatomic, strong) ESLBagBaseDateModel *BaseDate;

@property (nonatomic, copy) NSString *Content;

@end
@interface ESLBagBaseDateModel : NSObject
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *ImageUrl;
@property (nonatomic, copy)NSString *Name;
@property (nonatomic, copy)NSString *Price;
@property (nonatomic, copy)NSString *Sales;
@property (nonatomic, copy)NSString *Feature;
@end

