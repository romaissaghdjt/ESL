//
//  ESLCuisineCell.h
//  ESL
//
//  Created by 徐恒 on 16/10/12.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLSingleProModel.h"
@interface ESLCuisineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *Name;//主菜名称
@property (weak, nonatomic) IBOutlet UILabel *Price;//主菜价格
//@property (weak, nonatomic) IBOutlet UILabel *mainFood;//主菜标
//配菜
//@property (weak, nonatomic) IBOutlet UILabel *Food;//副菜标
@property (weak, nonatomic) IBOutlet UIView *Reproduction;//底图
@property (weak, nonatomic) IBOutlet UILabel *SideDishes;
@property (weak, nonatomic) IBOutlet UILabel *DishesName;//配菜名称
@property (weak, nonatomic) IBOutlet UILabel *SubPrice;//配菜价格
@property (weak, nonatomic) IBOutlet UILabel *Count;//主配菜数量
@property (strong, nonatomic)ESLSingleProModel *Pmodel;
@property (nonatomic, copy)NSString *proID;
@property (nonatomic, strong)NSString *countA;
@property (strong , nonatomic)NSString *ID;
@property (strong , nonatomic)NSString *sunCount;
@end
