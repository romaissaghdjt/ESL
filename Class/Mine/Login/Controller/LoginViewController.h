//
//  LoginViewController.h
//  YY
//
//  Created by eyou on 16/4/20.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)dismiss;

@end
@interface LoginViewController : UIViewController

@property (nonatomic,assign)id<LoginViewControllerDelegate>delegate;
@end
