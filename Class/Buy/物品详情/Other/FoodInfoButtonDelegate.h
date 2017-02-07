//
//  FoodInfoButtonDelegate.h
//  ESL
//
//  Created by eyou on 16/10/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FoodInfoButtonDelegate <NSObject>
@optional
-(void)buttonClickWithButton:(UIButton *)sender Type:(NSString *)type;
-(void)GotoBuyClick:(NSArray *)array MainCount:(NSString *)mainCount;
-(void)addShopCartClick:(NSArray *)array MainCount:(NSString *)mainCount;
@end
