//
//  PageJumpRouter.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "PageJumpRouter.h"
#import <objc/runtime.h>
#import "JSTFBaseNC.h"
#import "JSTFBaseTBC.h"

@implementation PageJumpRouter

+ (void)pushToViewControllerWithProperty:(NSDictionary *)params{
    // 类名
    NSString *controllerName =[NSString stringWithFormat:@"%@", params[@"controllerName"]];
    const char *className = [controllerName cStringUsingEncoding:NSASCIIStringEncoding];
    Class class = objc_getClass(className);
    UIViewController *instance = [[class alloc] init];
    
    if (!instance) {
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([PageJumpRouter checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    //是否显示底部tabbar
    NSString * isShowTabBar = params[@"isShowTabBar"];
    if ([NSString isBlank:isShowTabBar]||[@"false" isEqualToString:isShowTabBar]) {
        if ([instance respondsToSelector:@selector(setHidesBottomBarWhenPushed:)]) {
            [instance setHidesBottomBarWhenPushed:YES];
        }
    }
    //跳转过程中让输入框都失去焦点
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    // 获取导航控制器,跳转到对应的控制器
    UIViewController *NC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    if (NC&&[NC isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)NC pushViewController:instance animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
    
}
+ (void)pushToViewControllerWithProperty:(NSDictionary *)params viewController:(UIViewController *)view
{
    // 类名
    NSString *controllerName =[NSString stringWithFormat:@"%@", params[@"controllerName"]];
    const char *className = [controllerName cStringUsingEncoding:NSASCIIStringEncoding];
    Class class = objc_getClass(className);
    UIViewController *instance = [[class alloc] init];
    
    if (!instance) {
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([PageJumpRouter checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    //是否显示底部tabbar
    NSString * isShowTabBar = params[@"isShowTabBar"];
    if ([NSString isBlank:isShowTabBar]||[@"false" isEqualToString:isShowTabBar]) {
        if ([instance respondsToSelector:@selector(setHidesBottomBarWhenPushed:)]) {
            [instance setHidesBottomBarWhenPushed:YES];
        }
    }
    //跳转过程中让输入框都失去焦点
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    // 跳转到对应的控制器
    if (view&&view.navigationController) {
        [view.navigationController pushViewController:instance animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
    
}
+ (void)presentToViewControllerWithProperty:(NSDictionary *)params{
    // 类名
    NSString *controllerName =[NSString stringWithFormat:@"%@", params[@"controllerName"]];
    const char *className = [controllerName cStringUsingEncoding:NSASCIIStringEncoding];
    Class class = objc_getClass(className);
    UIViewController *instance = [[class alloc] init];
    
    if (!instance) {
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([PageJumpRouter checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    //是否显示底部tabbar
    NSString * isShowTabBar = params[@"isShowTabBar"];
    if ([NSString isBlank:isShowTabBar]||[@"false" isEqualToString:isShowTabBar]) {
        if ([instance respondsToSelector:@selector(setHidesBottomBarWhenPushed:)]) {
            [instance setHidesBottomBarWhenPushed:YES];
        }
    }
    //跳转过程中让输入框都失去焦点
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    JSTFBaseNC *NC = [[JSTFBaseNC alloc] initWithRootViewController:instance];
    UIViewController *VC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    // 跳转到对应的控制器
    if (VC) {
        [VC presentViewController:NC
                           animated:YES
                         completion:^(void){
                             NSLog(@"View Controller is presented");
                         }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"非法操作"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
}
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}
+(void)jumpToMainPage{
    JSTFBaseTBC *tabVC = [[JSTFBaseTBC alloc] init];
    JSTFBaseNC *navVC = [[JSTFBaseNC alloc] initWithRootViewController:tabVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = navVC;
}
+(void)jumpToLoginPage{
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserLoginVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter presentToViewControllerWithProperty:dic];
}
@end
