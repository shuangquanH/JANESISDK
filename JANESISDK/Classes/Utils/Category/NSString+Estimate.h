//
//  NSString+Estimate.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Estimate)

+ (BOOL)isNotBlank:(NSString*)source;

+ (BOOL)isBlank:(NSString*)source;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureDouble:(NSString*)string;

//小数点位数相关
+ (NSString *)formatDecimal_4:(double)f;
+ (NSString *)formatDecimal_2:(double)f;
+ (BOOL)isDecimalLess_1:(NSString *)num;

-(NSString *)replacing:(NSString *)pattern template:(NSString *)temp;
+(NSString *)createCUID:(NSString *)prefix;

//根据月日计算星座
+ (NSString *)getConstellationWithBirthday:(NSString *)birth;
+ (NSString *)getAgeWithBirthday:(NSString *)birth;
@end
