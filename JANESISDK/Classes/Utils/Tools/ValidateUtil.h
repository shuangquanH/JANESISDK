//
//  ValidateUtil.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateUtil : NSObject
+ (BOOL)validatePhone:(NSString *)phone;
+ (BOOL)validateEmailAddress:(NSString *)email;
+ (BOOL)validateIdentityCardNum:(NSString *)idCardNum;
+ (BOOL)validateSamplePhone:(NSString *)phone;
+ (BOOL)validatePassword:(NSString *)phone;

//非负整数
+ (BOOL)validateNoNegInteger:(NSString *)number;
//金额
+ (BOOL)validateAmount:(NSString *)number;
//最多一位小数
+ (BOOL)validateAmount_1:(NSString *)number;
//利率，最多三位小数
+ (BOOL)validateRate:(NSString *)number;
//无符号盈亏金额
+ (BOOL)validateUnsignedAmount:(NSString *)number;
//二维码
+ (BOOL)validateLoginQRCode:(NSString *)str withUrl:(NSString *)url;

@end
