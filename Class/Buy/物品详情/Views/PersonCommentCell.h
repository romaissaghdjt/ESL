//
//  PersonCommentCell.h
//  ESL
//
//  Created by eyou on 16/9/30.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *oneStar;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
@property (weak, nonatomic) IBOutlet UILabel *telNum;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
