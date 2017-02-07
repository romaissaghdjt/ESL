//
//  TwoButtonModel.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "TwoImage.h"

@implementation TwoImage
-(void)setValueWithArray:(NSArray *)array
{
    self.imageUrl1 = array[0][@"Image"];
    self.imageType1 = array[0][@"Type"];
    self.imageUrl2 = array[1][@"Image"];
    self.imageType2 = array[1][@"Type"];
}
@end
