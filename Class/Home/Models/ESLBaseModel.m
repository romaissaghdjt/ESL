//
//  ESLBaseModel.m
//  ESL
//
//  Created by eyou on 16/9/20.
//  Copyright © 2016年 cl. All rights reserved.
//
#import "OneImage.h"
#import "TwoImage.h"
#import "ThreeImage.h"
#import "FourImage.h"

@implementation ESLBaseModel
//根据字典内提供的数据分别创建出其对应的model来获取数据

+ (instancetype)initWithArray:(NSArray *)array {
    
//    先使用当前类(父类)创建出model对象
    
    ESLBaseModel *model = nil;
    
    
//    根据字典中key对应的数据初始化不同的子类对象并将其返回给我们的父类
    
    if (array.count == 1) {
        
        model = [[OneImage alloc]init];
        
        [(OneImage *)model setValueWithArray:array];
        
    }else if (array.count == 2) {
        
        
        model = [[TwoImage alloc]init];
        [(TwoImage *)model setValueWithArray:array];
        
    }else if (array.count == 3) {
        
        
        model = [[ThreeImage alloc]init];
        [(ThreeImage *)model setValueWithArray:array];
    }
    else if(array.count == 4)
    {
        model = [[FourImage alloc]init];
        [(FourImage *)model setValueWithArray:array];
    }
    
    
    return model;
    
}
@end
