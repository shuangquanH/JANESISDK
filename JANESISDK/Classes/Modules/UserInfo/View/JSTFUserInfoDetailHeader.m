//
//  JSTFUserInfoDetailHeader.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoDetailHeader.h"
#import "SDCycleScrollView.h"
@interface JSTFUserInfoDetailHeader()<SDCycleScrollViewDelegate>

@property(nonatomic, strong)SDCycleScrollView *photoView;
@property(nonatomic, strong)UIView *infoView;
@property(nonatomic, strong)UILabel *nameLab;
@property(nonatomic, strong)UIImageView *sexAgeView;
@property(nonatomic, strong)UIImageView *starView;
@property(nonatomic, strong)UILabel *identityLab;

@end

@implementation JSTFUserInfoDetailHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, LayoutUtil.screenWidth, LayoutUtil.screenWidth) delegate:self placeholderImage:nil];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(LayoutUtil.screenWidth);
    }];
    self.photoView = cycleScrollView;
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cycleScrollView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.infoView = infoView;
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"";
    name.textColor = [UIColor colorWithHex:@"333333"];
    name.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [infoView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*LayoutUtil.scaling);
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.right.mas_equalTo(15*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    self.nameLab = name;
    
    
    CGSize size = CGSizeMake(33, 16);
    UIImage *sexAgeImg = [UIImage imageWithRect:size image:nil text:nil color:[UIColor colorWithHex:@"ffc4fc"]];
    UIImageView *sexAgeView = [[UIImageView alloc] init];
    [sexAgeView setImage:sexAgeImg];
    [infoView addSubview:sexAgeView];
    [sexAgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.top.equalTo(name.mas_bottom).offset(9*LayoutUtil.scaling);
        make.width.mas_equalTo(size.width*LayoutUtil.scaling);
        make.height.mas_equalTo(size.height*LayoutUtil.scaling);
    }];
    self.sexAgeView = sexAgeView;
    
    CGSize size1 = CGSizeMake(38*LayoutUtil.scaling, 16*LayoutUtil.scaling);
    UIImage *starImg = [UIImage imageWithRect:size1 image:nil text:nil color:[UIColor colorWithHex:@"acd7ff"]];
    UIImageView *starView = [[UIImageView alloc] init];
    [starView setImage:starImg];
    [infoView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sexAgeView.mas_right).offset(5*LayoutUtil.scaling);
        make.top.equalTo(sexAgeView.mas_top);
        make.width.mas_equalTo(size1.width);
        make.height.mas_equalTo(size1.height);
    }];
    self.starView = starView;
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"暂无";
    tipLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    tipLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    [infoView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.top.equalTo(sexAgeView.mas_bottom).offset(8*LayoutUtil.scaling);
        make.right.mas_equalTo(15*LayoutUtil.scaling);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    self.identityLab = tipLab;
    
    
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if (_userInfo) {
        if (_userInfo.avator&&_userInfo.avator.count>0) {
            self.photoView.imageURLStringsGroup = _userInfo.avator;
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
            UIImage *starImg = [UIImage imageWithRect:size1 image:nil text:[NSString getConstellationWithBirthday:_userInfo.birthday] color:[UIColor colorWithHex:@"acd7ff"]];
            [self.starView setImage:starImg];
        }
        self.nameLab.text = _userInfo.name;
        if ([NSString isNotBlank:_userInfo.profession]) {
            self.identityLab.text = _userInfo.profession;
        }
        
    }
    
}


@end
