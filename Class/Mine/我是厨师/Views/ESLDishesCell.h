//
//  ESLDishesCell.h
//  ESL
//
//  Created by eyou on 16/11/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLDishesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *numLabel1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *numLabel2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *numLabel3;
@property (weak, nonatomic) IBOutlet UILabel *nameLebel3;

@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UILabel *numLabel4;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel4;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint4;

@end
