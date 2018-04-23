//
//  JSTFUserProfileEditVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/9.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserProfileEditVC.h"

@interface JSTFUserProfileEditVC ()

@property(nonatomic, strong)UserInfo *userInfo;
@property(nonatomic, strong)UITextField *sexTF;
@property(nonatomic, strong)UITextField *nameTF;
@property(nonatomic, strong)UITextField *birthTF;

@property(nonatomic, strong)UIDatePicker *datePicker;
@end

@implementation JSTFUserProfileEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    if ([self.userInfo.sex intValue]==0) {//女
        self.sexTF.text = @"女";
    }else{
        self.sexTF.text = @"男";
    }
    self.nameTF.text = self.userInfo.name;
//    NSTimeInterval interval = [self.userInfo.birthday longLongValue]/1000.0;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    self.birthTF.text = [formatter stringFromDate: date];
    self.birthTF.text = self.userInfo.birthday;
}
-(void)loadUI{
    [self configNavUI:@"个人信息" isShowBack:YES];
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.navBarView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.statusBarHeight);
        make.right.mas_equalTo(-12*LayoutUtil.scaling);
        make.width.mas_equalTo(39*LayoutUtil.scaling);
        make.height.mas_equalTo(LayoutUtil.navBarHeight-LayoutUtil.statusBarHeight);
    }];
    [saveBtn addTarget:self action:@selector(saveUserProfile) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    
    UIView *sexView = [[UIView alloc] init];
    sexView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, sexView);
    [sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight+16*LayoutUtil.scaling);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    UILabel *sexLab = [[UILabel alloc] init];
    sexLab.text = @"性别";
    sexLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    sexLab.textColor = [UIColor colorWithHex:@"333333"];
    [sexView addSubview:sexLab];
    [sexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(sexView.mas_centerY);
        make.width.mas_equalTo(33*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    UITextField *sexTF = [[UITextField alloc] init];
    sexTF.textAlignment = NSTextAlignmentRight;
    sexTF.textColor = [UIColor colorWithHex:@"cccccc"];
    sexTF.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    sexTF.userInteractionEnabled = NO;
    [sexView addSubview:sexTF];
    [sexTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16*LayoutUtil.scaling);
        make.centerY.equalTo(sexView.mas_centerY);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
        make.left.equalTo(sexLab.mas_right).offset(15*LayoutUtil.scaling);
    }];
    self.sexTF = sexTF;
    
    UIView *nameView = [[UIView alloc] init];
    nameView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, nameView);
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sexView.mas_bottom).offset(15*LayoutUtil.scaling);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"昵称";
    nameLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    nameLab.textColor = [UIColor colorWithHex:@"333333"];
    [nameView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(nameView.mas_centerY);
        make.width.mas_equalTo(33*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.textAlignment = NSTextAlignmentRight;
    nameTF.textColor = [UIColor colorWithHex:@"cccccc"];
    nameTF.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [nameView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16*LayoutUtil.scaling);
        make.centerY.equalTo(nameView.mas_centerY);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
        make.left.equalTo(nameLab.mas_right).offset(15*LayoutUtil.scaling);
    }];
    self.nameTF = nameTF;
    
    UIView *birthView = [[UIView alloc] init];
    birthView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, birthView);
    [birthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(15*LayoutUtil.scaling);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    UILabel *birthLab = [[UILabel alloc] init];
    birthLab.text = @"生日";
    birthLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    birthLab.textColor = [UIColor colorWithHex:@"333333"];
    [birthView addSubview:birthLab];
    [birthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(birthView.mas_centerY);
        make.width.mas_equalTo(33*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    UITextField *birthTF = [[UITextField alloc] init];
    birthTF.textAlignment = NSTextAlignmentRight;
    birthTF.textColor = [UIColor colorWithHex:@"cccccc"];
    birthTF.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [birthView addSubview:birthTF];
    [birthTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16*LayoutUtil.scaling);
        make.centerY.equalTo(birthView.mas_centerY);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
        make.left.equalTo(birthLab.mas_right).offset(15*LayoutUtil.scaling);
    }];
    self.birthTF = birthTF;
    [birthTF addTarget:self action:@selector(birthTFClick) forControlEvents:UIControlEventEditingDidBegin];
    [self setBirthdayField];
}
- (void)birthTFClick{
    [self valueChange:self.datePicker];
}
- (void)setBirthdayField{
    //创建UIDatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //设置本地语言
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //设置日期显示的格式
    datePicker.datePickerMode = UIDatePickerModeDate;
    //设置_birthdayField的inputView控件为datePicker
    self.birthTF.inputView = datePicker;
    self.datePicker = datePicker;
    //监听datePicker的ValueChanged事件
    [datePicker addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChange:(UIDatePicker *)datePicker{
    //创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //将日期转为指定格式显示
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    self.birthTF.text = dateStr;
    self.userInfo.birthday = dateStr;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    //确保加载时也能获取datePicker的文字
    [self valueChange:self.datePicker];
}
-(void)saveUserProfile{
    NSString *name = self.nameTF.text;
    self.userInfo.name = name;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.userInfo forKey:@"userInfo"];
    // 2.创建通知
    NSNotification *notification =[NSNotification notificationWithName:JSTFUserInfoProfile_DidChange_Notification object:nil userInfo:dict];
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
