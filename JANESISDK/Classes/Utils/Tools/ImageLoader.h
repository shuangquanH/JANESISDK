//
//  ImageLoader.h
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageLoader : NSObject

+ (void)loadImageWithCache:(NSString *)url imageView:(UIImageView *)imgView placeholder:(NSString *)placeholder;
+ (UIImage *)loadLocalBundleImg:(NSString *)imageName;

@end
