//
//  ESLSingleFreashCell.m
//  ESL
//
//  Created by eyou on 16/11/10.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLSingleFreashCell.h"

@implementation ESLSingleFreashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopCartBtn.layer.cornerRadius = 20;
    self.shopCartBtn.layer.masksToBounds = YES;
}


@end
