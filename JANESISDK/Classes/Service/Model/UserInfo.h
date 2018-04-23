//
//  UserInfo.h
//  JSTempFun
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *phone;
//性别 -1-未知 ， 0-女 ，1-男
@property (nonatomic, strong)NSNumber *sex;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSArray *avator;
@property (nonatomic, copy)NSString *birthday;
// false-未注册过 true-注册过 (不做存储，只有登录返回有效)
@property (nonatomic, strong)NSNumber *tager;

@property(nonatomic, copy)NSString *profession;// '行业',
@property(nonatomic, copy)NSString *work;// '工作领域',
@property(nonatomic, copy)NSString *city;// '城市',
@property(nonatomic, copy)NSString *hauntAbout;//经常出没
@property(nonatomic, copy)NSString *idiograph;//个性签名
@property(nonatomic, strong)NSArray *lables;// '个性标签'
@property(nonatomic, strong)NSArray *run;//运动
@property(nonatomic, strong)NSArray *music;// '音乐',
@property(nonatomic, strong)NSArray *cate;// '美食'
@property(nonatomic, strong)NSArray *book;// '书籍',
@property(nonatomic, strong)NSArray *film;// '电影'
@property(nonatomic, strong)NSArray *usualPlace;// '去过的地方'

@end
