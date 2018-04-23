//
//  JSTFDialogBoxView.m
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFDialogBoxView.h"

@implementation JSTFDialogBoxView

-(instancetype)initWithDirection:(JSTFDialogBoxDirection)direction{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.direction = direction;
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGSize size = rect.size;
    CGFloat radius = 4*LayoutUtil.scaling;
    CGFloat side = 4*LayoutUtil.scaling;
    CGFloat triangleY = 40/2;
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    if (self.direction==JSTFDialogBoxDirectionLeft) {
        CGContextSetFillColorWithColor(graphicsContext, [UIColor colorWithHex:@"ffffff"].CGColor);
        CGContextMoveToPoint(graphicsContext, radius+side, 0);
        CGContextAddArc(graphicsContext, radius+side, radius, radius, 270*M_PI/180, 180*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, side, triangleY-side);
        CGContextAddLineToPoint(graphicsContext, 0, triangleY);
        CGContextAddLineToPoint(graphicsContext, side, triangleY+side);
        CGContextAddLineToPoint(graphicsContext, side, size.height-radius);
        CGContextAddArc(graphicsContext, radius+side, size.height-radius, radius, 180*M_PI/180, 90*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, size.width-radius, size.height);
        CGContextAddArc(graphicsContext, size.width-radius, size.height-radius, radius, 90*M_PI/180, 0*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, size.width, radius);
        CGContextAddArc(graphicsContext, size.width-radius, radius, radius, 0*M_PI/180, -90*M_PI/180, 1);
        CGContextFillPath(graphicsContext);
        
    }else if (self.direction==JSTFDialogBoxDirectionRight){
        CGContextSetFillColorWithColor(graphicsContext, [UIColor colorWithHex:@"9013FE"].CGColor);
        CGContextMoveToPoint(graphicsContext, radius, 0);
        CGContextAddArc(graphicsContext, radius, radius, radius, 270*M_PI/180, 180*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, 0, size.height-radius);
        CGContextAddArc(graphicsContext, radius, size.height-radius, radius, 180*M_PI/180, 90*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, size.width-side-radius, size.height);
        CGContextAddArc(graphicsContext, size.width-side-radius, size.height-radius, radius, 90*M_PI/180, 0*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, size.width-side, triangleY+side);
        CGContextAddLineToPoint(graphicsContext, size.width, triangleY);
        CGContextAddLineToPoint(graphicsContext, size.width-side, triangleY-side);
        CGContextAddLineToPoint(graphicsContext, size.width-side, radius);
        CGContextAddArc(graphicsContext, size.width-side-radius, radius, radius, 0*M_PI/180, -90*M_PI/180, 1);
        CGContextAddLineToPoint(graphicsContext, radius, 0);
        CGContextFillPath(graphicsContext);
        
    }else{
        [super drawRect:rect];
    }
}


@end
