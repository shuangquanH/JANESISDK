//
//  JsonUtil.h
//  MVVMDemo
//
//  Created by mc on 2018/3/22.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

+ (id)jsonTransformation:(NSString *)jsonstring;

+ (NSString *)convertToJson:(id)object;

+ (NSDate *)stringTransformDate:(NSString *)strdate;

+ (NSString *)dateTransformString:(NSDate *)date;

@end
