//
//  JSTFDialogBoxView.h
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JSTFDialogBoxDirection){
    JSTFDialogBoxDirectionLeft = 0,
    JSTFDialogBoxDirectionRight
};

@interface JSTFDialogBoxView : UIView

@property(nonatomic, assign)JSTFDialogBoxDirection direction;

-(instancetype)initWithDirection:(JSTFDialogBoxDirection)direction;

@end
