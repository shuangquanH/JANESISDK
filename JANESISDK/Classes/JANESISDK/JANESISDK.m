//
//  JANESISDK.m
//  Podtest
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "JANESISDK.h"
#import "AFNetworking.h"

#import "LaunchVC.h"
#import "NoRequestVC.h"

#import "JSTFBaseNC.h"

#define kAPI @"http://peanut.janesi.com/app/peanut/bundleid/find"
#define KSQDONOTNEEDCOVER @"KSQDONOTNEEDCOVER_NSUSERDETAULT"

@implementation JANESISDK

+ (void)coverWithWindow:(UIWindow   *)window callBack:(void(^)(void))block {
    [self setLaunchPageWithWindow:window];
    if ([self doNeedCover]) {
        [self getRequestWithWindow:window callBack:block];
    } else {
        [self disCoverWithBlock:block];
    }
}



//网络请求
+ (void)getRequestWithWindow:(UIWindow  *)window callBack:(void(^)(void))block {
    NSString    *bdid = [[NSBundle mainBundle] bundleIdentifier];
    NSString    *version = [self getAppVersion];
    
    AFHTTPSessionManager    *session = [self sharedRequestManager];
    NSString                *url = kAPI;
    NSDictionary            *param = @{@"appId":bdid};
    
    [session POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary    *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"code"] isEqualToString:@"0"]) {
            NSDictionary    *infoDic = [NSDictionary dictionaryWithDictionary:dic[@"result"]];
            NSString        *switchVersion = infoDic[@"switchNumber"];
            NSString        *switchOpen = infoDic[@"switchOpen"];
            NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [formatter setTimeZone:timeZone];
            NSDate* date = [formatter dateFromString:dic[@"result"][@"gmtEnd"]];
            NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
            
            if ([switchVersion isEqualToString:version]&&
                [switchOpen isEqualToString:@"1"]&&
                timeSp>currentTime) {
                //开始taoke
                [self coverWithWindow:window dic:infoDic];
            } else {
                //无需taoke
                [self saveDonotNeedCoverVersion:version];
                [self disCoverWithBlock:block];
            }
        } else {//errcode不等于0，跳转到源
            [self disCoverWithBlock:block];
        }
    //网络请求失败
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        [self pushToReRequestWithWindow:window callback:block];
    }];
}


//设置启动页
+ (void)setLaunchPageWithWindow:(UIWindow *)window {
    window.backgroundColor = [UIColor whiteColor];
    LaunchVC  *lunchVC = [[LaunchVC alloc] init];
    window.rootViewController = lunchVC;
    [window makeKeyAndVisible];
}
//开始taokeapp
+ (void)coverWithWindow:(UIWindow   *)window dic:(NSDictionary  *)dic {
    dispatch_async(dispatch_get_main_queue(), ^{
        JSTFBaseNC  *vc = [[JSTFBaseNC alloc] init];
        vc.param = dic;
        window.rootViewController = vc;
    });
}
//跳转到重新请求页
+ (void)pushToReRequestWithWindow:(UIWindow *)window callback:(void(^)(void))block {
    NoRequestVC *vc = [[NoRequestVC alloc] init];
    vc.block = ^{
        [self getRequestWithWindow:window callBack:block];
    };
    [window.rootViewController presentViewController:vc animated:YES completion:nil];
}
//跳转到源app
+ (void)disCoverWithBlock:(void(^)(void))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}




//判断当前版本是否需要taoke
+ (BOOL)doNeedCover {
    NSString    *presentVersion = [self getAppVersion];
    NSString    *savedVersion = [self donotNeedCoverVersion];
    if ([presentVersion compare:savedVersion options:NSNumericSearch] == NSOrderedAscending
        ||[presentVersion compare:savedVersion options:NSNumericSearch] == NSOrderedSame) {
        return NO;
    } else {
        return YES;
    }
}

//获取不需要taoke的版本号
+ (NSString *)donotNeedCoverVersion {
    return [[NSUserDefaults standardUserDefaults] valueForKey:KSQDONOTNEEDCOVER];
}
//缓存不需要taoke的版本
+ (void)saveDonotNeedCoverVersion:(NSString *)str {
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:KSQDONOTNEEDCOVER];
}
// app版本
+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}









static AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)sharedRequestManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //网络请求单例
        manager = [AFHTTPSessionManager manager];
        //设置超时时间
        manager.requestSerializer.timeoutInterval = 5;
        //请求参数格式（http格式）
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //请求参数格式（json格式）
        //manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //响应数据格式
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 缓存策略(禁止缓存,获取新数据)
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    });
    return manager;
}

@end
