//
//  MD5Util.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Util : NSObject

+(NSString *)md5_16:(NSString *)str;
+(NSString *)md5_32:(NSString *)str;

@end
