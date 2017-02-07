//
//  StarController.h
//  YY
//
//  Created by 徐恒 on 16/7/5.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger,StarType){
    TeamType =0,
    StarsType =1,
    
};
@protocol StarControllerDelegeta<NSObject>

- (void)starControllerWithTapName:(NSString *)name type:(StarType)type;

@end

typedef void (^tapIndex)(NSString *);
@interface StarController : UITableViewController
@property (copy, nonatomic)tapIndex block;
//代理
@property (weak, nonatomic)id<StarControllerDelegeta> delegeta;
//type
@property (assign, nonatomic)StarType type;
@end
