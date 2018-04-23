//
//  MotionBlurFilter.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface MotionBlurFilter : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputRadius;
@property (strong, nonatomic) NSNumber *inputAngle;
@property (strong, nonatomic) NSNumber *numSamples;

@end
