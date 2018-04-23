//
//  ValidateUtil.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "ValidateUtil.h"

@implementation ValidateUtil
#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex targetStr:(NSString *)targetStr{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:targetStr];
}
//手机号码
+ (BOOL)validatePhone:(NSString *)phone {
    ValidateUtil *util = [[ValidateUtil alloc] init];
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188 (147,178)
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[2-478])\\d)\\d{7}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,171,175,176,185,186
     */
    NSString * CU = @"^1(3[0-2]|45|5[56]|7[156]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,149,153,173,177,180,181,189,1700
     */
    NSString * CT = @"(^1(33|49|53|7[37]|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 虚拟运行商：
     * 170
     */
    NSString * CR =@"^1(70)\\d{8}$";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    if (([util isValidateByRegex:MOBILE targetStr:phone] == YES)
        || ([util isValidateByRegex:CM targetStr:phone] == YES)
        || ([util isValidateByRegex:CT targetStr:phone] == YES)
        || ([util isValidateByRegex:CU targetStr:phone] == YES)
        || ([util isValidateByRegex:CR targetStr:phone] == YES))
    {
        if([util isValidateByRegex:CM targetStr:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([util isValidateByRegex:CT targetStr:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([util isValidateByRegex:CU targetStr:phone] == YES) {
            NSLog(@"China Unicom");
        } else if ([util isValidateByRegex:CR targetStr:phone] == YES) {
            NSLog(@"China CR");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

//邮箱
+ (BOOL)validateEmailAddress:(NSString *)email{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [util isValidateByRegex:emailRegex targetStr:email];
}
//二维码
+ (BOOL)validateLoginQRCode:(NSString *)str withUrl:(NSString *)url{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *emailRegex = [NSString stringWithFormat:@"https?://.{1,32}(\\.)?\\w{0,32}\\.zhudb\\.com%@\\?nonceStr=\\w{32}",url];
    //    NSString *emailRegex1 = @"https?://\\w{1,32}(\\.)?\\w{0,32}\\.zhudb\\.com\\?nonceStr=\\w{32}";
    //    NSLog(@"%@",emailRegex1);
    return [util isValidateByRegex:emailRegex targetStr:str];
}

//身份证号
+ (BOOL)validateIdentityCardNum:(NSString *)idCardNum
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex2 = @"[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)";
    return [util isValidateByRegex:regex2 targetStr:idCardNum];
}
//手机号码
+ (BOOL)validateSamplePhone:(NSString *)phone
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"[1][3456789]\\d{9}";
    return [util isValidateByRegex:regex targetStr:phone];
}
//密码
+ (BOOL)validatePassword:(NSString *)password
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    //    NSString *regex = @"(?!^\\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{8,20}";
    NSString *regex = @"((?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\\W_]+$)(?![a-z0-9]+$)(?![a-z\\W_]+$)(?![0-9\\W_]+$)[a-zA-Z0-9\\W_]{8,20})?";
    return [util isValidateByRegex:regex targetStr:password];
}

//非负整数（正整数 + 0）
+ (BOOL)validateNoNegInteger:(NSString *)number
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"^\\d+$";
    return [util isValidateByRegex:regex targetStr:number];
}

//金额，最多两位小数
+ (BOOL)validateAmount:(NSString *)number
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"(^[0-9](\\d+)?(\\.\\d{1,2})?$)|(^(0){1}$)|(^\\d\\.\\d{1,2}?$)";
    return [util isValidateByRegex:regex targetStr:number];
}
//最多一位小数
+ (BOOL)validateAmount_1:(NSString *)number
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"(^[0-9](\\d+)?(\\.\\d{1,1})?$)|(^(0){1}$)|(^\\d\\.\\d{1,1}?$)";
    return [util isValidateByRegex:regex targetStr:number];
}
//利率，最多四位小数
+ (BOOL)validateRate:(NSString *)number
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"(^[0-9](\\d+)?(\\.\\d{1,4})?$)|(^(0){1}$)|(^\\d\\.\\d{1,4}?$)";
    return [util isValidateByRegex:regex targetStr:number];
}
//盈亏金额，最多两位小数
+ (BOOL)validateUnsignedAmount:(NSString *)number
{
    ValidateUtil *util = [[ValidateUtil alloc] init];
    NSString *regex = @"(^[-+]?[0-9](\\d+)?(\\.\\d{1,2})?$)|(^(0){1}$)|(^\\d\\.\\d{1,2}?$)";
    return [util isValidateByRegex:regex targetStr:number];
}
@end
