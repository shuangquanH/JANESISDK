//
//  JSTFUserChatPageVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserChatPageVC.h"
#import "JSTFUserChatPageCell.h"
#import "UserMessageModel.h"
#import "UserChatModel.h"

static NSString *cellID = @"JSTFUserChatPageCell";
@interface JSTFUserChatPageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UserMessageModel *messModel;
@property(nonatomic, strong)UserInfo *userInfo;
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)NSMutableArray *datas;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UITextField *inputTF;

@end

@implementation JSTFUserChatPageVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
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
    self.userInfo = user;
    if(!self.messModel){
        NSArray *array = [SystemUtils querySystemMess];
        if (array&&array.count>0) {
            [self.datas removeAllObjects];
            [self.datas addObjectsFromArray:array];
        }else{
            [self.datas removeAllObjects];
        }
        [self.myTableView reloadData];
        return;
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_CHAT_LIST];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:self.messModel.userId forKey:@"toUserId"];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *datas = responseObject[@"result"];
                if(datas){
                    [self.datas removeAllObjects];
                    [self.datas addObjectsFromArray:[NSArray yy_modelArrayWithClass:[UserChatModel class] json:datas]];
                    [self.myTableView reloadData];
                }
            });
        } failure:^(NSError *error) {
            
        }];
        
    });
    
}
-(void)loadUI{
    if (!self.messModel) {
        [self configNavUI:@"系统消息" isShowBack:YES];
    }else{
        [self configNavUI:self.messModel.name isShowBack:YES];
    }
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[ImageLoader loadLocalBundleImg:@"nav_icon_handle_more"] forState:UIControlStateNormal];
    [self.navBarView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10.5*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.width.mas_equalTo(63*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    [rightBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    kAddSubView(self.view, self.bottomView);
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.bottom.equalTo(self.view).inset(LayoutUtil.safeAreaBottomHeight);
        make.height.mas_equalTo(49*LayoutUtil.scaling);
    }];
    
    UIButton *sendBtn = [[UIButton alloc] init];
    [sendBtn setImage:[ImageLoader loadLocalBundleImg:@"chat_icon_input_send"] forState:UIControlStateNormal];
    [self.bottomView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.width.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *inputTF = [[UITextField alloc] init];
    inputTF.placeholder = @"请输入消息...";
    inputTF.textColor = [UIColor colorWithHex:@"333333"];
    [self.bottomView addSubview:inputTF];
    [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*LayoutUtil.scaling);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.height.mas_equalTo(30*LayoutUtil.scaling);
        make.right.equalTo(sendBtn.mas_left).offset(-20*LayoutUtil.scaling);
    }];
    self.inputTF = inputTF;
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.right.mas_equalTo(0*LayoutUtil.scaling);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self addEventListening];
}
-(void)addEventListening{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark keyboardnotification

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //告知需要更改约束
    [self.myTableView setNeedsUpdateConstraints];
    [UIView animateWithDuration:duration animations:^{
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-keyboardFrame.size.height);
        }];
        //告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.bottomView.superview layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //告知需要更改约束
    [self.myTableView setNeedsUpdateConstraints];
    [UIView animateWithDuration:duration animations:^{
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).inset(LayoutUtil.safeAreaBottomHeight);
        }];
        //告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.bottomView.superview layoutIfNeeded];
    }];
}
#pragma MARK - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserChatModel *model = self.datas[indexPath.row];
    return [self caculatorCellHeight:model];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSTFUserChatPageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[JSTFUserChatPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isSystemMess = NO;
    UserChatModel *model = self.datas[indexPath.row];
    if ([NSString isNotBlank:model.userModified]) {
        if (self.userInfo.avator&&self.userInfo.avator.count>0) {
            cell.avator = self.userInfo.avator[0];
        }else{
            cell.avator = @"";
        }
        if(indexPath.row%5==0){
            
        }
    }else{
        if (self.messModel) {
            if (self.messModel.avator&&self.messModel.avator.count>0) {
                cell.avator = self.messModel.avator[0];
            }else{
                cell.avator = @"";
            }
        }else{
            cell.isSystemMess = YES;
            cell.avator = @"system_icon_avator";
        }
        
    }
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)moreBtnClick{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    JSTFWself(weakSelf);
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf reportUser];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)reportUser{
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserReportVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(void)sendBtnClick{
    UserChatModel *model = [[UserChatModel alloc] init];
    model.userModified = self.inputTF.text;
    model.userId = self.userInfo.userId;
    model.toUserId = self.messModel?self.messModel.userId:@"";
    self.inputTF.text = @"";
    if (!self.messModel) {
        [SystemUtils addSystemMess:model];
        [self.datas addObject:model];
        [self.myTableView reloadData];
        return;
    }
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_CHAT_SEND];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.userInfo.userId forKey:@"userId"];
    [dic setObject:model.toUserId forKey:@"toUserId"];
    [dic setObject:model.userModified forKey:@"userModified"];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    [self.datas addObject:model];
                    [self.myTableView reloadData];
                }else{
                    model.isVaild = NO;
                    [self.datas addObject:model];
                    [self.myTableView reloadData];
                    [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                    [SVProgressHUD dismissWithDelay:1.5f];
                }
            });
        } failure:^(NSError *error) {
            
        }];
        
    });
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [SystemUtils hideKeyboard];
}
-(CGFloat)caculatorCellHeight:(UserChatModel *)model{
    if (!model) return 0;
    CGFloat screenWidth = LayoutUtil.screenWidth;
    CGFloat spacingX = 15*LayoutUtil.scaling;
    CGFloat spacingY = 12*LayoutUtil.scaling;
    if ([NSString isNotBlank:model.userModified]) {//用户发送，右边
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*LayoutUtil.scaling]};
        CGSize size = [model.userModified boundingRectWithSize:CGSizeMake(screenWidth-(15+40+10)*LayoutUtil.scaling*2-spacingX*2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return 20 + (size.height+spacingY*2) + 20;
    }else{
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*LayoutUtil.scaling]};
        CGSize size = [model.toUserGmtModified boundingRectWithSize:CGSizeMake(screenWidth-(15+40+10)*LayoutUtil.scaling*2-spacingX*2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return 20 + (size.height+spacingY*2) + 20;
    }
}
-(UITableView *)myTableView{
    if (nil==_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[JSTFUserChatPageCell class] forCellReuseIdentifier:cellID];
        _myTableView.tableHeaderView = [[UIView alloc]init];
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
-(NSMutableArray *)datas{
    if (_datas==nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    }
    return _bottomView;
}
@end
