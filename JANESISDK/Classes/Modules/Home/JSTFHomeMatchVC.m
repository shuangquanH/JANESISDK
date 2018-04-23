//
//  JSTFHomeMatchVC.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeMatchVC.h"
#import "CCDraggableContainer.h"
#import "JSTFHomeMatchCardView.h"
#import "JSTFHomeMatchHandleView.h"
#import "JSTFHomeMatchCircleView.h"

#import "LocationServer.h"

@interface JSTFHomeMatchVC ()<CCDraggableContainerDelegate,CCDraggableContainerDataSource>

@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIView *animateView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, strong) JSTFHomeMatchHandleView *unLikeView;
@property (nonatomic, strong) JSTFHomeMatchHandleView *likeView;
@end

@implementation JSTFHomeMatchVC

-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer=nil;
    }
}
-(NSMutableArray *)dataSources{
    if (_dataSources==nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
-(JSTFHomeMatchHandleView *)unLikeView{
    if (_unLikeView==nil) {
        _unLikeView = [[JSTFHomeMatchHandleView alloc] initWithHandleType:MatchHandleTypeUnLike];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unLikeTap)];
        [_unLikeView addGestureRecognizer:tap];
    }
    return _unLikeView;
}
-(JSTFHomeMatchHandleView *)likeView{
    if (_likeView==nil) {
        _likeView = [[JSTFHomeMatchHandleView alloc] initWithHandleType:MatchHandleTypeLike];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeTap)];
        [_likeView addGestureRecognizer:tap];
    }
    return _likeView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [LocationServer getLocation];
    [self loadUI];
    [self loadData];
}

-(void)loadData{
    [self showSearchView];
    UserInfo *user = [SystemUtils getUserData];
    if (!user) return;
    //请求登录接口
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_MATCH_NEAR_LIST];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:user.userId forKey:@"userId"];
        JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *code = responseObject[@"code"];
                    if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                        NSArray *infos = [NSArray yy_modelArrayWithClass:[UserInfo class] json:responseObject[@"result"]];
                        [self.dataSources removeAllObjects];
                        [self.dataSources addObjectsFromArray:infos];
                        [self.container reloadData];
                        [self hiddenSearchView];
                    }else{
                        [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                        [SVProgressHUD dismissWithDelay:1.5f];
                    }
                });
            });
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络~"];
            [SVProgressHUD dismissWithDelay:1.5f];
        }];
        
    });
    
}

