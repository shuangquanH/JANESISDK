//
//  SystemUtils.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "SystemUtils.h"
#import "UserInfo.h"
#import "UserChatModel.h"
#import "UserDefaultsUtil.h"

@implementation SystemUtils

+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
+ (BOOL)userIsLogin{
    UserInfo *user = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaultsUtil readValue:@"JSTF_UserInfo"]];
    if (user!=nil&&[user isKindOfClass:[UserInfo class]]) {
        return YES;
    }
    return NO;
}
+ (UserInfo *)getUserData{
    UserInfo *user = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaultsUtil readValue:@"JSTF_UserInfo"]];
    return user;
}
+ (void)updateUserLoginTager:(BOOL)flag{
    if(!flag) return;
    UserInfo *info = [SystemUtils getUserData];
    NSArray *array = [UserDefaultsUtil readValue:JSTFUserLoginTager];
    NSMutableArray *arr = [NSMutableArray array];
    if (array&&array>0) {
        if ([NSString isNotBlank:info.userId]&&![array containsObject:info.userId]) {
            [arr addObjectsFromArray:array];
            [arr addObject:info.userId];
            [UserDefaultsUtil updateValue:arr forKey:JSTFUserLoginTager];
        }
    }else{
        if ([NSString isNotBlank:info.userId]) {
            [arr addObject:info.userId];
            [UserDefaultsUtil updateValue:arr forKey:JSTFUserLoginTager];
        }
    }
}
+ (BOOL)readUserLoginTager{
    UserInfo *user = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaultsUtil readValue:@"JSTF_UserInfo"]];
    if(!user) return NO;
    BOOL flag = NO;
    NSArray *array = [UserDefaultsUtil readValue:JSTFUserLoginTager];
    if (array&&array.count>0) {
        if ([array containsObject:user.userId]) {
            flag = YES;
        }
    }
    return flag;
}

//系统消息相关
+ (void)configSystemMess{
    UserInfo *info = [SystemUtils getUserData];
    if (!info) return;
    NSDictionary *dic = [UserDefaultsUtil readValue:JSTFSystemMessTag];
    if (!dic) {
        UserChatModel *model = [[UserChatModel alloc] init];
        model.toUserId = info.userId;
        model.toUserModified = JSTFSystemMessContent;
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        model.toUserGmtModified = [format stringFromDate:[NSDate date]];
        
        NSMutableDictionary *Dic = [NSMutableDictionary dictionary];
        //虚拟一个不存在的数据
        [Dic setObject:[NSArray array] forKey:[format stringFromDate:[NSDate date]]];
        [Dic setObject:@[[model yy_modelToJSONObject]] forKey:info.userId];
        
        [UserDefaultsUtil updateValue:Dic forKey:JSTFSystemMessTag];
    }else{
        NSArray *array = [dic objectForKey:info.userId];
        if (!array) {
            UserChatModel *model = [[UserChatModel alloc] init];
            model.toUserId = info.userId;
            model.toUserModified = JSTFSystemMessContent;
            NSDateFormatter *format = [[NSDateFormatter alloc]init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            model.toUserGmtModified = [format stringFromDate:[NSDate date]];
            
            NSMutableDictionary *Dic = [NSMutableDictionary dictionaryWithDictionary:dic];
            //虚拟一个不存在的数据
            [Dic setObject:@[[model yy_modelToJSONObject]] forKey:info.userId];
            
            [UserDefaultsUtil updateValue:Dic forKey:JSTFSystemMessTag];
        }
    }
}
+ (BOOL)systemMessIsExist{
    UserInfo *info = [SystemUtils getUserData];
    if (!info) return NO;
    [SystemUtils configSystemMess];
    NSDictionary *dic = [UserDefaultsUtil readValue:JSTFSystemMessTag];
    if (dic) {
        NSArray *array = [dic objectForKey:info.userId];
        if (array&&array.count>0) {
            return YES;
        }
        return NO;
    }
    return NO;
}
+ (NSArray *)querySystemMess{
    UserInfo *info = [SystemUtils getUserData];
    if (!info) return nil;
    [SystemUtils configSystemMess];
    NSDictionary *dic = [UserDefaultsUtil readValue:JSTFSystemMessTag];
    if (dic) {
        NSArray *array = [dic objectForKey:info.userId];
        if (array&&array.count>0) {//存在数据就添加，不存在数据就代表用户已删除系统消息
            NSArray *models = [NSArray yy_modelArrayWithClass:[UserChatModel class] json:array];
            return models;
        }
    }
    return nil;
}
+ (void)addSystemMess:(UserChatModel *)chatModel{
    UserInfo *info = [SystemUtils getUserData];
    if (!info||!chatModel) return;
    [SystemUtils configSystemMess];
    NSDictionary *dic = [UserDefaultsUtil readValue:JSTFSystemMessTag];
    if (dic) {
        NSArray *array = [dic objectForKey:info.userId];
        if (array&&array.count>0) {//存在数据就添加，不存在数据就代表用户已删除系统消息
            NSMutableArray *Array = [NSMutableArray arrayWithArray:array];
            [Array addObject:[chatModel yy_modelToJSONObject]];
            NSMutableDictionary *Dic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [Dic setObject:Array forKey:info.userId];
            [UserDefaultsUtil updateValue:Dic forKey:JSTFSystemMessTag];
        }else return;
    }
}
+ (void)removeSystemMess{
    UserInfo *info = [SystemUtils getUserData];
    if (!info) return;
    [SystemUtils configSystemMess];
    NSDictionary *dic = [UserDefaultsUtil readValue:JSTFSystemMessTag];
    if (dic) {
        NSMutableDictionary *Dic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [Dic setObject:[NSArray array] forKey:info.userId];
        [UserDefaultsUtil updateValue:Dic forKey:JSTFSystemMessTag];
    }
}
@end
