//
//  NSObject+Extension.m
//  MVVMDemo
//
//  Created by mc on 2018/3/28.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

-(NSDictionary *)allPropertys{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    UInt32 count = 0;
    objc_property_t *properties = class_copyPropertyList(self.classForCoder, &count);
    for(int i=0;i<count;i++){
        // 获取属性名称
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([NSString isNotBlank:propertyName]) {
            // 获取Value数据
            id propertyValue = [self valueForKey:propertyName];
            [dict setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return dict;
}
@end