-(void)loadUI{
    [self configNavUI:APP_DISPLAYNAME isShowBack:NO];
    // 初始化Container
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, LayoutUtil.navBarHeight, LayoutUtil.screenWidth, LayoutUtil.screenHeight-LayoutUtil.navBarHeight-LayoutUtil.tabBarHeight) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    self.container.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    
    kAddSubView(self.view,self.container);
    
    kAddSubView(self.view, self.unLikeView);
    [self.unLikeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(95*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.width.mas_equalTo(73*LayoutUtil.scaling);
        make.height.mas_equalTo(74*LayoutUtil.scaling);
    }];
    kAddSubView(self.view, self.likeView);
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(95*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.width.mas_equalTo(73*LayoutUtil.scaling);
        make.height.mas_equalTo(74*LayoutUtil.scaling);
    }];
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, maskView);
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.searchView = maskView;
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [ImageLoader loadLocalBundleImg:@"home_img_match_bg"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [maskView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0*LayoutUtil.scaling);
    }];
    
    JSTFHomeMatchCircleView *animateViewBG = [[JSTFHomeMatchCircleView alloc] init];
    [maskView addSubview:animateViewBG];
    [animateViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(maskView.mas_centerX);
        make.centerY.equalTo(maskView.mas_centerY);
        make.width.mas_equalTo(100*LayoutUtil.scaling);
        make.height.mas_equalTo(100*LayoutUtil.scaling);
    }];
    self.animateView = animateViewBG;
    
    
    UIView *avatarBG = [[UIView alloc] init];
    avatarBG.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [avatarBG.layer setCornerRadius:100/2*LayoutUtil.scaling];
    [avatarBG.layer setMasksToBounds:YES];
    [maskView addSubview:avatarBG];
    [avatarBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(maskView.mas_centerX);
        make.centerY.equalTo(maskView.mas_centerY);
        make.width.mas_equalTo(100*LayoutUtil.scaling);
        make.height.mas_equalTo(100*LayoutUtil.scaling);
    }];
    
    UIImageView *avatar = [[UIImageView alloc] init];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    [avatar.layer setCornerRadius:100/2*LayoutUtil.scaling];
    [avatar.layer setMasksToBounds:YES];
    [maskView addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(maskView.mas_centerX);
        make.centerY.equalTo(maskView.mas_centerY);
        make.width.mas_equalTo(96*LayoutUtil.scaling);
        make.height.mas_equalTo(96*LayoutUtil.scaling);
    }];
    avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)];
    [avatar addGestureRecognizer:tap];
    self.avatarView = avatar;
    UserInfo *user = [SystemUtils getUserData];
    if (user&&user.avator&&user.avator.count>0){
        [ImageLoader loadImageWithCache:user.avator[0] imageView:avatar placeholder:nil];
    }
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"正在为你寻找附近的人...";
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:18*LayoutUtil.scaling];
    tipLab.textColor = [UIColor colorWithHex:@"030303"];
    [maskView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(25*LayoutUtil.scaling);
    }];
}
-(void)avatarClick{
    [self loadData];
}
-(void)showSearchView{
    self.searchView.hidden = NO;
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)hiddenSearchView{
    self.searchView.hidden = YES;
    [self.timer setFireDate:[NSDate distantFuture]];
}
-(void)loadNearUI{
    
}
-(NSTimer *)timer{
    if (_timer==nil) {
        _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(beginAnimate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
-(void)beginAnimate{
    //告知需要更改约束
    [self.view setNeedsUpdateConstraints];
    [self.animateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100*LayoutUtil.scaling);
        make.height.mas_equalTo(100*LayoutUtil.scaling);
    }];
    [self.animateView.superview layoutIfNeeded];
    [UIView animateWithDuration:2.0f animations:^{
        [self.animateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LayoutUtil.screenWidth);
            make.height.mas_equalTo(LayoutUtil.screenWidth);
        }];
        //告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.animateView.superview layoutIfNeeded];
    }];
}
-(void)unLikeTap{
    [self.container removeForDirection:CCDraggableDirectionLeft];
}
-(void)likeTap{
    [self.container removeForDirection:CCDraggableDirectionRight];
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    JSTFHomeMatchCardView *cardView = [[JSTFHomeMatchCardView alloc] initWithFrame:draggableContainer.bounds];
    if (index<self.dataSources.count) {
        [cardView setUserInfo:self.dataSources[index]];
    }
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return self.dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 2;
    if (draggableDirection == CCDraggableDirectionLeft) {
         self.unLikeView.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
         self.likeView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection finishedMoveIndex:(NSInteger)index {
    
    if (draggableDirection == CCDraggableDirectionLeft) {
        
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        [self doLinkeUser:index];
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    //
    if(!(didSelectIndex<self.dataSources.count)){
        [SVProgressHUD showInfoWithStatus:@"数据出错，请重新刷新数据"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    UserInfo *toUser = self.dataSources[didSelectIndex];
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:toUser forKey:@"userInfo"];
    [property setObject:@(NO) forKey:@"isSelf"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserInfoDetailVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    [self loadData];
}

-(void)doLinkeUser:(NSInteger)index{
    if(!(index<self.dataSources.count)) return;
    UserInfo *toUser = self.dataSources[index];
    //JSTF_API_USER_FRIEND
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UserInfo *user = [SystemUtils getUserData];
        NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_FRIEND];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:user.userId forKey:@"userId"];
        [dic setObject:toUser.userId forKey:@"toUserId"];
        JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    NSDictionary *dic = responseObject[@"result"];
                    if (dic) {
                        NSNumber *togetherFriend = [dic objectForKey:@"togetherFriend"];
                        if (togetherFriend&&![togetherFriend isKindOfClass:[NSNull class]]&&[togetherFriend boolValue]) {
                            [SVProgressHUD showSuccessWithStatus:@"匹配成功"];
                            [SVProgressHUD dismissWithDelay:1.5f];
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
@end
