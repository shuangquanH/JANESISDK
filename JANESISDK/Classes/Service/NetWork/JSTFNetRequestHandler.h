//
//  JSTFNetRequestHandler.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSTFNetRequest.h"

@interface JSTFNetRequestHandler : NSObject

//获取接口域名
+ (NSString *)getRequestBaseDomain;
//传入参数：Request封装类，success和failture的回调
+ (void)request:(JSTFNetRequest *)request success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)uploadImg:(UIImage *)image url:(NSString *)url success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)uploadImgs:(NSArray *)images url:(NSString *)url success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure;
@end
