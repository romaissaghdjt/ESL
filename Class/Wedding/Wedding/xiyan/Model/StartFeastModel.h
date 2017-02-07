//
//  StartFeastModel.h
//  YY
//
//  Created by 赵洁 on 16/6/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StartFeastModel : NSObject
@property (strong, nonatomic) NSString *ImageUrl;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *SetMealID;//套餐ID
@property (nonatomic,strong)NSString *TotalPrice;
@end
