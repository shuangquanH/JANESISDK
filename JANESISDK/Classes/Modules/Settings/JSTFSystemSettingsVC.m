//
//  JSTFSystemSettingsVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFSystemSettingsVC.h"
#import "JSTFSystemSettingsCell.h"

static NSString *cellID = @"JSTFSystemSettingsCell";
@interface JSTFSystemSettingsVC ()<UITableViewDelegate,UITableViewDataSource,JSTFSystemSettingsCellDelegate>

@property(nonatomic, strong)UITableView *settingsView;
//@property(nonatomic, strong)NSMutableArray *sysArr;
@property(nonatomic, strong)UIButton *exitBtn;
@property(nonatomic, copy)NSString *push;
@end

@implementation JSTFSystemSettingsVC

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
    
    UserInfo *user = [SystemUtils getUserData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_PUSH];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:user.userId forKey:@"userId"];
        JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    NSDictionary *dict = responseObject[@"result"];
                    if (dict&&[dict isKindOfClass:[NSDictionary class]]) {
                        NSString *isPush = dict[@"push"];
                        if ([NSString isNotBlank:isPush]) {
                            self.push = isPush;
                            [self.settingsView reloadData];
                        }
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                    [SVProgressHUD dismissWithDelay:1.5f];
                }
            });
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络~"];
            [SVProgressHUD dismissWithDelay:1.5f];
        }];
        
    });
    
}
-(void)loadUI{
    [self configNavUI:@"设置" isShowBack:YES];
    self.view.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    kAddSubView(self.view, self.settingsView);
    [self.settingsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight+15*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    
    UIButton *exitBtn = [[UIButton alloc] init];
    exitBtn.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor colorWithHex:@"ff3b30"] forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    kAddSubView(self.view, exitBtn);
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.settingsView.mas_bottom).offset(42*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    self.exitBtn = exitBtn;
    
    [self.exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)openPushBtn:(BOOL)isOpen{
    UserInfo *user = [SystemUtils getUserData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_PUSH_EDIT];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:user.userId forKey:@"userId"];
        if (isOpen) {
            [dic setObject:@"PUSH" forKey:@"pushBehavior"];
        }else{
            [dic setObject:@"UNPUSH" forKey:@"pushBehavior"];
        }
        JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    NSDictionary *dict = responseObject[@"result"];
                    if (dict&&[dict isKindOfClass:[NSDictionary class]]) {
                        NSString *isPush = dict[@"push"];
                        if ([NSString isNotBlank:isPush]) {
                            self.push = isPush;
                            [self.settingsView reloadData];
                        }
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                    [SVProgressHUD dismissWithDelay:1.5f];
                }
            });
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络~"];
            [SVProgressHUD dismissWithDelay:1.5f];
        }];
        
    });
}

#pragma MARK - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSTFSystemSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[JSTFSystemSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row==0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([NSString isNotBlank:self.push]) {
            [dic setObject:self.push forKey:@"push"];
        }
        [dic setObject:@"推送" forKey:@"title"];
        [cell configUI:dic];
        cell.delegate=self;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma MARK - custom
-(void)exitBtnClick{
    [UserDefaultsUtil removeValue:@"JSTF_UserInfo"];
    [PageJumpRouter jumpToLoginPage];
}
-(UITableView *)settingsView{
    if (_settingsView==nil) {
        _settingsView = [[UITableView alloc] init];
        _settingsView.delegate = self;
        _settingsView.dataSource = self;
        [_settingsView registerClass:[JSTFSystemSettingsCell class] forCellReuseIdentifier:cellID];
        _settingsView.tableHeaderView = [[UIView alloc]init];
        _settingsView.tableFooterView = [[UIView alloc]init];
        _settingsView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _settingsView.bounces = NO;
    }
    return _settingsView;
}
@end
