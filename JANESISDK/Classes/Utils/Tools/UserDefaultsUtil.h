//
//  UserDefaultsUtil.h
//  MVVMDemo
//
//  Created by mc on 2018/3/22.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtil : NSObject

+ (void)updateValue:(id)value forKey:(NSString *)key;

+ (id)readValue:(NSString *)key;

+ (void)removeValue:(NSString *)key;

@end
