//
//  ESLShopCartHeaderCell.h
//  ESL
//
//  Created by eyou on 16/11/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESLShopCartHeaderCellDelegate <NSObject>

-(void)headerCellSelectBtnClick:(NSInteger)indexPathSection Button:(UIButton *)sender;

@end

@interface ESLShopCartHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign)NSInteger indexPathSection;
@property (nonatomic, assign)id<ESLShopCartHeaderCellDelegate>delegate;

@end
