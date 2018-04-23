//
//  JSTFLimitTextView.h
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITextViewExtensionDelegate <NSObject>

@optional
-(void)textDidChange:(UITextView *)textView textLength:(NSInteger)num;
@end

@interface JSTFLimitTextView : UITextView<UITextViewDelegate>

@property(nonatomic, weak)id<UITextViewExtensionDelegate> responser;
@property(nonatomic, assign)NSInteger limitNum;

-(instancetype)initWithDelegate:(id<UITextViewExtensionDelegate>)delegate;

@end
