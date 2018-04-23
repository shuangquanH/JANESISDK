//
//  JSTFUserSexVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserSexVC.h"

@interface JSTFUserSexVC ()

@property(nonatomic, strong)UIButton *boyBtn;
@property(nonatomic, strong)UIButton *girlBtn;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, assign)BOOL isSelected;
@property(nonatomic, strong)UserInfo *userInfo;

@end

@implementation JSTFUserSexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{
    self.isSelected = NO;
    self.userInfo = [SystemUtils getUserData];
}
-(void)loadUI{
    self.fd_interactivePopDisabled = YES;
    JSTFWself(weakSelf);
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"请选择性别";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:24*LayoutUtil.scaling];
    titleLab.textColor = [UIColor colorWithHex:@"333333"];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((LayoutUtil.statusBarHeight+26)*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(33*LayoutUtil.scaling);
    }];
    
    UIButton *boyBtn = [[UIButton alloc] init];
    [boyBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_boy_unselect"] forState:UIControlStateNormal];
    [boyBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_boy_select"] forState:UIControlStateHighlighted];
    [boyBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_boy_select"] forState:UIControlStateSelected];
    [self.view addSubview:boyBtn];
    [boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(80*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(80*LayoutUtil.scaling);
        make.height.mas_equalTo(80*LayoutUtil.scaling);
    }];
    self.boyBtn = boyBtn;
    
    UILabel *boyLab = [[UILabel alloc] init];
    boyLab.text = @"男";
    boyLab.textAlignment = NSTextAlignmentCenter;
    boyLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    boyLab.textColor = [UIColor colorWithHex:@"333333"];
    [self.view addSubview:boyLab];
    [boyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(boyBtn.mas_bottom).with.offset(10*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
    UIButton *girlBtn = [[UIButton alloc] init];
    [girlBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_girl_unselect"] forState:UIControlStateNormal];
    [girlBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_girl_select"] forState:UIControlStateHighlighted];
    [girlBtn setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_girl_select"] forState:UIControlStateSelected];
    [self.view addSubview:girlBtn];
    [girlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(boyBtn.mas_bottom).offset(60*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(80*LayoutUtil.scaling);
        make.height.mas_equalTo(80*LayoutUtil.scaling);
    }];
    self.girlBtn = girlBtn;
    
    UILabel *girlLab = [[UILabel alloc] init];
    girlLab.text = @"女";
    girlLab.textAlignment = NSTextAlignmentCenter;
    girlLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    girlLab.textColor = [UIColor colorWithHex:@"333333"];
    [self.view addSubview:girlLab];
    [girlLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(girlBtn.mas_bottom).with.offset(10*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    nextBtn.backgroundColor = [UIColor colorWithHex:@"9013fe"];
    [nextBtn.layer setCornerRadius:9*LayoutUtil.scaling];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [nextBtn setTitleColor:[UIColor colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-38*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(300*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    self.nextBtn = nextBtn;
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"性别选定后将不能更改";
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    tipLab.textColor = [UIColor colorWithHex:@"333333"];
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nextBtn.mas_top).with.offset(-25*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
    [self.boyBtn addTarget:self action:@selector(boyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.girlBtn addTarget:self action:@selector(girlBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)boyBtnClick{
    if (!self.isSelected) {
        [SVProgressHUD showInfoWithStatus:@"选择性别以后将不能修改！"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
    self.boyBtn.selected = YES;
    self.girlBtn.selected = NO;
    self.isSelected = YES;
    self.userInfo.sex = @(1);
}
-(void)girlBtnClick{
    if (!self.isSelected) {
        [SVProgressHUD showInfoWithStatus:@"选择性别以后将不能修改！"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
    self.girlBtn.selected = YES;
    self.boyBtn.selected = NO;
    self.isSelected = YES;
    self.userInfo.sex = @(0);
}
-(void)nextBtnClick{
    if (!self.userInfo.sex||[self.userInfo.sex intValue]<0) {
        [SVProgressHUD showInfoWithStatus:@"请选择性别!"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:self.userInfo forKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserProfileVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
    
}
@end
