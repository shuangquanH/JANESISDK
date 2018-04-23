//
//  JSTFHomeMatchHandleView.m
//  JSTempFun
//
//  Created by mc on 2018/4/2.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeMatchHandleView.h"

@implementation JSTFHomeMatchHandleView

-(instancetype)initWithHandleType:(MatchHandleType)handleType{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.handleType = handleType;
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGSize size = rect.size;
    if (self.handleType==MatchHandleTypeLike) {

        CGFloat radius = size.height/2;
        CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(graphicsContext, [UIColor colorWithHex:@"fa244a"].CGColor);
        CGContextMoveToPoint(graphicsContext, size.width, 0);
        CGContextAddLineToPoint(graphicsContext, radius, 0);
        CGContextAddArc(graphicsContext, radius, radius, radius, -90*M_PI/180, 90*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, size.width, radius*2);
        CGContextFillPath(graphicsContext);
        // uiImage是将要绘制的UIImage图片，width和height是它的宽高
        CGRect imageRect = CGRectMake(22, 21, 36, 32);
        UIGraphicsPushContext(graphicsContext);
        [[ImageLoader loadLocalBundleImg:@"home_icon_handle_like"] drawInRect:imageRect];
        UIGraphicsPopContext();
//        CGContextDrawImage(graphicsContext, imageRect, [ImageLoader loadLocalBundleImg:@"home_icon_handle_like"].CGImage);
        
    }else if (self.handleType==MatchHandleTypeUnLike){
        
        CGFloat radius = size.height/2;
        CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(graphicsContext, [UIColor colorWithHex:@"333333"].CGColor);
        CGContextMoveToPoint(graphicsContext, 0, 0);
        CGContextAddLineToPoint(graphicsContext, size.width-radius, 0);
        CGContextAddArc(graphicsContext, size.width-radius, radius, radius, -90*M_PI/180, 90*M_PI/180, 0);
        CGContextAddLineToPoint(graphicsContext, 0, radius*2);
        CGContextFillPath(graphicsContext);
        
        CGRect imageRect = CGRectMake(20, 25, 24, 24);
        UIGraphicsPushContext(graphicsContext);
        [[ImageLoader loadLocalBundleImg:@"home_icon_handle_unlike"] drawInRect:imageRect];
        UIGraphicsPopContext();
    }else{
        [super drawRect:rect];
    }
}

@end
