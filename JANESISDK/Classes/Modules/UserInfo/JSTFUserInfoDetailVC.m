//
//  JSTFUserInfoDetailVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoDetailVC.h"

#import "JSTFUserInfoDetailHeader.h"
#import "JSTFUserInfoDetailCell.h"
#import "JSTFUserTagDetailCell.h"
static NSString *headID = @"headID";
static NSString *infoCellID = @"infoCellID";
static NSString *tagCellID = @"tagCellID";
static NSString *interestCellID = @"interestCellID";

@interface JSTFUserInfoDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)JSTFUserInfoDetailHeader *headView;

@property (nonatomic, strong)NSMutableArray *photoArr;
@property (nonatomic, strong)UserInfo *userInfo;

@property (nonatomic, assign)BOOL isSelf;
//cell高度数组，按section分
@property (nonatomic, strong)NSMutableArray *cellHeightArr1;
@property (nonatomic, strong)NSMutableArray *cellHeightArr2;
@property (nonatomic, strong)NSMutableArray *cellHeightArr3;

@end

@implementation JSTFUserInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
-(void)loadData{
    
    //请求数据
    if (self.isSelf) {
        UserInfo *user = [SystemUtils getUserData];
        self.userInfo = user;
        [self configNavUI:user.name isShowBack:YES];
        UIButton *saveBtn = [[UIButton alloc] init];
        [saveBtn setImage:[ImageLoader loadLocalBundleImg:@"nav_icon_profile_edit"] forState:UIControlStateNormal];
        [self.navBarView addSubview:saveBtn];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(LayoutUtil.statusBarHeight);
            make.right.mas_equalTo(-12*LayoutUtil.scaling);
            make.width.mas_equalTo(49*LayoutUtil.scaling);
            make.height.mas_equalTo(LayoutUtil.navBarHeight-LayoutUtil.statusBarHeight);
        }];
        [saveBtn addTarget:self action:@selector(moveToEditUserInfo) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self configNavUI:self.userInfo.name isShowBack:YES];
    }
    
    //更新UI
    [self refreshHeadView];
    [self configCellHeight];
    [self.myTableView reloadData];
}
-(void)refreshHeadView{
    [self.headView removeFromSuperview];
    self.headView = nil;
    self.myTableView.tableHeaderView = self.headView;
    [self.headView setUserInfo:self.userInfo];
}
-(void)loadUI{
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.bottom.mas_equalTo(0*LayoutUtil.scaling);
    }];
}

