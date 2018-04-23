//
//  JSTFBaseVC.m
//  JSTempFun
//
//  Created by mc on 2018/3/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "JSTFBaseVC.h"

@interface JSTFBaseVC ()

@property(nonatomic, assign)BOOL isStatusBarLightContent;

@end

@implementation JSTFBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = NO;
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = PanGestureLeftEdge;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    if (@available(iOS 11.0, *)) {
//        self.home_collectionView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
//    }
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self baseClickEmptyView];
}
-(void)baseClickEmptyView{
    [SystemUtils hideKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setIsStatusBarLightContent:(BOOL)isStatusBarLightContent{
    BOOL oldValue = self.isStatusBarLightContent;
    self.isStatusBarLightContent = isStatusBarLightContent;
    if (oldValue!=self.isStatusBarLightContent) {
        [self setStatusBarStyle];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarStyle];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.isStatusBarLightContent?UIStatusBarStyleLightContent:UIStatusBarStyleDefault;
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}
-(void)setStatusBarStyle{
    if (self.isStatusBarLightContent) {
        if(self.navigationController){
            self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//设置为白色
            return;
        }
    }else{
        if(self.navigationController){
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//设置为黑色
            return;
        }
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)configNavUI:(NSString *)title isShowBack:(BOOL)isShow{
    
    UIView *navBar = [[UIView alloc] init];
    navBar.backgroundColor = JSTFNavBarColor;
    [self.view addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(LayoutUtil.navBarHeight);
    }];
    self.navBarView = navBar;
    
    //设置分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(241, 241, 241);
    [navBar addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    //设置title
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = JSTFNavBarTextColor;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.text = [NSString isNotBlank:title]?title:@"";
    [navBar addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.statusBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(LayoutUtil.navBarHeight-LayoutUtil.statusBarHeight);
    }];
    
    if (!isShow) return;
    //设置返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[ImageLoader loadLocalBundleImg:@"nav_icon_back_black"] forState:UIControlStateNormal];
    [navBar addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.statusBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(39*LayoutUtil.scaling);
        make.height.mas_equalTo(LayoutUtil.navBarHeight-LayoutUtil.statusBarHeight);
    }];
    [backBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)backToHome{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
    NSURL *theurl = [NSURL URLWithString:webUrl];
    [self.webview loadRequest:[NSURLRequest requestWithURL: theurl]];
}

- (UIWebView    *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] init];
        [self.view addSubview:_webview];
        [_webview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.mas_equalTo(LayoutUtil.navBarHeight);
        }];
    }
    return _webview;
}
@end
