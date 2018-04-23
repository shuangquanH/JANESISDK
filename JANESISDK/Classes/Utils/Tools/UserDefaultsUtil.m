//
//  UserDefaultsUtil.m
//  MVVMDemo
//
//  Created by mc on 2018/3/22.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "UserDefaultsUtil.h"
#import "NSString+Estimate.h"

@implementation UserDefaultsUtil

+ (void)updateValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([NSString isNotBlank:key] && value && ![value isKindOfClass:[NSNull class]]) {
        [defaults setObject:value forKey:key];
    }
    //同步写入数据，确保数据及时更新
    [defaults synchronize];
}

+ (id)readValue:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([NSString isNotBlank:key]) {
        id value = [defaults objectForKey:key];
        return value;
    }
    return nil;
}

+ (void)removeValue:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([NSString isNotBlank:key]) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

@end
