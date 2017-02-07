//
//  ESLHomeCategoryDelegate.h
//  ESL
//
//  Created by eyou on 16/12/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ESLHomeCategoryDelegate <NSObject>
-(void)clickCategoryButtonWithCellTag:(NSInteger)cellIndex BtnTag:(NSInteger)btnIndex;
@end
