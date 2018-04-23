//
//  MD5Util.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "MD5Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Util
//md5 32位 加密 （小写）
+ (NSString *)md5_32:(NSString *)str {
    
    if(!str) return nil;
    const char *cStr = [str UTF8String];
    
    unsigned char result[32];
    
    CC_MD5(cStr,(CC_LONG)strlen(cStr),result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



//md5 16位加密 （大写）

+(NSString *)md5_16:(NSString *)str {
    
    if(!str) return nil;
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
    
}

@end
