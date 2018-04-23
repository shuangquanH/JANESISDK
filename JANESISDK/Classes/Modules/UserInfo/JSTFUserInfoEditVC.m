//
//  JSTFUserInfoEditVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoEditVC.h"
#import "JSTFUserInfoEditCell.h"
#import "JSTFUserInfoEditHeader.h"
#import "JSTFUserTagEditCell.h"

#import "TZImagePickerController.h"

static NSString *headID = @"headID";
static NSString *infoCellID = @"infoCellID";
static NSString *tagCellID = @"tagCellID";
static NSString *interestCellID = @"interestCellID";

@interface JSTFUserInfoEditVC ()<UITableViewDelegate,UITableViewDataSource,JSTFUserInfoEditHeaderDelegate>

@property (nonatomic, strong)UserInfo *userInfo;

@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)JSTFUserInfoEditHeader *headView;

//cell高度数组，按section分
@property (nonatomic, strong)NSMutableArray *cellHeightArr1;
@property (nonatomic, strong)NSMutableArray *cellHeightArr2;
@property (nonatomic, strong)NSMutableArray *cellHeightArr3;

@end

@implementation JSTFUserInfoEditVC
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
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
    
    //添加数据通知更新
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(updateInfoHeadView:) name:JSTFUserInfoProfile_DidChange_Notification object:nil];
    [center addObserver:self selector:@selector(updateInfoCellArr:) name:JSTFUserInfo_DidChange_Notification object:nil];
    [center addObserver:self selector:@selector(updateTagCellArr:) name:JSTFUserInfoTag_DidChange_Notification object:nil];
    [center addObserver:self selector:@selector(updateInterestCellArr:) name:JSTFUserInfoInterest_DidChange_Notification object:nil];
    
    //请求数据
    UserInfo *user = [SystemUtils getUserData];
    self.userInfo = user;
    [self refreshHeadView];
    [self configCellHeight];
    [self.myTableView reloadData];
    
}
-(void)updateInfoHeadView:(NSNotification *)notification{
    NSDictionary *obj = notification.userInfo;
    UserInfo *info = [obj objectForKey:@"userInfo"];
    self.userInfo.name = info.name;
    self.userInfo.birthday = info.birthday;
    [self refreshHeadView];
}
-(void)updateInfoCellArr:(NSNotification *)notification{
    NSDictionary *obj = notification.userInfo;
    NSInteger type = [[obj objectForKey:@"type"] intValue];
    NSString *content = [obj objectForKey:@"content"];
    if([NSString isBlank:content]) return;
    if (type<5&&type>=0) {
        switch (type) {
            case 0:
            {
                self.userInfo.profession = content;
            }
                break;
            case 1:
            {
                self.userInfo.work = content;
            }
                break;
            case 2:
            {
                self.userInfo.city = content;
            }
                break;
            case 3:
            {
                self.userInfo.hauntAbout = content;
            }
                break;
            case 4:
            {
                self.userInfo.idiograph = content;
            }
                break;
            default:
                break;
        }
        [self configCellHeight];
        [self.myTableView reloadData];
    }
}
-(void)updateTagCellArr:(NSNotification *)notification{
    NSDictionary *obj = notification.userInfo;
//    NSInteger type = [[obj objectForKey:@"type"] intValue];
    NSArray *params = [obj objectForKey:@"content"];
    if (params&&params.count>0) {
        self.userInfo.lables = params;
        [self configCellHeight];
        [self.myTableView reloadData];
    }else{
        self.userInfo.lables = nil;
        [self configCellHeight];
        [self.myTableView reloadData];
    }
}
-(void)updateInterestCellArr:(NSNotification *)notification{
    NSDictionary *obj = notification.userInfo;
    NSInteger type = [[obj objectForKey:@"type"] intValue];
    NSArray *params = [obj objectForKey:@"content"];
    if (!(type<6&&type>=0)) return;
    switch (type) {
        case 0:
        {
            if (params&&params.count>0) {
                self.userInfo.run = params;
            }else{
                self.userInfo.run = nil;
            }
        }
            break;
        case 1:
        {
            if (params&&params.count>0) {
                self.userInfo.music = params;
            }else{
                self.userInfo.music = nil;
            }
        }
            break;
        case 2:
        {
            if (params&&params.count>0) {
                self.userInfo.cate = params;
            }else{
                self.userInfo.cate = nil;
            }
        }
            break;
        case 3:
        {
            if (params&&params.count>0) {
                self.userInfo.book = params;
            }else{
                self.userInfo.book = nil;
            }
        }
            break;
        case 4:
        {
            if (params&&params.count>0) {
                self.userInfo.film = params;
            }else{
                self.userInfo.film = nil;
            }
        }
            break;
        case 5:
        {
            if (params&&params.count>0) {
                self.userInfo.usualPlace = params;
            }else{
                self.userInfo.usualPlace = nil;
            }
        }
            break;
        default:
            break;
    }
    [self configCellHeight];
    [self.myTableView reloadData];
    
}
-(void)loadUI{
    UserInfo *userInfo = [SystemUtils getUserData];
    [self configNavUI:userInfo.name isShowBack:YES];
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.navBarView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.statusBarHeight);
        make.right.mas_equalTo(-12*LayoutUtil.scaling);
        make.width.mas_equalTo(39*LayoutUtil.scaling);
        make.height.mas_equalTo(LayoutUtil.navBarHeight-LayoutUtil.statusBarHeight);
    }];
    [saveBtn addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    kAddSubView(self.view, self.myTableView);
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.bottom.mas_equalTo(0*LayoutUtil.scaling);
    }];
}

