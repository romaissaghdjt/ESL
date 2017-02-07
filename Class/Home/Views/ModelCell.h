//
//  ModelCell.h
//  ESL
//
//  Created by eyou on 16/10/17.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButtonDelegate.h"
#import "ESLBaseModel.h"

@interface ModelCell : UITableViewCell
@property (nonatomic, assign)id<HomeButtonDelegate>delegate;
-(void)initContentWithStr:(NSString *)string;
-(void)setBaseModel:(ESLBaseModel *)model;
@end
