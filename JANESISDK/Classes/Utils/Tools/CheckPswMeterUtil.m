//
//  CheckPswMeterUtil.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "CheckPswMeterUtil.h"

@implementation CheckPswMeterUtil

-(instancetype)initWithPass:(NSString *)psw{
    
    self = [super init];
    if (self) {
        self.psw = [psw stringByReplacingOccurrencesOfString:@"\\s" withString:@""];
        self.length = psw.length;
    }
    return self;
}
+ (NSInteger)getScore:(NSString *)password{
    //    password = @"abch74$;(/Id";//加分134 减分11
    CheckPswMeterUtil *checkPswMeterUtil = [[CheckPswMeterUtil alloc] initWithPass:password];
    NSInteger score = [checkPswMeterUtil jiafen]+[checkPswMeterUtil jianfen];
    //    NSLog(@"%ld ** %ld",[checkPswMeterUtil jiafen],[checkPswMeterUtil jianfen]);
    if([checkPswMeterUtil LowerQuest]==0){
        score=0;
    }
    if(score > 100){
        return 100;
    }else  if (score < 0){
        return 0;
    }
    return score;
}
// 密码长度积分
-(NSInteger)CheckPswLength{
    return self.length * 4;
}
// 大写字母积分
-(NSInteger)CheckPswUpper{
    NSString *reg = @"[A-Z]";
    //查找大些字母出现次数
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    // 对str字符串进行匹配
    NSInteger count = [regular numberOfMatchesInString:self.psw
                                               options:0
                                                 range:NSMakeRange(0, self.psw.length)];
    NSInteger j = 0;
    if (count>0) {
        j=count;
    }else{
        j=0;
    }
    self.upperAlp = j;
    if (j <= 0) {
        return 0;
    }
    return (self.length - j) * 2;
}
// 小写字母积分
-(NSInteger)CheckPwsLower{
    NSString *reg = @"[a-z]";
    //查找大些字母出现次数
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    // 对str字符串进行匹配
    NSInteger count = [regular numberOfMatchesInString:self.psw
                                               options:0
                                                 range:NSMakeRange(0, self.psw.length)];
    NSInteger j = 0;
    if (count>0) {
        j=count;
    }else{
        j=0;
    }
    self.lowerAlp = j;
    if (j <= 0) {
        return 0;
    }
    return (self.length - j) * 2;
}
// 测试数字字元
-(NSInteger)checkNum{
    NSString *reg = @"[0-9]";
    //查找大些字母出现次数
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    // 对str字符串进行匹配
    NSInteger count = [regular numberOfMatchesInString:self.psw
                                               options:0
                                                 range:NSMakeRange(0, self.psw.length)];
    NSInteger j = 0;
    if (count>0) {
        j=count;
    }else{
        j=0;
    }
    self.num = j;
    if (j <= 0) {
        return 0;
    }
    return j * 4;
}
// 测试符号字元
- (NSInteger)checkChar{
    self.charlen = self.length - self.upperAlp - self.lowerAlp - self.num;
    return self.charlen * 6;
}
// 密碼中間穿插數字或符號字元
- (NSInteger)checkNumOrCharInStr{
    NSInteger j = self.num + self.charlen - 1;
    if (j < 0) {
        j = 0;
    }
    if (self.num + self.charlen == self.length) {
        j = self.length - 2;
    }
    return j * 2;
}
/**
 * 最低要求标准 该方法需要在以上加分方法使用后才可以使用
 *
 */
-(NSInteger)LowerQuest{
    int j = 0;
    if (self.upperAlp > 0) {
        j++;
    }
    if (self.lowerAlp > 0) {
        j++;
    }
    if (self.num > 0) {
        j++;
    }
    if (self.charlen > 0) {
        j++;
    }
    if (self.length < 8||j<3) {
        j=0;
    }
    return j * 2;
}

