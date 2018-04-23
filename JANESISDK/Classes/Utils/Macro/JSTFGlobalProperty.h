//
//  JSTFGlobalProperty.h
//  JSTempFun
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#ifndef JSTFGlobalProperty_h
#define JSTFGlobalProperty_h

#define APP_DISPLAYNAME @"约么"
// MARK: -- 屏幕属性

#define JSTFWself(weakSelf)  __weak __typeof(self)weakSelf = self;

/// 刷新框架的适配
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define LayoutUtil [LayoutViewUtil sharedInstance]
#define JSTFSizeW(width) width * (LayoutUtil.screenWidth / 375)
#define JSTFSizeH(height) height * (LayoutUtil.screenHeight / 667)

// MARK: -- 颜色支持
#define JSTFSOURCE_BUNDLE_NAME   @"JSTFReSources.bundle"
#define JSTFSOURCE_BUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:JSTFSOURCE_BUNDLE_NAME]
#define MYBUNDLE        [NSBundle bundleWithPath:JSTFSOURCE_BUNDLE_NAME]

// MARK: -- 颜色支持
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
/// 导航栏背景色
#define JSTFNavBarColor [UIColor whiteColor]
/// 导航栏字体色
#define JSTFNavBarTextColor RGB(51, 51, 51)

// MARK: -- 字体支持
#define JSTFFont_10 [UIFont systemFontOfSize:10]
#define JSTFFont_16 [UIFont systemFontOfSize:16]
#define JSTFFont_18 [UIFont systemFontOfSize:18]


// MARK: -- 间距支持
#define JSTFSpace_1 15
#define JSTFSpace_2 25
#define JSTFSpace_3 1
#define JSTFSpace_4 10
#define JSTFSpace_5 20
#define JSTFSpace_6 5

// MARK: -- 手势支持

#define PanGestureLeftEdge 50.0f

#define kAddSubView(targetView,view) if (self.navBarView){[targetView insertSubview:view belowSubview:self.navBarView];}else{[targetView addSubview:view];};

// MARK: -- 通知支持
#define JSTFUserInfoProfile_DidChange_Notification @"JSTFUserInfoProfile_DidChange_Notification"
#define JSTFUserInfo_DidChange_Notification @"JSTFUserInfo_DidChange_Notification"
#define JSTFUserInfoTag_DidChange_Notification @"JSTFUserInfoTag_DidChange_Notification"
#define JSTFUserInfoInterest_DidChange_Notification @"JSTFUserInfoInterest_DidChange_Notification"

// MARK: -- 本地数据存储key
#define JSTFUserLoginTager @"JSTFUserLoginTager"
#define JSTFSystemMessTag @"JSTFSystemMessTag"
#define JSTFSystemMessContent @"欢迎使用"

#endif /* JSTFGlobalProperty_h */
