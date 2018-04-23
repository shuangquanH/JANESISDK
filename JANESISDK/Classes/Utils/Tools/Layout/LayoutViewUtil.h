//
//  LayoutViewUtil.h
//  JSTempFun
//
//  Created by mc on 2018/4/2.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayoutViewUtil : UIView

/// 屏幕宽度（竖屏）
@property (nonatomic, assign) CGFloat screenWidth;

/// 屏幕高度（竖屏）
@property (nonatomic, assign) CGFloat screenHeight;

/// 相对UI设计图缩放比例
@property (nonatomic, assign) CGFloat scaling;

/// 是否是iPhoneX
@property (nonatomic, assign) BOOL isiPhoneX;

/// 状态栏高度
@property (nonatomic, assign) CGFloat statusBarHeight;

/// 导航栏高度
@property (nonatomic, assign) CGFloat navBarHeight;

/// 标签栏高度
@property (nonatomic, assign) CGFloat tabBarHeight;

/// 顶部刘海高度
@property (nonatomic, assign) CGFloat topLiuHeight;

/// 底部安全区域高度
@property (nonatomic, assign) CGFloat safeAreaBottomHeight;

/// 获取单例
+ (instancetype)sharedInstance;

@end
