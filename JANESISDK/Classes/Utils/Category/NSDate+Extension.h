//
//  NSDate+Extension.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

//判断时间戳是否为当天,昨天,一周内,年月日
+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval;

+ (BOOL)isToday:(NSDate *)date;

@end