#pragma 相册
-(void)takeLibrary{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:50 delegate:nil];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingGif = NO;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        //传回照片数组
        if (photos&&photos.count>0) {
            
            //上传图片
            NSString *url = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_PHOTO_UPLOAD];
            [JSTFNetRequestHandler uploadImgs:photos url:url success:^(NSHTTPURLResponse *response, id responseObject) {
                NSLog(@"%@",responseObject);
                NSArray *array = responseObject[@"result"];
                if (array&&array.count>0) {
                    self.userInfo.avator = [NSMutableArray arrayWithArray:array];
                }
                [self refreshHeadView];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
                [SVProgressHUD dismissWithDelay:1.5f];
            }];
            
        }
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)refreshHeadView{
    [self.headView removeFromSuperview];
    self.headView = nil;
    self.myTableView.tableHeaderView = self.headView;
    [self.headView setUserInfo:self.userInfo];
}
#pragma MARK - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 6;
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
                cell.textLabel.text = @"我的信息";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"我的标签";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"我的兴趣";
            }
                break;
            default:
                break;
        }
        return cell;
    }
    if (indexPath.section==0) {
        JSTFUserInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
        if (!cell) {
            cell = [[JSTFUserInfoEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    if (indexPath.section==1) {
        JSTFUserTagEditCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
        if (!cell) {
            cell = [[JSTFUserTagEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    if (indexPath.section==2) {
        JSTFUserTagEditCell *cell = [tableView dequeueReusableCellWithIdentifier:interestCellID];
        if (!cell) {
            cell = [[JSTFUserTagEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:interestCellID];
        }
        cell.indexPath = indexPath;
        [cell setUserInfo:self.userInfo];
        return cell;
    }
    JSTFUserInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
    if (!cell) {
        cell = [[JSTFUserInfoEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) return;
    if (indexPath.section==0){
        NSMutableDictionary *property = [self getParamsForEdit:indexPath];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"JSTFUserInfoTextVC" forKey:@"controllerName"];
        [dic setObject:property forKey:@"property"];
        [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
    }
    if (indexPath.section==1){
        NSMutableDictionary *property = [self getParamsForEdit:indexPath];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"JSTFUserInfoTagVC" forKey:@"controllerName"];
        [dic setObject:property forKey:@"property"];
        [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
    }
    if (indexPath.section==2){
        NSMutableDictionary *property = [self getParamsForEdit:indexPath];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"JSTFUserInfoTagVC" forKey:@"controllerName"];
        [dic setObject:property forKey:@"property"];
        [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
    }
    
}
-(NSMutableDictionary *)getParamsForEdit:(NSIndexPath *)indexPath{
    if (indexPath.row==0) nil;
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:[NSNumber numberWithInteger:indexPath.row-1] forKey:@"type"];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 1:
            {
                [property setObject:@"行业" forKey:@"navTitle"];
                if ([NSString isNotBlank:self.userInfo.profession]) {
                    [property setObject:self.userInfo.profession forKey:@"content"];
                }
            }
                break;
            case 2:
            {
                [property setObject:@"工作领域" forKey:@"navTitle"];
                if ([NSString isNotBlank:self.userInfo.work]) {
                    [property setObject:self.userInfo.work forKey:@"content"];
                }
            }
                break;
            case 3:
            {
                [property setObject:@"来自" forKey:@"navTitle"];
                if ([NSString isNotBlank:self.userInfo.city]) {
                    [property setObject:self.userInfo.city forKey:@"content"];
                }
            }
                break;
            case 4:
            {
                [property setObject:@"经常出没" forKey:@"navTitle"];
                if ([NSString isNotBlank:self.userInfo.hauntAbout]) {
                    [property setObject:self.userInfo.hauntAbout forKey:@"content"];
                }
            }
                break;
            case 5:
            {
                [property setObject:@"个人签名" forKey:@"navTitle"];
                if ([NSString isNotBlank:self.userInfo.idiograph]) {
                    [property setObject:self.userInfo.idiograph forKey:@"content"];
                }
            }
                break;
            default:
            {
                
            }
                break;
        }
    }
    if (indexPath.section==1) {
        [property setObject:@"个性标签" forKey:@"navTitle"];
        if (self.userInfo.lables&&self.userInfo.lables.count>0) {
            [property setObject:self.userInfo.lables forKey:@"tagDatas"];
        }
        [property setObject:@(1) forKey:@"notifiType"];
        [property setObject:@"lables" forKey:@"groupName"];
    }
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 1:
            {
                [property setObject:@"运动" forKey:@"navTitle"];
                [property setObject:@"run" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.run.count>0) {
                    [property setObject:self.userInfo.run forKey:@"tagDatas"];
                }
            }
                break;
            case 2:
            {
                [property setObject:@"音乐" forKey:@"navTitle"];
                [property setObject:@"music" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.music.count>0) {
                    [property setObject:self.userInfo.music forKey:@"tagDatas"];
                }
            }
                break;
            case 3:
            {
                [property setObject:@"美食" forKey:@"navTitle"];
                [property setObject:@"cate" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.cate.count>0) {
                    [property setObject:self.userInfo.cate forKey:@"tagDatas"];
                }
            }
                break;
            case 4:
            {
                [property setObject:@"书籍" forKey:@"navTitle"];
                [property setObject:@"book" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.book.count>0) {
                    [property setObject:self.userInfo.book forKey:@"tagDatas"];
                }
            }
                break;
            case 5:
            {
                [property setObject:@"电影" forKey:@"navTitle"];
                [property setObject:@"film" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.film.count>0) {
                    [property setObject:self.userInfo.film forKey:@"tagDatas"];
                }
            }
                break;
            case 6:
            {
                [property setObject:@"去过的地方" forKey:@"navTitle"];
                [property setObject:@"footprint" forKey:@"groupName"];
                if (self.userInfo.lables&&self.userInfo.usualPlace.count>0) {
                    [property setObject:self.userInfo.usualPlace forKey:@"tagDatas"];
                }
            }
                break;
            default:
            {
                
            }
                break;
        }
        [property setObject:@(2) forKey:@"notifiType"];
    }
    return property;
}
-(CGFloat)caculatorHeight:(NSArray *)arr{
    CGSize size = CGSizeMake(LayoutUtil.screenWidth-(15+20+15+15+9+15)*LayoutUtil.scaling, (50-20)*LayoutUtil.scaling);
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
-(void)moveToEditProfilePage{
    //JSTFUserProfileEditVC
    NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
    [property setObject:[SystemUtils getUserData] forKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"JSTFUserProfileEditVC" forKey:@"controllerName"];
    [dic setObject:property forKey:@"property"];
    [PageJumpRouter pushToViewControllerWithProperty:dic viewController:self];
}
-(void)addMorePhotos{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    JSTFWself(weakSelf);
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf takeLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)saveUserInfo{
    //请求数据
    NSDictionary *DIC = [self.userInfo yy_modelToJSONObject];
    [DIC setValue:[self.userInfo.avator yy_modelToJSONString] forKey:@"avator"];
    [DIC setValue:[self.userInfo.lables yy_modelToJSONString] forKey:@"lables"];
    [DIC setValue:[self.userInfo.run yy_modelToJSONString] forKey:@"run"];
    [DIC setValue:[self.userInfo.music yy_modelToJSONString] forKey:@"music"];
    [DIC setValue:[self.userInfo.cate yy_modelToJSONString] forKey:@"cate"];
    [DIC setValue:[self.userInfo.book yy_modelToJSONString] forKey:@"book"];
    [DIC setValue:[self.userInfo.film yy_modelToJSONString] forKey:@"film"];
    [DIC setValue:[self.userInfo.usualPlace yy_modelToJSONString] forKey:@"usualPlace"];
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USERINFO_UPDATE];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:DIC methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString *code = responseObject[@"code"];
        if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
            NSNumber *flag = responseObject[@"result"];
            if ([flag boolValue]) {
                NSData *Info = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
                [UserDefaultsUtil updateValue:Info forKey:@"JSTF_UserInfo"];
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

-(UITableView *)myTableView{
    if (nil==_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:headID];
        [_myTableView registerClass:[JSTFUserInfoEditCell class] forCellReuseIdentifier:infoCellID];
        [_myTableView registerClass:[JSTFUserTagEditCell class] forCellReuseIdentifier:tagCellID];
        [_myTableView registerClass:[JSTFUserTagEditCell class] forCellReuseIdentifier:interestCellID];
        _myTableView.tableHeaderView = self.headView;
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
-(JSTFUserInfoEditHeader *)headView{
    if (nil==_headView) {
        long row = MIN(1,self.userInfo.avator.count/3);
        _headView = [[JSTFUserInfoEditHeader alloc] initWithFrame:CGRectMake(0, 0, LayoutUtil.screenWidth, (100+(3*2+121+row*(3+121)))*LayoutUtil.scaling)];
        _headView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
        _headView.delegate=self;
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
