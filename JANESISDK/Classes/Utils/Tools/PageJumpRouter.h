//
//  PageJumpRouter.h
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageJumpRouter : NSObject

+ (void)jumpToLoginPage;
+ (void)jumpToMainPage;
+ (void)pushToViewControllerWithProperty:(NSDictionary *)params;
+ (void)pushToViewControllerWithProperty:(NSDictionary *)params viewController:(UIViewController *)view;
+ (void)presentToViewControllerWithProperty:(NSDictionary *)params;

@end
