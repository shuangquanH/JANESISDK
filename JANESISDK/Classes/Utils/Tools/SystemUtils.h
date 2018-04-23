//
//  SystemUtils.h
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@class UserChatModel;
@interface SystemUtils : NSObject

+ (void)hideKeyboard;
+ (BOOL)userIsLogin;
+ (UserInfo *)getUserData;
+ (BOOL)readUserLoginTager;
+ (void)updateUserLoginTager:(BOOL)flag;

//系统消息相关
+ (BOOL)systemMessIsExist;
+ (NSArray *)querySystemMess;
+ (void)addSystemMess:(UserChatModel *)chatModel;
+ (void)removeSystemMess;
@end
