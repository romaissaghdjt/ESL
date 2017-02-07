//
//  InstanceLeftCell.m
//  YY
//
//  Created by 徐恒 on 16/5/25.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "InstanceLeftCell.h"

@implementation InstanceLeftCell


- (void)setModel:(CaseModle *)model
{
    self.Title.text = model.Name;
}
@end
