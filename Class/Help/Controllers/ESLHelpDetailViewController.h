//
//  ESLFeastDetailViewController.h
//  ESL
//
//  Created by 赵洁 on 16/9/29.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastAllModel.h"
#import "ESLHelpModel.h"
@interface ESLHelpDetailViewController : UIViewController
@property (nonatomic,strong)ESLHelpModel *Allmodel;
@property (strong, nonatomic)NSString *ProId;//收藏界面传过来的 ID
@property (strong, nonatomic)NSMutableArray *FeastDetailArray;//收藏界面传过来的数组
@end
