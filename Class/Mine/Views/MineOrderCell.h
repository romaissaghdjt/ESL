//
//  MineOrderCell.h
//  ESL
//
//  Created by 赵洁 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrederSubModel.h"
@interface MineOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *productNameLable;
@property (strong, nonatomic) IBOutlet UILabel *producTotalPriceLable;
@property (strong, nonatomic) IBOutlet UILabel *PeCLable;
@property (strong, nonatomic) IBOutlet UILabel *peCaNameLable;
@property (strong, nonatomic) IBOutlet UILabel *PecaTotalPriceLable;
@property (strong, nonatomic) IBOutlet UILabel *productCountLable;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic,strong)MyOrederSubModel*smodel;
@end
