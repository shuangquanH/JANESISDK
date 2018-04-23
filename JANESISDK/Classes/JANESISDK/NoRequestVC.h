//
//  NoRequestVC.h
//  Podtest
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBack) (void);


@interface NoRequestVC : UIViewController

@property (nonatomic, copy) callBack        block;

@end
