//
//  JSTFUserInfoTagAddVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/9.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoTagAddVC.h"
#import "JSTFUserInfoTagVC.h"

@interface JSTFUserInfoTagAddVC ()
@property(nonatomic, copy)NSString *navTitle;
@property(nonatomic, strong)NSString *groupName;
@property(nonatomic, strong)UITextField *tagTF;
@end

@implementation JSTFUserInfoTagAddVC

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
    [self configNavUI:self.navTitle isShowBack:YES];
    self.view.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, headView);
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16*LayoutUtil.scaling+LayoutUtil.navBarHeight);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    
    UITextField *tagTF = [[UITextField alloc] init];
    tagTF.placeholder = @"添加标签";
    tagTF.textColor = [UIColor colorWithHex:@"333333"];
    tagTF.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [headView addSubview:tagTF];
    [tagTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*LayoutUtil.scaling);
        make.right.mas_equalTo(-20*LayoutUtil.scaling);
        make.centerY.equalTo(headView.mas_centerY);
        make.height.mas_equalTo(30*LayoutUtil.scaling);
    }];
    self.tagTF = tagTF;
    
}
-(void)configNavUI:(NSString *)title isShowBack:(BOOL)isShow{
    [super configNavUI:title isShowBack:isShow];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.navBarView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10.5);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(63);
        make.height.mas_equalTo(22);
    }];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)rightBtnClick{
    NSString *tag = self.tagTF.text;
    if([NSString isBlank:tag]){
        [SVProgressHUD showInfoWithStatus:@"标签名不能为空"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(1) forKey:@"labelId"];
    [dic setObject:self.groupName forKey:@"name"];
    [dic setObject:tag forKey:@"labelName"];
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USERINFO_TAG_ADD];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString *code = responseObject[@"code"];
        if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
            if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
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
@end
