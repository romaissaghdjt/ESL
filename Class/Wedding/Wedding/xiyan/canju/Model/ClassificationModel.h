//
//  ClassificationModel.h
//  YY
//
//  Created by 徐恒 on 16/6/25.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassificationModel : NSObject
@property (strong, nonatomic)NSString *Name;
@property (strong, nonatomic)NSString *StarLevel;
@property (strong, nonatomic)NSString *Price;
@property (strong, nonatomic)NSString *ImageUrl;
/*
 "Name":"一次性碗筷",
 "StarLevel":"3",
 "Price":"100",
 "ImageUrl":"http://emm.nbeykj.com/"*/
@end
