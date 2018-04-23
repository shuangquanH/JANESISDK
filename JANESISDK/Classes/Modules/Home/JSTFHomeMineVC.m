//
//  JSTFHomeMineVC.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeMineVC.h"

@interface JSTFHomeMineVC ()

@property(nonatomic, strong)UIButton *leftNavBtn;
@property(nonatomic, strong)UIButton *rightNavBtn;
@property(nonatomic, strong)UIImageView *avatorView;
@property(nonatomic, strong)UILabel *nameLab;
@end

@implementation JSTFHomeMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    UserInfo *user = [SystemUtils getUserData];
    if (!user) return;
    if (user.avator&&user.avator.count>0) {
        [ImageLoader loadImageWithCache:user.avator[0] imageView:self.avatorView placeholder:nil];
    }
    self.nameLab.text = user.name;
}
-(void)loadUI{
    [self configNavUI:@"我的" isShowBack:NO];
    
    UIView *avatarBG = [[UIView alloc] init];
    avatarBG.backgroundColor = [UIColor colorWithHex:@"d7d9df"];
    [avatarBG.layer setCornerRadius:120/2*LayoutUtil.scaling];
    [avatarBG.layer setMasksToBounds:YES];
    kAddSubView(self.view, avatarBG);
    JSTFWself(weakSelf);
    [avatarBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(166*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(120*LayoutUtil.scaling);
        make.height.mas_equalTo(120*LayoutUtil.scaling);
    }];
    
    UIImageView *avatar = [[UIImageView alloc] init];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    [avatar.layer setCornerRadius:100/2*LayoutUtil.scaling];
    [avatar.layer setMasksToBounds:YES];
    [avatarBG addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avatarBG.mas_centerX);
        make.centerY.equalTo(avatarBG.mas_centerY);
        make.width.mas_equalTo(100*LayoutUtil.scaling);
        make.height.mas_equalTo(100*LayoutUtil.scaling);
    }];
    self.avatorView = avatar;
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"";
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont boldSystemFontOfSize:24*LayoutUtil.scaling];
    nameLab.textColor = [UIColor colorWithHex:@"333333"];
    kAddSubView(self.view, nameLab);
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarBG.mas_bottom).with.offset(47.5*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(33*LayoutUtil.scaling);
    }];
    self.nameLab = nameLab;
    
    UILabel *personLab = [[UILabel alloc] init];
    personLab.text = @"查看或编辑个人资料";
    personLab.textAlignment = NSTextAlignmentCenter;
    personLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    personLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    kAddSubView(self.view, personLab);
    [personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).with.offset(9*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
    UIButton *moveBtn = [[UIButton alloc] init];
    [moveBtn setImage:[ImageLoader loadLocalBundleImg:@"home_icon_move"] forState:UIControlStateNormal];
    kAddSubView(self.view, moveBtn);
    [moveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personLab.mas_bottom).with.offset(38.5*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(36*LayoutUtil.scaling);
        make.height.mas_equalTo(36*LayoutUtil.scaling);
    }];
    [moveBtn addTarget:self action:@selector(moveToUserDetailPage) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)configNavUI:(NSString *)title isShowBack:(BOOL)isShow{
    [super configNavUI:title isShowBack:isShow];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"设置" forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16*LayoutUtil.scaling]];
    [leftBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.navBarView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10.5*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.width.mas_equalTo(63*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    self.leftNavBtn = leftBtn;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"反馈" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16*LayoutUtil.scaling]];
    [rightBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.navBarView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10.5*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.width.mas_equalTo(63*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    self.rightNavBtn = rightBtn;
    
    [self.leftNavBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightNavBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftBtnClick{
    //JSTFSystemSettingsVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFSystemSettingsVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(void)rightBtnClick{
    //JSTFFeedBackVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFFeedBackVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(void)moveToUserDetailPage{
    //JSTFUserInfoDetailVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:@(YES) forKey:@"isSelf"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserInfoDetailVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
@end
