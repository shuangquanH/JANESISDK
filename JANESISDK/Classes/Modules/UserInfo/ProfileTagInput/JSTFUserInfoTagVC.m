//
//  JSTFUserInfoTagVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/9.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoTagVC.h"

static NSString *cellID = @"cellID";

@interface JSTFUserInfoTagVC ()<UITableViewDelegate,UITableViewDataSource>

//1-个性标签  2-兴趣标签
@property(nonatomic, assign)NSInteger notifiType;
@property(nonatomic, strong)NSNumber *type;
@property(nonatomic, strong)NSString *groupName;
@property(nonatomic, copy)NSString *navTitle;
@property(nonatomic, strong)NSArray *tagDatas;

@property(nonatomic, strong)NSMutableArray *selectArr;
@property(nonatomic, strong)NSMutableArray *tagArr;

@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation JSTFUserInfoTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USERINFO_TAG];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.groupName forKey:@"name"];
        [dic setObject:@(1) forKey:@"labelId"];
        JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    NSArray *array = responseObject[@"result"];
                    if (array&&![array isKindOfClass:[NSNull class]]&&array.count>0) {
                        [self.tagArr removeAllObjects];
                        [self.tagArr addObjectsFromArray:array];
                    }
                    [self.myTableView reloadData];
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
-(void)loadData{
    if (self.tagDatas&&self.tagDatas.count>0) {
        [self.selectArr addObjectsFromArray:self.tagDatas];
    }
}
-(void)loadUI{
    [self configNavUI:self.navTitle isShowBack:YES];
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    kAddSubView(self.view, headView);
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:[ImageLoader loadLocalBundleImg:@"personal_img_tag_add"]];
    [headView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(headView.mas_centerY);
        make.width.height.mas_equalTo(20*LayoutUtil.scaling);
    }];
    
    UIImageView *icon1 = [[UIImageView alloc] init];
    [icon1 setImage:[ImageLoader loadLocalBundleImg:@"cell_icon_click_gray"]];
    [headView addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.centerY.equalTo(headView.mas_centerY);
        make.width.mas_equalTo(9*LayoutUtil.scaling);
        make.height.mas_equalTo(14*LayoutUtil.scaling);
    }];
    
    UILabel *text = [[UILabel alloc] init];
    text.text = @"添加我的标签";
    text.textColor = [UIColor colorWithHex:@"333333"];
    text.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [headView addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15*LayoutUtil.scaling);
        make.right.equalTo(icon1.mas_left).offset(-15*LayoutUtil.scaling);
        make.centerY.equalTo(headView.mas_centerY);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0*LayoutUtil.scaling);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewClick)];
    [headView addGestureRecognizer:tap];
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
#pragma MARK - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tagArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50*LayoutUtil.scaling;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *content = self.tagArr[indexPath.row];
    cell.textLabel.text = content;
    if([self.selectArr containsObject:content]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *tagName = self.tagArr[indexPath.row];
    if ([self.selectArr containsObject:tagName]) {
        [self.selectArr removeObject:tagName];
    }else{
        [self.selectArr addObject:tagName];
    }
    [self.myTableView reloadData];
}
-(void)rightBtnClick{
    if (self.notifiType==1) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.type forKey:@"type"];
        [dict setObject:self.selectArr forKey:@"content"];
        // 2.创建通知
        NSNotification *notification =[NSNotification notificationWithName:JSTFUserInfoTag_DidChange_Notification object:nil userInfo:dict];
        // 3.通过 通知中心 发送 通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }else if (self.notifiType==2){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.type forKey:@"type"];
        [dict setObject:self.selectArr forKey:@"content"];
        // 2.创建通知
        NSNotification *notification =[NSNotification notificationWithName:JSTFUserInfoInterest_DidChange_Notification object:nil userInfo:dict];
        // 3.通过 通知中心 发送 通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addViewClick{
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:self.navTitle forKey:@"navTitle"];
    [property setObject:self.groupName forKey:@"groupName"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserInfoTagAddVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(UITableView *)myTableView{
    if (nil==_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        _myTableView.tableHeaderView = [[UIView alloc]init];
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.bounces = NO;
    }
    return _myTableView;
}
-(NSMutableArray *)tagArr{
    if (_tagArr==nil) {
        _tagArr = [NSMutableArray array];
    }
    return _tagArr;
}
-(NSMutableArray *)selectArr{
    if (_selectArr==nil) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}
@end
