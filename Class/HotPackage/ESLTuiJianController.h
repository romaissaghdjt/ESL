//
//  ESLTuiJianController.h
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastAllModel.h"

typedef void(^Block)(id ID);

@interface ESLTuiJianController : UIViewController
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSArray*arr;
@property (nonatomic,copy)Block Block;
@end
