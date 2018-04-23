//
//  JSTFUserInfoEditHeader.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoEditHeader.h"
#import "UIImageView+WebCache.h"

@interface JSTFUserInfoEditHeader()

@property(nonatomic, strong)UIView *photoView;
@property(nonatomic, strong)UIView *infoView;

@property(nonatomic, strong)UILabel *nameLab;
@property(nonatomic, strong)UIImageView *sexAgeView;
@property(nonatomic, strong)UIImageView *starView;
@end
@implementation JSTFUserInfoEditHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    
    UIView *photoView = [[UIView alloc] init];
    photoView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(127*LayoutUtil.scaling);
    }];
    self.photoView = photoView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImage:[ImageLoader loadLocalBundleImg:@"personal_img_photo_add"]];
    imageView.userInteractionEnabled = YES;
    [photoView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3*LayoutUtil.scaling);
        make.left.mas_equalTo(3*LayoutUtil.scaling);
        make.width.mas_equalTo(121*LayoutUtil.scaling);
        make.height.mas_equalTo(121*LayoutUtil.scaling);
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addClick)];
    [self.photoView addGestureRecognizer:tap1];
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoView.mas_bottom);
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
    UIImageView *sexAgeView = [[UIImageView alloc] init];
    UIColor *color1 = [UIColor colorWithHex:@"acd7ff"];
    [sexAgeView setImage:[UIImage imageWithRect:size image:nil text:@"" color:color1]];
    [infoView addSubview:sexAgeView];
    [sexAgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.top.equalTo(name.mas_bottom).offset(9*LayoutUtil.scaling);
        make.width.mas_equalTo(size.width*LayoutUtil.scaling);
        make.height.mas_equalTo(size.height*LayoutUtil.scaling);
    }];
    self.sexAgeView = sexAgeView;
    
    CGSize size1 = CGSizeMake(38*LayoutUtil.scaling, 16*LayoutUtil.scaling);
    UIImage *starImg = [UIImage imageWithRect:size1 image:nil text:@"" color:[UIColor colorWithHex:@"acd7ff"]];
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
    tipLab.text = @"点此编辑个人信息（如年龄、昵称）";
    tipLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    tipLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    [infoView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.top.equalTo(sexAgeView.mas_bottom).offset(8*LayoutUtil.scaling);
        make.right.mas_equalTo(15*LayoutUtil.scaling);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    
    UIImageView *clickView = [[UIImageView alloc] init];
    [clickView setImage:[ImageLoader loadLocalBundleImg:@"cell_icon_click_gray"]];
    [infoView addSubview:clickView];
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.centerY.equalTo(infoView.mas_centerY);
        make.width.mas_equalTo(9*LayoutUtil.scaling);
        make.height.mas_equalTo(14*LayoutUtil.scaling);
    }];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoViewClick)];
    [infoView addGestureRecognizer:tap2];
    
}
-(void)setPhotoImg:(NSArray *)photos{
    if (!photos||photos.count==0) return;
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (photos.count>2) {
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((121*2+3*3)*LayoutUtil.scaling);
        }];
    }else{
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(127*LayoutUtil.scaling);
        }];
    }
    if (photos.count<6) {
        for(int i=0;i<photos.count+1;i++){
            int row = i/3;//行
            int col = i%3;//列
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView.layer setCornerRadius:8*LayoutUtil.scaling];
            [imageView.layer setMasksToBounds:YES];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            if (i==photos.count) {
                [imageView setImage:[ImageLoader loadLocalBundleImg:@"personal_img_photo_add"]];
            }else{
                [imageView sd_setImageWithURL:[NSURL URLWithString:photos[i]] placeholderImage:nil];
            }
            imageView.userInteractionEnabled = YES;
            [self.photoView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo((3+row*(121+3))*LayoutUtil.scaling);
                make.left.mas_equalTo((3+col*(121+3))*LayoutUtil.scaling);
                make.width.mas_equalTo(121*LayoutUtil.scaling);
                make.height.mas_equalTo(121*LayoutUtil.scaling);
            }];
        }
    }else{
        for(int i=0;i<6;i++){
            int row = i/3;//行
            int col = i%3;//列
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView.layer setCornerRadius:8*LayoutUtil.scaling];
            [imageView.layer setMasksToBounds:YES];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView sd_setImageWithURL:[NSURL URLWithString:photos[i]] placeholderImage:nil];
            imageView.userInteractionEnabled = YES;
            [self.photoView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo((3+row*(121+3))*LayoutUtil.scaling);
                make.left.mas_equalTo((3+col*(121+3))*LayoutUtil.scaling);
                make.width.mas_equalTo(121*LayoutUtil.scaling);
                make.height.mas_equalTo(121*LayoutUtil.scaling);
            }];
        }
    }
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if (_userInfo) {
        if (_userInfo.avator&&_userInfo.avator.count>0) {
            [self setPhotoImg:_userInfo.avator];
        }
        self.nameLab.text = userInfo.name;
        CGSize size = CGSizeMake(33, 16);
        UIImage *image1;
        UIColor *color1;
        if ([userInfo.sex intValue]==0) {//女
            image1 = [ImageLoader loadLocalBundleImg:@"personal_icon_label_girl"];
            color1 = [UIColor colorWithHex:@"ffc4fc"];
        }else{
            image1 = [ImageLoader loadLocalBundleImg:@"personal_icon_label_boy"];
            color1 = [UIColor colorWithHex:@"acd7ff"];
        }
        
        if ([NSString isNotBlank:userInfo.birthday]) {
            
            UIImage *sexAgeImg = [UIImage imageWithRect:size image:image1 text:[NSString getAgeWithBirthday:userInfo.birthday] color:color1];
            [self.sexAgeView setImage:sexAgeImg];
            CGSize size1 = CGSizeMake(38*LayoutUtil.scaling, 16*LayoutUtil.scaling);
            UIImage *starImg = [UIImage imageWithRect:size1 image:nil text:[NSString getConstellationWithBirthday:userInfo.birthday] color:[UIColor colorWithHex:@"acd7ff"]];
            [self.starView setImage:starImg];
        }
        
    }
    
}
-(void)infoViewClick{
    if ([self.delegate respondsToSelector:@selector(moveToEditProfilePage)]) {
        [self.delegate moveToEditProfilePage];
    }
}
-(void)addClick{
    if ([self.delegate respondsToSelector:@selector(addMorePhotos)]) {
        [self.delegate addMorePhotos];
    }
}
@end
