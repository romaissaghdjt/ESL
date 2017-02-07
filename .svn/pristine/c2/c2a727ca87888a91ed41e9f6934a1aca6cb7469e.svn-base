//
//  ESLMyCollectionCell.h
//  ESL
//
//  Created by 徐恒 on 2016/11/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionModel.h"
typedef void(^buttonBlock)(NSIndexPath *indepath);

@interface ESLMyCollectionCell : UITableViewCell
@property (strong, nonatomic)UIButton *ChooseBtn;
@property (strong, nonatomic)UIImageView *Icon;
@property (strong, nonatomic)UILabel *Name;
@property (strong, nonatomic)UILabel *Price;
@property (strong, nonatomic)NSString *ProId;
@property (strong, nonatomic)NSString *ProductCgy;

@property (nonatomic,copy)buttonBlock butBlock;
@property (nonatomic,strong)NSIndexPath *indexpath;
@property (strong, nonatomic)MyCollectionModel *model;
@end
