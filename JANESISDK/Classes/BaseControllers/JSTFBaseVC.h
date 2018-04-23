//
//  JSTFBaseVC.h
//  JSTempFun
//
//  Created by mc on 2018/3/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTFNetRequestHandler.h"
@interface JSTFBaseVC : UIViewController

@property(nonatomic, strong)UIView *navBarView;

@property (nonatomic, strong) UIWebView       *webview;
@property (nonatomic, strong) NSString       *webUrl;

-(void)configNavUI:(NSString *)title isShowBack:(BOOL)isShow;

@end
