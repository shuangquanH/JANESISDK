//
//  JSTFHomeMatchHandleView.h
//  JSTempFun
//
//  Created by mc on 2018/4/2.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MatchHandleType){
    MatchHandleTypeLike = 0,
    MatchHandleTypeUnLike,
};

@interface JSTFHomeMatchHandleView : UIView

@property(nonatomic, assign)MatchHandleType handleType;

-(instancetype)initWithHandleType:(MatchHandleType)handleType;

@end
