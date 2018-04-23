//
//  UserMessageModel.h
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessageModel : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *avator;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;

@end
