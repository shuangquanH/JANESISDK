//
//  NSDate+Extension.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue/1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //今天
    if ([date isToday]) {
        
        formatter.dateFormat = @"HH:mm";
        
        return [formatter stringFromDate:date];
    }else{
        
        //昨天
        if ([date isYesterday]) {
            
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:date];
            
            //一周内 [date weekdayStringFromDate]
        }else if ([date isSameWeek]){
            
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date weekdayStringFromDate],@"HH:mm"];
            return [formatter stringFromDate:date];
            
            //直接显示年月日
        }else{
            
            formatter.dateFormat = @"yy-MM-dd  HH:mm";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}


//是否在同一周
- (BOOL)isSameWeek
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}


//根据日期求星期几
- (NSString *)weekdayStringFromDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}




//是否为今天
- (BOOL)isToday
{
    //now: 2015-09-05 11:23:00
    //self 调用这个方法的对象本身
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}



//是否为昨天
- (BOOL)isYesterday
{
    //2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    //2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    //获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

//格式化
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

+ (BOOL)isToday:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}
+ (NSString *)checkTheDate:(NSString *)string{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    NSString *strDiff = nil;
    
    if(isToday) {
        strDiff= [NSString stringWithFormat:@"今天"];
    }
    return strDiff;
}

@end
