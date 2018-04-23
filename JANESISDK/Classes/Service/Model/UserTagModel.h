//
//  UserTagModel.h
//  JSTempFun
//
//  Created by mc on 2018/4/13.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTagModel : NSObject

@property(nonatomic, strong)NSArray *lables;// '个性标签'
@property(nonatomic, strong)NSArray *run;//运动
@property(nonatomic, strong)NSArray *music;// '音乐',
@property(nonatomic, strong)NSArray *cate;// '美食'
@property(nonatomic, strong)NSArray *book;// '书籍',
@property(nonatomic, strong)NSArray *film;// '电影'
@property(nonatomic, strong)NSArray *usualPlace;// '去过的地方'

@end
