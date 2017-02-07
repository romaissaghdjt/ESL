//
//  OneButtonModel.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "OneImage.h"

@implementation OneImage
-(void)setValueWithArray:(NSArray *)array
{
    self.imageUrl1 = array[0][@"Image"];
    self.imageType1 = array[0][@"Type"];
}
@end
