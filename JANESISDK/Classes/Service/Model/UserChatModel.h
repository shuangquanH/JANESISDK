//
//  UserChatModel.h
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserChatModel : NSObject
@property(nonatomic, copy)NSString *userId;//用户id
@property(nonatomic, copy)NSString *toUserId;//好友id
@property(nonatomic, copy)NSString *userModified;//用户聊天发送信息存储
@property(nonatomic, copy)NSString *userGmtModified;//用户聊天发送信息时间
@property(nonatomic, copy)NSString *toUserModified;//好友聊天发送信息时间
@property(nonatomic, copy)NSString *toUserGmtModified;//好友聊天发送信息存储
@property(nonatomic, assign)BOOL isVaild;//是否发送成功

@end
