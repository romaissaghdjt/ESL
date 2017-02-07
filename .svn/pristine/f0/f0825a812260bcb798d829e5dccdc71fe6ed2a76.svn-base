//
//  ESLEvaluateCell.h
//  ESL
//
//  Created by 徐恒 on 12/11/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrederSubModel.h"
typedef void(^cellTextViewTxBlock)(NSString*str);
@class ESLEvaluateCell;
@protocol ESLEvaluateCellDelegate <NSObject>

- (void)getcell:(ESLEvaluateCell*)cell;
- (void)recovercell:(ESLEvaluateCell*)cell;
@end
@interface ESLEvaluateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *oneStartBnt;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIButton *towStartBnt;
@property (weak, nonatomic) IBOutlet UIButton *threeStarBnt;
@property (weak, nonatomic) IBOutlet UIButton *frouStartBnt;
@property (weak, nonatomic) IBOutlet UIButton *fiveStartBnt;
@property (strong,nonatomic)NSIndexPath*indexPath;
@property (weak, nonatomic) IBOutlet UITextView *summeryTV;
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UIButton *sumbitBnt;
@property (strong ,nonatomic)MyOrederSubModel*smodle;
@property (copy, nonatomic)cellTextViewTxBlock cellTextViewTxBlock;
@property (nonatomic,assign)id<ESLEvaluateCellDelegate>delegate;
@end