/** =================分割线===扣分项目===================== **/
// 只包含英文字母
-(NSInteger)OnlyHasAlp{
    if (self.length == (self.upperAlp + self.lowerAlp)) {
        return -self.length;
    }
    return 0;
}
// 只包含数字
-(NSInteger)OnlyHasNum{
    if (self.length == self.num) {
        return -self.length;
    }
    return 0;
}
// 重复字元扣分
-(NSInteger)repeatDex{
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < array.count; i++) {
        if([[dic allKeys] containsObject:array[i]]) {
            NSNumber *num = [dic objectForKey:array[i]];
            [dic setObject:@([num integerValue]+1) forKey:array[i]];
        }else{
            [dic setObject:@(1) forKey:array[i]];
        }
    }
    NSInteger sum = 0;
    for (NSNumber *number in [dic allValues]){
        NSInteger j = [number integerValue];
        if (j > 0) {
            sum = sum + j * (j - 1);
        }
    }
    return -sum;
}
// 连续英文大写字元
-(NSInteger)seriseUpperAlp{
    NSInteger j = 0;
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    if (array.count<2) {
        return 0;
    }
    for (int i = 0; i < array.count - 1; i++) {
        NSString *string = array[i];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        NSUInteger count = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
        
        if (count>0) {
            NSString *temp = array[i+1];
            NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            NSUInteger tempCount = [regular numberOfMatchesInString:temp options:NSMatchingReportProgress range:NSMakeRange(0, temp.length)];
            if (tempCount>0) {
                j++;
            }
        }
    }
    return -2 * j;
}
// 连续英文小写字元
-(NSInteger)seriseLowerAlp{
    NSInteger j = 0;
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    if (array.count<2) {
        return 0;
    }
    for (int i = 0; i < array.count - 1; i++) {
        NSString *string = array[i];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        NSUInteger count = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
        
        if (count>0) {
            NSString *temp = array[i+1];
            NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            NSUInteger tempCount = [regular numberOfMatchesInString:temp options:NSMatchingReportProgress range:NSMakeRange(0, temp.length)];
            if (tempCount>0) {
                j++;
            }
        }
    }
    return -2 * j;
}
// 连续数字字元
-(NSInteger)seriseNum{
    NSInteger j = 0;
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    if (array.count<2) {
        return 0;
    }
    for (int i = 0; i < array.count - 1; i++) {
        NSString *string = array[i];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        NSUInteger count = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
        
        if (count>0) {
            NSString *temp = array[i+1];
            NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            NSUInteger tempCount = [regular numberOfMatchesInString:temp options:NSMatchingReportProgress range:NSMakeRange(0, temp.length)];
            if (tempCount>0) {
                j++;
            }
        }
    }
    return -2 * j;
}

// 连续字母abc def之类超过3个扣分 不区分大小写字母
-(NSInteger)seriesAlp2Three{
    NSInteger j = 0;
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    if (array.count<3) {
        return 0;
    }
    for (int i = 0; i < array.count - 2; i++) {
        NSString *string = array[i];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger count = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
        if (count>0) {
            NSString *temp = array[i+1];
            NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger tempCount = [regular numberOfMatchesInString:temp options:NSMatchingReportProgress range:NSMakeRange(0, temp.length)];
            NSString *temp1 = array[i+2];
            NSRegularExpression *regular1 = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger tempCount1 = [regular1 numberOfMatchesInString:temp1 options:NSMatchingReportProgress range:NSMakeRange(0, temp1.length)];
            
            int strInt = [string characterAtIndex:0];
            int tempInt = [temp characterAtIndex:0];
            int temp1Int = [temp1 characterAtIndex:0];
            //            NSLog(@"%d--%d--%d",strInt,tempInt,temp1Int);
            if (tempCount>0&&tempCount1>0&&tempInt==strInt+1&&temp1Int==strInt+2) {
                j++;
            }
        }
    }
    return -3 * j;
}
// 连续数字123 234之类超过3个扣分
-(NSInteger)seriesNum2Three{
    NSInteger j = 0;
    NSMutableArray *array = [NSMutableArray array];
    for(int i =0; i < [self.psw length]; i++)
    {
        [array addObject:[self.psw substringWithRange:NSMakeRange(i,1)]];
    }
    if (array.count<3) {
        return 0;
    }
    for (int i = 0; i < array.count - 2; i++) {
        NSString *string = array[i];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger count = [regular numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
        if (count>0) {
            NSString *temp = array[i+1];
            NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger tempCount = [regular numberOfMatchesInString:temp options:NSMatchingReportProgress range:NSMakeRange(0, temp.length)];
            NSString *temp1 = array[i+2];
            NSRegularExpression *regular1 = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger tempCount1 = [regular1 numberOfMatchesInString:temp1 options:NSMatchingReportProgress range:NSMakeRange(0, temp1.length)];
            
            int strInt = [string characterAtIndex:0];
            int tempInt = [temp characterAtIndex:0];
            int temp1Int = [temp1 characterAtIndex:0];
            //            NSLog(@"%d--%d--%d",strInt,tempInt,temp1Int);
            if (tempCount>0&&tempCount1>0&&tempInt==strInt+1&&temp1Int==strInt+2) {
                j++;
            }
        }
    }
    return -3 * j;
}

-(NSInteger)jiafen{
    
    return [self CheckPswLength]+[self CheckPswUpper]+[self CheckPwsLower]+[self checkNum]+[self checkChar]+[self checkNumOrCharInStr]+[self LowerQuest];
}
-(NSInteger)jianfen{
    return [self OnlyHasAlp]+[self OnlyHasNum]+[self repeatDex]+[self seriseUpperAlp]+[self seriseLowerAlp]+[self seriseNum]+[self seriesAlp2Three]+[self seriesNum2Three];
}

@end
