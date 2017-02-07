//
//  ViceView.h
//  ESL
//
//  Created by eyou on 16/10/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodInfoButtonDelegate.h"

@interface ViceView : UIView
@property (nonatomic, assign)id<FoodInfoButtonDelegate>delegate;
@property (nonatomic, strong)NSMutableArray *labelArray;
-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array;
@end
