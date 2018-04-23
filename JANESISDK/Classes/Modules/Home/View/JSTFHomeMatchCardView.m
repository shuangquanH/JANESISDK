//
//  JSTFHomeMatchCardView.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeMatchCardView.h"

@interface JSTFHomeMatchCardView()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UIImageView *sexAgeView;
@property (strong, nonatomic) UIImageView *starView;
@property (strong, nonatomic) UILabel *identityLab;

@end

@implementation JSTFHomeMatchCardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView.layer setMasksToBounds:YES];
    [self addSubview:imageView];
    JSTFWself(weakSelf);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo((self.bounds.size.height-kContainerEdage*2-kCardEdage*kVisibleCount)-100*LayoutUtil.scaling);
    }];
    self.imageView = imageView;
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textColor = [UIColor blackColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont boldSystemFontOfSize:16];
    nameLab.text = @"想养一只猫";
    [self addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(22);
    }];
    self.nameLab = nameLab;
    
    CGSize size = CGSizeMake(33, 16);
    UIImage *sexAgeImg = [UIImage imageWithRect:size image:nil text:nil color:[UIColor colorWithHex:@"ffc4fc"]];
    UIImageView *sexAgeView = [[UIImageView alloc] init];
    [sexAgeView setImage:sexAgeImg];
    [self addSubview:sexAgeView];
    [sexAgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((weakSelf.bounds.size.width-kContainerEdage*2)/2-size.width-2.5);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(8);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    self.sexAgeView = sexAgeView;
    
    size = CGSizeMake(43, 16);
    UIImage *starImg = [UIImage imageWithRect:size image:nil text:nil color:[UIColor colorWithHex:@"acd7ff"]];
    UIImageView *starView = [[UIImageView alloc] init];
    [starView setImage:starImg];
    [self addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((weakSelf.bounds.size.width-kContainerEdage*2)/2+2.5);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(8);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    self.starView = starView;
    
    UILabel *identityLab = [[UILabel alloc] init];
    identityLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    identityLab.textAlignment = NSTextAlignmentCenter;
    identityLab.font = [UIFont systemFontOfSize:12];
    identityLab.text = @"模特/摄影师";
    [self addSubview:identityLab];
    [identityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sexAgeView.mas_bottom).with.offset(9);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    self.identityLab = identityLab;
    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if (_userInfo) {
        if (_userInfo.avator&&_userInfo.avator.count>0) {
            [ImageLoader loadImageWithCache:_userInfo.avator[0] imageView:self.imageView placeholder:@""];
        }
        CGSize size = CGSizeMake(33, 16);
        UIImage *image1;
        UIColor *color1;
        if ([_userInfo.sex intValue]==0) {//女
            image1 = [ImageLoader loadLocalBundleImg:@"personal_icon_label_girl"];
            color1 = [UIColor colorWithHex:@"ffc4fc"];
        }else{
            image1 = [ImageLoader loadLocalBundleImg:@"personal_icon_label_boy"];
            color1 = [UIColor colorWithHex:@"acd7ff"];
        }
        
        if ([NSString isNotBlank:_userInfo.birthday]) {
            UIImage *sexAgeImg = [UIImage imageWithRect:size image:image1 text:[NSString getAgeWithBirthday:_userInfo.birthday] color:color1];
            [self.sexAgeView setImage:sexAgeImg];
            
            CGSize size1 = CGSizeMake(38*LayoutUtil.scaling, 16*LayoutUtil.scaling);
            UIImage *starImg = [UIImage imageWithRect:size1 image:nil text:[NSString getConstellationWithBirthday:userInfo.birthday] color:[UIColor colorWithHex:@"acd7ff"]];
            [self.starView setImage:starImg];
        }
        self.nameLab.text = _userInfo.name;
        self.identityLab.text = _userInfo.profession;
    }
}
@end
