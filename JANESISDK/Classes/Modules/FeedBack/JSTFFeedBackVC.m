//
//  JSTFFeedBackVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFFeedBackVC.h"
#import "JSTFLimitTextView.h"
#define FEEDBACK_NUM_LIMIT 100

@interface JSTFFeedBackVC ()<UITextViewExtensionDelegate>

@property(nonatomic, strong)JSTFLimitTextView *contentView;
@property(nonatomic, strong)UILabel *numLab;

@end

@implementation JSTFFeedBackVC

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
    [self configNavUI:@"反馈" isShowBack:YES];
    
    self.view.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, bgView);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight+0*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(180*LayoutUtil.scaling);
    }];
    
    JSTFLimitTextView *textView = [[JSTFLimitTextView alloc] initWithDelegate:self];
    textView.limitNum = FEEDBACK_NUM_LIMIT;
    textView.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [bgView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(bgView.mas_bottom).offset(-22*LayoutUtil.scaling);
    }];
    self.contentView = textView;
    
    UILabel *numLab = [[UILabel alloc] init];
    numLab.text = [NSString stringWithFormat:@"0/%@",@(FEEDBACK_NUM_LIMIT)];
    numLab.textAlignment = NSTextAlignmentRight;
    numLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    numLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    [bgView addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.5*LayoutUtil.scaling);
        make.bottom.mas_equalTo(-5.5*LayoutUtil.scaling);
        make.left.mas_equalTo(10.5*LayoutUtil.scaling);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    self.numLab = numLab;
    
}
-(void)configNavUI:(NSString *)title isShowBack:(BOOL)isShow{
    [super configNavUI:title isShowBack:isShow];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
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
-(void)textDidChange:(UITextView *)textView textLength:(NSInteger)num{
    self.numLab.text = [NSString stringWithFormat:@"%@/%@",@(num),@(FEEDBACK_NUM_LIMIT)];
}
-(void)rightBtnClick{
    //提交数据
    NSString *content = self.contentView.text;
    if ([NSString isBlank:content]) {
        [SVProgressHUD showSuccessWithStatus:@"内容不能为空"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:content forKey:@"content"];
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USERINFO_FEEDBACK];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dict methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
    
    } failure:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    [SVProgressHUD dismissWithDelay:1.5f];
}
@end
