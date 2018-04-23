//
//  JSTFNetRequest.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "JSTFNetRequest.h"


@implementation JSTFNetRequest

- (instancetype)initWithUrl:(NSString *)url params:(id)params methodType:(JSTFRequestMethod)methodType contentType:(JSTFRequestContent)contentType{
    self = [super init];
    if (nil!=self) {
        self.url = url;
        self.params = params;
        self.methodType = methodType;
        self.contentType = contentType;
    }
    return self;
}

@end