#pragma MARK - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 7;
    }else if (section==1){
        return 2;
    }else if (section==2){
        return 7;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row<self.cellHeightArr1.count) {
            return [self.cellHeightArr1[indexPath.row] floatValue];
        }return 0;
    }
    if (indexPath.section==1) {
        if (indexPath.row<self.cellHeightArr2.count) {
            return [self.cellHeightArr2[indexPath.row] floatValue];
        }return 0;
    }
    if (indexPath.section==2) {
        if (indexPath.row<self.cellHeightArr3.count) {
            return [self.cellHeightArr3[indexPath.row] floatValue];
        }return 0;
    }
    return 0;
}
//预计算cell 高度
-(void)configCellHeight{
    if (self.userInfo) {
        [self.cellHeightArr1 removeAllObjects];
        [self.cellHeightArr2 removeAllObjects];
        [self.cellHeightArr3 removeAllObjects];
        //section 1
        [self.cellHeightArr1 addObject:@(47*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        [self.cellHeightArr1 addObject:@(50*LayoutUtil.scaling)];
        
        //section 2
        [self.cellHeightArr2 addObject:@(47*LayoutUtil.scaling)];
        NSArray *arr = self.userInfo.lables;
        if (arr&&arr.count>0) {
            [self.cellHeightArr2 addObject:@([self caculatorHeight:arr])];
        }else{
            [self.cellHeightArr2 addObject:@(50*LayoutUtil.scaling)];
        }
        
        //section 3
        [self.cellHeightArr3 addObject:@(47*LayoutUtil.scaling)];
        NSArray *arr1 = [self getHeightForTag:1];
        if (arr1&&arr1.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr1])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
        NSArray *arr2 = [self getHeightForTag:2];
        if (arr2&&arr2.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr2])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
        NSArray *arr3 = [self getHeightForTag:3];
        if (arr3&&arr3.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr3])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
        NSArray *arr4 = [self getHeightForTag:4];
        if (arr4&&arr4.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr4])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
        NSArray *arr5 = [self getHeightForTag:5];
        if (arr5&&arr5.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr5])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
        NSArray *arr6 = [self getHeightForTag:6];
        if (arr6&&arr6.count>0) {
            [self.cellHeightArr3 addObject:@([self caculatorHeight:arr6])];
        }else{
            [self.cellHeightArr3 addObject:@(50*LayoutUtil.scaling)];
        }
    }
}
-(NSArray *)getHeightForTag:(NSInteger)row{
    NSArray *arr;
    switch (row) {
        case 1:
        {
            arr = self.userInfo.run;
        }
            break;
        case 2:
        {
            arr = self.userInfo.music;
        }
            break;
        case 3:
        {
            arr = self.userInfo.cate;
        }
            break;
        case 4:
        {
            arr = self.userInfo.book;
        }
            break;
        case 5:
        {
            arr = self.userInfo.film;
        }
            break;
        case 6:
        {
            arr = self.userInfo.usualPlace;
        }
            break;
        default:
            break;
    }
    return arr;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headID];
        }
        cell.contentView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        cell.textLabel.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        cell.textLabel.textColor = [UIColor colorWithHex:@"a6a6a6"];
        cell.textLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
        switch (indexPath.section) {
            case 0:
            {
                cell.textLabel.text = @"个人信息";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"标签";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"兴趣";
            }
                break;
            default:
                break;
        }
        return cell;
    }
    if (indexPath.section==0) {
        JSTFUserInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
        if (!cell) {
            cell = [[JSTFUserInfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    if (indexPath.section==1) {
        JSTFUserTagDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
        if (!cell) {
            cell = [[JSTFUserTagDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    if (indexPath.section==2) {
        JSTFUserTagDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:interestCellID];
        if (!cell) {
            cell = [[JSTFUserTagDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:interestCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    JSTFUserInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
    if (!cell) {
        cell = [[JSTFUserInfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)moveToEditUserInfo{
    //JSTFUserInfoEditVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserInfoEditVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(CGFloat)caculatorHeight:(NSArray *)arr{
    CGSize size = CGSizeMake(LayoutUtil.screenWidth-(15+20+15+15)*LayoutUtil.scaling, (50-20)*LayoutUtil.scaling);
    CGFloat btnHeight = 30*LayoutUtil.scaling;
    CGFloat btnMarginX = 5*LayoutUtil.scaling;
    CGFloat btnMarginY = 5*LayoutUtil.scaling;
    CGFloat btnPadding = 20*LayoutUtil.scaling;
    CGFloat viewMarginX = 0*LayoutUtil.scaling;
    CGFloat w = viewMarginX;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高,y值
    for (int i = 0; i < arr.count; i++) {
        NSString *title = arr[i];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14*LayoutUtil.scaling]};
        CGFloat width = [title boundingRectWithSize:CGSizeMake(size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        CGFloat btnWidth = 0;
        if ([NSString isNotBlank:title]) {
            btnWidth = MIN(size.width/2.0,btnPadding+width);
        }
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(w + btnMarginX + btnWidth > size.width-viewMarginX){
            w = viewMarginX; //换行时将w置为0
            h = h + btnHeight + btnMarginY;//距离父视图也变化
        }
        w = btnWidth + w + btnMarginX;
    }
    //加上20的外边框
    return h + btnHeight + 10*2*LayoutUtil.scaling;
    
}

-(NSMutableArray *)photoArr{
    if (_photoArr==nil) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
-(UITableView *)myTableView{
    if (nil==_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:headID];
        [_myTableView registerClass:[JSTFUserInfoDetailCell class] forCellReuseIdentifier:infoCellID];
        [_myTableView registerClass:[JSTFUserTagDetailCell class] forCellReuseIdentifier:tagCellID];
        [_myTableView registerClass:[JSTFUserTagDetailCell class] forCellReuseIdentifier:interestCellID];
        _myTableView.tableHeaderView = self.headView;
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
-(JSTFUserInfoDetailHeader *)headView{
    if (nil==_headView) {
        _headView = [[JSTFUserInfoDetailHeader alloc] initWithFrame:CGRectMake(0, 0, LayoutUtil.screenWidth, 100*LayoutUtil.scaling+LayoutUtil.screenWidth)];
        _headView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    }
    return _headView;
}
-(NSMutableArray *)cellHeightArr1{
    if (_cellHeightArr1==nil) {
        _cellHeightArr1 = [NSMutableArray array];
    }
    return _cellHeightArr1;
}
-(NSMutableArray *)cellHeightArr2{
    if (_cellHeightArr2==nil) {
        _cellHeightArr2 = [NSMutableArray array];
    }
    return _cellHeightArr2;
}
-(NSMutableArray *)cellHeightArr3{
    if (_cellHeightArr3==nil) {
        _cellHeightArr3 = [NSMutableArray array];
    }
    return _cellHeightArr3;
}



@end
