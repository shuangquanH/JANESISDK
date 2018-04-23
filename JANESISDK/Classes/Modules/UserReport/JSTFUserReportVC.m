//
//  JSTFUserReportVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserReportVC.h"

static NSString *cellID = @"cellID";

@interface JSTFUserReportVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign)NSInteger selectIndex;
@property(nonatomic, strong)NSMutableArray *tagArr;

@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)UIButton *submitBtn;
@end

@implementation JSTFUserReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUI{
    [self configNavUI:@"举报" isShowBack:YES];
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.bottom.mas_equalTo(94*LayoutUtil.scaling);
    }];
    
    UIButton *submitBtn = [[UIButton alloc] init];
    submitBtn.userInteractionEnabled = NO;
    [submitBtn.layer setCornerRadius:8*LayoutUtil.scaling];
    [submitBtn.layer setMasksToBounds:YES];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn.layer setBorderWidth:1];
    [submitBtn.layer setBorderColor:[UIColor colorWithHex:@"333333"].CGColor];
    submitBtn.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [submitBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    kAddSubView(self.view, submitBtn);
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(44*LayoutUtil.scaling+LayoutUtil.safeAreaBottomHeight);
        make.width.mas_equalTo(300*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    self.submitBtn = submitBtn;
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)loadData{
    self.selectIndex = -1;
    [self.tagArr addObject:@"头像、资料作假"];
    [self.tagArr addObject:@"广告、营销"];
    [self.tagArr addObject:@"诈骗、托儿"];
    [self.tagArr addObject:@"色情低俗"];
    [self.tagArr addObject:@"恶意骚扰、不文明语言"];
    [self.tagArr addObject:@"其他"];
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
    if(indexPath.row==self.selectIndex){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    self.submitBtn.backgroundColor = [UIColor colorWithHex:@"9013FE"];
    [self.submitBtn.layer setBorderWidth:0];
    [self.submitBtn setTitleColor:[UIColor colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    self.submitBtn.userInteractionEnabled = YES;
    [self.myTableView reloadData];
}
-(void)submitBtnClick{
    if ([self.submitBtn isUserInteractionEnabled]) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
        [SVProgressHUD dismissWithDelay:1.5f];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请选择举报理由"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }
    //提交数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_CHAT_REPORT];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dict methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
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
@end
