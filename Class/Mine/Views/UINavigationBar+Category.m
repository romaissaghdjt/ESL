//
//  UINavigationBar+Category.m
//  ESL
//
//  Created by 赵洁 on 16/10/27.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "UINavigationBar+Category.h"
//#import <objc/objc-runtime.h>
@implementation UINavigationBar (Category)
+(void)load
{
    Method a = class_getInstanceMethod(self, @selector(navigationBar:shouldPopItem:));
    Method b = class_getInstanceMethod(self, @selector(mynavigationBar:shouldPopItem:));
    method_exchangeImplementations(a, b);
}
- (BOOL)mynavigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    return NO;
    
}
@end
