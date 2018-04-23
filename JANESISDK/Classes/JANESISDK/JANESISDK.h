//
//  JANESISDK.h
//  Podtest
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JANESISDK : NSObject

+ (void)coverWithWindow:(UIWindow   *)window callBack:(void(^)(void))block;

@end
