//
//  JSTFServerApi.h
//  JSTempFun
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#ifndef JSTFServerApi_h
#define JSTFServerApi_h

//#define JSTF_API_BASE_HOST @"http://118.25.10.151:8899"
#define JSTF_API_BASE_HOST @"http://peanut.janesi.com"

/* User 用户相关 */
#define JSTF_API_USER_Phone_Verify @"/app/peanut/user/iphone_verify"
#define JSTF_API_USER_LOGIN @"/app/peanut/user/login"
#define JSTF_API_USER_PHOTO_UPLOAD @"/app/peanut/user/photo"
#define JSTF_API_USER_LOGIN_UPDATE @"/app/peanut/user/save"
#define JSTF_API_USERINFO_DETAIL @"/app/peanut/user/user_id"
#define JSTF_API_USERINFO_UPDATE @"/app/peanut/user/save_user"

/* 反馈相关 */
#define JSTF_API_USERINFO_FEEDBACK @""

/* 推送相关 */
#define JSTF_API_USER_PUSH @"/app/peanut/user/push"
#define JSTF_API_USER_PUSH_EDIT @"/app/peanut/user/edit"

/* 标签相关   */
#define JSTF_API_USERINFO_TAG @"/app/peanut/user/user_id/label"
#define JSTF_API_USERINFO_TAG_ADD @"/app/peanut/user/user_id/label_name"
/* 用户操作相关   */
#define JSTF_API_USER_FRIEND @"/app/peanut/user/friend/add"

/* 用户匹配相关 */
#define JSTF_API_USER_MATCH_NEAR_LIST @"/app/peanut/nearby/people_nearby"

/* 用户聊天相关   */
#define JSTF_API_USER_MESS_LIST @"/app/peanut/user/content_list"
#define JSTF_API_USER_MESS_DELETE @"/app/peanut/user/friend/delete"
#define JSTF_API_USER_CHAT_REPORT @""

/*  聊天相关 */
#define JSTF_API_USER_CHAT_LIST @"/app/peanut/user/chatting"
#define JSTF_API_USER_CHAT_SEND @"/app/peanut/user/chit_chat"

#endif /* JSTFServerApi_h */
