//
//  ESLPayModel.h
//  ESL
//
//  Created by eyou on 16/12/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESLPayModel : NSObject
@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, copy)NSString *nameText;
@property (nonatomic, copy)NSString *describeName;
@property (nonatomic, assign)BOOL btnIsSelect;
+(NSArray *)getPayList;
@end
