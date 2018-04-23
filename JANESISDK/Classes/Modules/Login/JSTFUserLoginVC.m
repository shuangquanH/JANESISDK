//
//  JSTFUserLoginVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserLoginVC.h"
#import "ValidateUtil.h"
#import "UIView+Extension.h"
#import "JSTFBaseTBC.h"
#import "JSTFBaseNC.h"

@interface JSTFUserLoginVC ()

@property(nonatomic, strong)UITextField *phoneTF;
@property(nonatomic, strong)UITextField *vaildTF;
@property(nonatomic, strong)UIButton *vaildBtn;
@property(nonatomic, strong)UIButton *loginBtn;

@end

@implementation JSTFUserLoginVC

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
    
}
-(void)loadUI{
    JSTFWself(weakSelf);
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [bgView setImage:[ImageLoader loadLocalBundleImg:@"login_img_bg"]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = [NSString stringWithFormat:@"欢迎进入%@",APP_DISPLAYNAME];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:36*LayoutUtil.scaling];
    titleLab.textColor = [UIColor colorWithHex:@"ffffff"];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80*LayoutUtil.scaling);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor colorWithHex:@"ffffff" alpha:0.3];
    [phoneView.layer setCornerRadius:9*LayoutUtil.scaling];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(125*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(289*LayoutUtil.scaling);
        make.height.mas_equalTo(45*LayoutUtil.scaling);
    }];
    
    UITextField *phoneTF = [[UITextField alloc] init];
    phoneTF.placeholder = @"手机号码:";
    phoneTF.textColor = [UIColor colorWithHex:@"ffffff"];
    phoneTF.textAlignment = NSTextAlignmentLeft;
    phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [phoneView addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8*LayoutUtil.scaling);
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.right.mas_equalTo(-12*LayoutUtil.scaling);
        make.bottom.mas_equalTo(-8*LayoutUtil.scaling);
    }];
    self.phoneTF = phoneTF;
    
    UIView *vaildView = [[UIView alloc] init];
    vaildView.backgroundColor = [UIColor colorWithHex:@"ffffff" alpha:0.3];
    [vaildView.layer setCornerRadius:9*LayoutUtil.scaling];
    [self.view addSubview:vaildView];
    [vaildView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).with.offset(15*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(289*LayoutUtil.scaling);
        make.height.mas_equalTo(45*LayoutUtil.scaling);
    }];
    
    UIButton *vaildBtn = [[UIButton alloc] init];
    [vaildBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    vaildBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [vaildBtn setTitleColor:[UIColor colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [vaildView addSubview:vaildBtn];
    [vaildBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8*LayoutUtil.scaling);
        make.bottom.mas_equalTo(-8*LayoutUtil.scaling);
        make.right.mas_equalTo(-8*LayoutUtil.scaling);
        make.width.mas_equalTo(100*LayoutUtil.scaling);
    }];
    self.vaildBtn = vaildBtn;

    UITextField *vaildTF = [[UITextField alloc] init];
    vaildTF.placeholder = @"验证码:";
    vaildTF.textColor = [UIColor colorWithHex:@"ffffff"];
    vaildTF.textAlignment = NSTextAlignmentLeft;
    vaildTF.keyboardType = UIKeyboardTypeNumberPad;
    [vaildView addSubview:vaildTF];
    [vaildTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8*LayoutUtil.scaling);
        make.bottom.mas_equalTo(-8*LayoutUtil.scaling);
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.right.mas_equalTo((-100-8*2)*LayoutUtil.scaling);
    }];
    self.vaildTF = vaildTF;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [loginBtn.layer setCornerRadius:9*LayoutUtil.scaling];
    [loginBtn setTitle:@"进入" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18*LayoutUtil.scaling];
    [loginBtn setTitleColor:[UIColor colorWithHex:@"9013fe"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vaildView.mas_bottom).with.offset(142*LayoutUtil.scaling);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(289*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    self.loginBtn = loginBtn;
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.textColor = [UIColor colorWithHex:@"ffffff"];
    tipLab.text = @"如未注册，将自动创建用户《用户协议》";
    UITapGestureRecognizer  *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tiplabAction)];
    tipLab.userInteractionEnabled = YES;
    [tipLab addGestureRecognizer:tap];
    
    
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).with.offset(20*LayoutUtil.scaling);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    
    
    //添加点击事件
    [self.vaildBtn addTarget:self action:@selector(vaildClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tiplabAction {
    JSTFBaseVC  *web = [[JSTFBaseVC alloc] init];
    [web configNavUI:@"用户协议" isShowBack:YES];
    NSDictionary    *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"KPARAMFORJANESIAPI"];
    web.webUrl = dic[@"protocolUrl"];
    [self.navigationController pushViewController:web animated:YES];
}


// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.vaildBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.vaildBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.vaildBtn setTitle:[NSString stringWithFormat:@"%ds", seconds] forState:UIControlStateNormal];
                self.vaildBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)vaildClick{
    NSString *phone = self.phoneTF.text;
    if (![ValidateUtil validatePhone:phone]){
        [SVProgressHUD showInfoWithStatus:@"请输入有效的手机号"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    //请求手机验证码
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_Phone_Verify];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phone"];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString *code = responseObject[@"code"];
        if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
            [SVProgressHUD showInfoWithStatus:@"发送成功"];
            [SVProgressHUD dismissWithDelay:1.5f];
            [self openCountdown];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            [SVProgressHUD dismissWithDelay:1.5f];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络~"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}
-(void)loginClick{
    NSString *phone = self.phoneTF.text;
    NSString *code = self.vaildTF.text;
    if (![ValidateUtil validatePhone:phone]){
        [SVProgressHUD showInfoWithStatus:@"请输入有效的手机号"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    //请求登录接口
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_LOGIN];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:code forKey:@"verify"];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString *code = responseObject[@"code"];
        if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
            UserInfo *info = [UserInfo yy_modelWithDictionary:(NSDictionary *)responseObject[@"result"]];
            if (info) {
                NSData *Info = [NSKeyedArchiver archivedDataWithRootObject:info];
                [UserDefaultsUtil updateValue:Info forKey:@"JSTF_UserInfo"];
                if (!info.tager||![info.tager boolValue]) {
                    [self jumpToSexPage];
                    //更新tag值
                    [SystemUtils updateUserLoginTager:NO];
                }else{
                    [self jumpToMainPage];
                    //更新tag值
                    [SystemUtils updateUserLoginTager:YES];
                }
            }
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            [SVProgressHUD dismissWithDelay:1.5f];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络~"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}
-(void)jumpToSexPage{
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserSexVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(void)jumpToMainPage{
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [PageJumpRouter jumpToMainPage];
        }];
    }
}
@end
