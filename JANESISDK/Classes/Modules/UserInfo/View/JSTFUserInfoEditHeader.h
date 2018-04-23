//
//  JSTFUserInfoEditHeader.h
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JSTFUserInfoEditHeaderDelegate <NSObject>
@optional
-(void)moveToEditProfilePage;
-(void)addMorePhotos;
@end

@interface JSTFUserInfoEditHeader : UIView

@property(nonatomic, weak)id<JSTFUserInfoEditHeaderDelegate> delegate;
@property(nonatomic, strong)UserInfo *userInfo;

@end
