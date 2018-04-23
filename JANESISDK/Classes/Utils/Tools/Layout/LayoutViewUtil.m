    //
//  LayoutViewUtil.m
//  JSTempFun
//
//  Created by mc on 2018/4/2.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "LayoutViewUtil.h"

@implementation LayoutViewUtil

//MARK: - 初始化相关
/// 获取单例
+ (instancetype)sharedInstance {
    static LayoutViewUtil *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[LayoutViewUtil alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _scaling = _screenWidth / 375.0;
        _isiPhoneX = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
        _statusBarHeight = (_isiPhoneX ? 44.0f : 20.0f);
        _navBarHeight = (_isiPhoneX ? 88.0f : 64.0f);
        _tabBarHeight = (_isiPhoneX ? 83.0f : 49.0f);
        _safeAreaBottomHeight = (_isiPhoneX ? 34.0f : 0);
        _topLiuHeight = 30;
    }
    return self;
}


@end
