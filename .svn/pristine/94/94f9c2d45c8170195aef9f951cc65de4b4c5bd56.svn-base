//
//  ESLDisheView.m
//  ESL
//
//  Created by eyou on 16/11/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLDisheView.h"

@implementation ESLDisheView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 60, 60)];
        imageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:imageView];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 30, 30)];
        numLabel.layer.cornerRadius = 15;
        numLabel.layer.masksToBounds = YES;
        numLabel.backgroundColor = [UIColor redColor];
        [self addSubview:numLabel];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, self.width, 40)];
        [self addSubview:nameLabel];
    }
    return self;
}


@end
