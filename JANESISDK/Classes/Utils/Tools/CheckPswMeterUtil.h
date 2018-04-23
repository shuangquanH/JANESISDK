//
//  CheckPswMeterUtil.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckPswMeterUtil : NSObject

@property (strong, nonatomic) NSString *psw;
@property (assign, nonatomic) NSInteger length;// 密码长度
@property (assign, nonatomic) NSInteger upperAlp;// 大写字母长度
@property (assign, nonatomic) NSInteger lowerAlp;// 小写字母长度
@property (assign, nonatomic) NSInteger num;// 数字长度
@property (assign, nonatomic) NSInteger charlen;// 特殊字符长度

+ (NSInteger)getScore:(NSString *)password;
- (instancetype)initWithPass:(NSString *)psw;
- (NSInteger)jiafen;
- (NSInteger)jianfen;
- (NSInteger)LowerQuest;

@end
