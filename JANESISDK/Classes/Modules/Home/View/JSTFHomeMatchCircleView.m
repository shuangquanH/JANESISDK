//
//  JSTFHomeMatchCircleView.m
//  JSTempFun
//
//  Created by mc on 2018/4/17.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeMatchCircleView.h"

@implementation JSTFHomeMatchCircleView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGSize size = rect.size;
    CGFloat radius;
    if (size.width>size.height) {
        radius = size.height/2;
    }else{
        radius = size.width/2;
    }

    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    // 设置图形的线宽
    CGContextSetLineWidth(graphicsContext, 0.5);
    // 设置图形描边颜色
    CGContextSetStrokeColorWithColor(graphicsContext, [UIColor colorWithHex:@"e6f3ff"].CGColor);
    CGContextMoveToPoint(graphicsContext, size.width/2, 0);
    CGContextAddArc(graphicsContext, size.width/2, size.height/2, radius, 270*M_PI/180, -90*M_PI/180, 1);
    // 根据当前路径，宽度及颜色绘制线
    CGContextStrokePath(graphicsContext);
    
    graphicsContext = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(graphicsContext, size.width/2, 0);
    CGContextAddArc(graphicsContext, size.width/2, size.height/2, radius, 270*M_PI/180, -90*M_PI/180, 1);
    CGContextSetFillColorWithColor(graphicsContext, [UIColor colorWithHex:@"ffffff" alpha:0.3].CGColor);
    CGContextFillPath(graphicsContext);
    
}

@end
