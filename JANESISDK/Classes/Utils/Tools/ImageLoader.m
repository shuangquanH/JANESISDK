//
//  ImageLoader.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "ImageLoader.h"
#import "NSString+Estimate.h"
#import "UIImageView+WebCache.h"

@implementation ImageLoader

+ (void)loadImageWithCache:(NSString *)url imageView:(UIImageView *)imgView placeholder:(NSString *)placeholder{
    if ([NSString isBlank:url]||!imgView) return;
    NSArray *array = [url componentsSeparatedByString:@"?"];
    if (!array||array.count==0) return;
    
    NSString *tarStr = array[0];
    if ([NSString isBlank:tarStr]) return;
    NSArray *tarArr = [tarStr componentsSeparatedByString:@"/"];
    if (!tarArr||tarArr.count==0) return;
    NSString *key = [tarArr lastObject];
    if ([NSString isBlank:key]) return;
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    if([cache diskImageDataExistsWithKey:key]){
        imgView.image = [cache imageFromCacheForKey:key];
    }else{
        [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[ImageLoader loadLocalBundleImg:[NSString isNotBlank:placeholder]?placeholder:@""] options:SDWebImageTransformAnimatedImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                [cache storeImage:image forKey:key toDisk:YES completion:^{
                    
                }];
            }
            
        }];
    }
    
}
+ (UIImage *)loadLocalBundleImg:(NSString *)imageName{

    NSBundle    *bundle = [NSBundle bundleForClass:self];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:imageName ofType:@"png"]];
    }
#endif
    
}

+ (NSBundle *)my_myLibraryBundle {
    return [NSBundle bundleWithURL:[self my_myLibraryBundleURL]];
}


+ (NSURL *)my_myLibraryBundleURL {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [bundle URLForResource:@"JSCOVERIMG" withExtension:@"bundle"];
}







@end
