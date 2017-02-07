//
//  ESLDishCell.m
//  ESL
//
//  Created by eyou on 16/12/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLDishCell.h"

@implementation ESLDishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numLabel.layer.cornerRadius = 10;
    self.numLabel.layer.masksToBounds = YES;
}

@end
