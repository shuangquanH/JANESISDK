//
//  UserInfo.m
//  JSTempFun
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avator forKey:@"avator"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.tager forKey:@"tager"];
    
    [aCoder encodeObject:self.profession forKey:@"profession"];
    [aCoder encodeObject:self.work forKey:@"work"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.hauntAbout forKey:@"hauntAbout"];
    [aCoder encodeObject:self.idiograph forKey:@"idiograph"];
    [aCoder encodeObject:self.lables forKey:@"lables"];
    [aCoder encodeObject:self.run forKey:@"run"];
    [aCoder encodeObject:self.music forKey:@"music"];
    [aCoder encodeObject:self.cate forKey:@"cate"];
    [aCoder encodeObject:self.book forKey:@"book"];
    [aCoder encodeObject:self.film forKey:@"film"];
    [aCoder encodeObject:self.usualPlace forKey:@"usualPlace"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.avator = [aDecoder decodeObjectForKey:@"avator"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.tager = [aDecoder decodeObjectForKey:@"tager"];
        
        self.profession = [aDecoder decodeObjectForKey:@"profession"];
        self.work = [aDecoder decodeObjectForKey:@"work"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.hauntAbout = [aDecoder decodeObjectForKey:@"hauntAbout"];
        self.idiograph = [aDecoder decodeObjectForKey:@"idiograph"];
        self.lables = [aDecoder decodeObjectForKey:@"lables"];
        self.run = [aDecoder decodeObjectForKey:@"run"];
        self.music = [aDecoder decodeObjectForKey:@"music"];
        self.cate = [aDecoder decodeObjectForKey:@"cate"];
        self.book = [aDecoder decodeObjectForKey:@"book"];
        self.film = [aDecoder decodeObjectForKey:@"film"];
        self.usualPlace = [aDecoder decodeObjectForKey:@"usualPlace"];
    }
    return self;
}

@end
