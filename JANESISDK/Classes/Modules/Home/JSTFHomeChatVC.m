//
//  JSTFHomeChatVC.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeChatVC.h"
#import "JSTFHomeChatCell.h"
#import "UserMessageModel.h"


static NSString *cellID = @"JSTFHomeChatCell";
@interface JSTFHomeChatVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)NSMutableArray *datas;

@property(nonatomic, assign)BOOL isHaveSystem;

@end

@implementation JSTFHomeChatVC

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
    [self updateSystemFlag];
    UserInfo *user = [SystemUtils getUserData];
    if (!user) return;
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_MESS_LIST];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:user.userId forKey:@"userId"];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *code = responseObject[@"code"];
                if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                    NSArray *datas = responseObject[@"result"];
                    if(datas){
                        [self.datas removeAllObjects];
                        [self.datas addObjectsFromArray:[NSArray yy_modelArrayWithClass:[UserMessageModel class] json:datas]];
                        [self.myTableView reloadData];
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                    [SVProgressHUD dismissWithDelay:1.5f];
                }
            });
        } failure:^(NSError *error) {
            
        }];
    });
}
-(void)updateSystemFlag{
    
}
-(void)loadUI{
    [self configNavUI:@"消息" isShowBack:NO];
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.right.bottom.mas_equalTo(0*LayoutUtil.scaling);
    }];
    
    JSTFWself(weakSelf);
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.myTableView.mj_header endRefreshing];
        });
    }];
    
//    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
//        [weakSelf loadData];
//        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [weakSelf.myTableView.mj_footer endRefreshing];
//        });
//    }];
    
//    [self.myTableView.mj_header beginRefreshing];
}
#pragma MARK - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.datas.count;
    }else if(section==1){
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([SystemUtils systemMessIsExist]) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*LayoutUtil.scaling;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSTFHomeChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[JSTFHomeChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.indexPath = indexPath;
    if (indexPath.section==0) {
        [cell setModel:self.datas[indexPath.row]];
    }else if(indexPath.section==1){
        UserMessageModel *mModel = [[UserMessageModel alloc] init];
        mModel.name = @"系统消息";
        mModel.content = JSTFSystemMessContent;
        mModel.avator = @[@"system_icon_avator"];
        [cell setModel:mModel];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //JSTFUserChatPageVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    if (indexPath.section==0) {
        [property setObject:self.datas[indexPath.row] forKey:@"messModel"];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserChatPageVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
// 自定义左滑显示编辑按钮
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = @"删除";
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteFriend:indexPath];
    }];
    
    rowAction.backgroundColor = [UIColor colorWithRed:246/255.0 green:67/255.0 blue:73/255.0 alpha:1.0];
    NSArray *arr = @[rowAction];
    return arr;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)deleteFriend:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        [SystemUtils removeSystemMess];
        [self.myTableView reloadData];
        return;
    }
    if (indexPath.row<self.datas.count) {
        UserInfo *user = [SystemUtils getUserData];
        UserMessageModel *model = self.datas[indexPath.row];
        if ([NSString isBlank:user.userId]||[NSString isBlank:model.userId]) {
            [SVProgressHUD showInfoWithStatus:@"用户信息异常"];
            [SVProgressHUD dismissWithDelay:1.5f];
            return;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_MESS_DELETE];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:user.userId forKey:@"userId"];
            [dic setObject:model.userId forKey:@"toUserId"];
            JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:dic methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
            [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *code = responseObject[@"code"];
                    if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
                        [self.datas removeObjectAtIndex:indexPath.row];
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
}
#pragma mark EmptyDataSet
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [ImageLoader loadLocalBundleImg:@"home_chat_img_empty_bg"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:[UIFont systemFontOfSize:16*LayoutUtil.scaling] forKey:NSFontAttributeName];
    [attributes setObject:[UIColor colorWithHex:@"9013FE"] forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:@"寻找好友" attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无匹配好友";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12*LayoutUtil.scaling],
                                 NSForegroundColorAttributeName: [UIColor colorWithHex:@"a6a6a6"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 32;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -80*LayoutUtil.scaling;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    self.tabBarController.selectedIndex = 0;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
-(UITableView *)myTableView{
    if (nil==_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[JSTFHomeChatCell class] forCellReuseIdentifier:cellID];
        _myTableView.tableHeaderView = [[UIView alloc]init];
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.emptyDataSetDelegate = self;
        _myTableView.emptyDataSetSource = self;
        _myTableView.directionalLockEnabled = YES;
    }
    return _myTableView;
}
-(NSMutableArray *)datas{
    if (_datas==nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
