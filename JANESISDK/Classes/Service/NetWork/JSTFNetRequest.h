//
//  JSTFNetRequest.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JSTFRequestMethod){
    MSRequestMethodGet = 0,
    MSRequestMethodPost,
    MSRequestMethodPut,
    MSRequestMethodDelete
};
typedef NS_OPTIONS(NSInteger, JSTFRequestContent){
    MSRequestContentDefault = 0,
    MSRequestContentJson
};
@interface JSTFNetRequest : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) id params;
@property (nonatomic, assign) JSTFRequestMethod methodType;
@property (nonatomic, assign) JSTFRequestContent contentType;

- (instancetype)initWithUrl:(NSString *)url params:(id)params methodType:(JSTFRequestMethod)methodType contentType:(JSTFRequestContent)contentType;

@end
