//
//  ESLEditShopCartCell.h
//  ESL
//
//  Created by eyou on 16/11/21.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLShopCartModel.h"

@class ESLEditShopCartCell;

typedef enum
{
    SUBEDIT, ADDEDIT
}EDITTYPE;

@protocol ESLEditShopCartCellDelegate <NSObject>

-(void)editCellWithIndex:(NSIndexPath *)indexPath EditType:(EDITTYPE)type Cell:(ESLEditShopCartCell *)cell;

@end

@interface ESLEditShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countNum;
@property (weak, nonatomic) IBOutlet UIImageView *iconName;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, assign)id<ESLEditShopCartCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic, strong)NSIndexPath *indexPath;

-(void)setValueWithModel:(ShopCartContentModel *)model index:(NSIndexPath *)indexPath;
@end
