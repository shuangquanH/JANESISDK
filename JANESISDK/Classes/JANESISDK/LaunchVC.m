//
//  LaunchVC.m
//  Podtest
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "LaunchVC.h"
#import "ImageLoader.h"

@interface LaunchVC ()

@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backImage];
    [backImage setImage:[ImageLoader loadLocalBundleImg:@"login_img_bg"]];
}


@end
