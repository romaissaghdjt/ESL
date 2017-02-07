//
//  FourButtonModel.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "FourImage.h"

@implementation FourImage
-(void)setValueWithArray:(NSArray *)array
{
    self.imageUrl1 = array[0][@"Image"];
    self.imageType1 = array[0][@"Type"];
    self.imageUrl2 = array[1][@"Image"];
    self.imageType2 = array[1][@"Type"];
    self.imageUrl3 = array[2][@"Image"];
    self.imageType3 = array[2][@"Type"];
    self.imageUrl4 = array[3][@"Image"];
    self.imageType4 = array[3][@"Type"];
}
@end
