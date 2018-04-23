//
//  NoRequestVC.m
//  Podtest
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "NoRequestVC.h"
#import "ImageLoader.h"

@interface NoRequestVC ()

@end

@implementation NoRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backImage];
    [backImage setImage:[ImageLoader loadLocalBundleImg:@"login_img_bg"]];
    
    UIButton    *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"重新连接" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.frame = CGRectMake(100, 100, 100, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:button];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 20;
    button.center = self.view.center;
    
    [button addTarget:self action:@selector(buttonAciton) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAciton)];
    [self.view addGestureRecognizer:tap];
    
}
- (void)buttonAciton {
    [self dismissViewControllerAnimated:YES completion:^{
       self.block();
    }];
}



@end
