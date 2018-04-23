//
//  NSString+Estimate.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "NSString+Estimate.h"

@implementation NSString (Estimate)

+ (BOOL)isNotBlank:(NSString*)source
{
    if ([source isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ( source == nil || source.length == 0 ) {
        return NO;
    }
    
    return YES;
}
+ (BOOL)isBlank:(NSString*)source
{
    if ([source isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (source == nil || source.length == 0 ) {
        return YES;
    }
    
    return NO;
}

//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+ (BOOL)isPureDouble:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+ (NSString *)formatDecimal_4:(double)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    }else if (fmodf(f*100, 1)==0) {//如果有三位小数点
        return [NSString stringWithFormat:@"%.2f",f];
    }else if (fmodf(f*1000, 1)==0) {//如果有四位小数点
        return [NSString stringWithFormat:@"%.3f",f];
    } else {
        return [NSString stringWithFormat:@"%.4f",f];
    }
}
+ (NSString *)formatDecimal_2:(double)f{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

+ (BOOL)isDecimalLess_1:(NSString *)num{
    NSMutableString * futureString = [NSMutableString stringWithString:num];
    NSInteger flag=0;
    const NSInteger limited = 1;//小数点后需要限制的个数
    for (int i = (int)(futureString.length-1); i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}

/// 正则替换字符
-(NSString *)replacing:(NSString *)pattern template:(NSString *)temp{
    
    if ([NSString isBlank:self]) {return self;}
    
    @try{
        NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        
        return [regularExpression stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:temp];
        
    } @catch(NSException *exception) {return self;}
}

+ (NSString *)createCUID:(NSString *)prefix

{
    
    NSString *  result;
    
    CFUUIDRef  uuid;
    
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result =[NSString stringWithFormat:@"%@_%@", prefix,uuidStr];
    
    CFRelease(uuidStr);
    
    CFRelease(uuid);
    
    return result;
    
}

+ (NSString *)getConstellationWithBirthday:(NSString *)birth
{
    NSArray *array = [birth componentsSeparatedByString:@"-"];
    if (array.count>2) {
        int month = [array[1] intValue];
        int day = [array[2] intValue];
        NSString * astroString = @"摩羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座摩羯座";
        NSString * astroFormat = @"102123444543";
        NSString * result;
        result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*3-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*3, 3)]];
        
        return result;
    }
    return nil;
    
    
}
+ (NSString *)getAgeWithBirthday:(NSString *)birth
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *bornDate = [dateFormatter dateFromString:birth];
    
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}
@end
