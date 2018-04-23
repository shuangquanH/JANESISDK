//
//  JSTFUserProfileVC.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserProfileVC.h"

@interface JSTFUserProfileVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)UITextField *nameTF;
@property(nonatomic, strong)UITextField *birthTF;
@property(nonatomic, strong)UIButton *startBtn;
@property(nonatomic, strong)UIImageView *sexView;
@property(nonatomic, strong)UserInfo *userInfo;

@property(nonatomic, strong)UIDatePicker *datePicker;
@end

@implementation JSTFUserProfileVC

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
    [self configNavUI:@"完善个人资料" isShowBack:YES];
    
    UIView *circleView = [[UIView alloc] init];
    circleView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    [circleView.layer setCornerRadius:120/2*LayoutUtil.scaling];
    [self.view addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LayoutUtil.navBarHeight+51*LayoutUtil.scaling);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(120*LayoutUtil.scaling);
        make.height.mas_equalTo(120*LayoutUtil.scaling);
    }];
    
    UIImageView *sexView = [[UIImageView alloc] init];
    sexView.contentMode = UIViewContentModeScaleAspectFill;
    if (self.userInfo.sex&&[self.userInfo.sex intValue]==0) {
        [sexView setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_girl_purple"]];
    }else if(self.userInfo.sex&&[self.userInfo.sex intValue]==1){
        [sexView setImage:[ImageLoader loadLocalBundleImg:@"login_icon_sex_boy_purple"]];
    }
    [circleView addSubview:sexView];
    [sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(circleView.mas_centerX);
        make.centerY.equalTo(circleView.mas_centerY);
        make.width.mas_equalTo(42*LayoutUtil.scaling);
        make.height.mas_equalTo(42*LayoutUtil.scaling);
    }];
    self.sexView = sexView;
    
    UIImageView *cameraView = [[UIImageView alloc] init];
    cameraView.contentMode = UIViewContentModeScaleAspectFill;
    [cameraView setImage:[ImageLoader loadLocalBundleImg:@"login_icon_profile_camera"]];
    [circleView addSubview:cameraView];
    [cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(38*LayoutUtil.scaling);
        make.height.mas_equalTo(30*LayoutUtil.scaling);
    }];
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"点击上传本人头像";
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    tipLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(circleView.mas_bottom).with.offset(25*LayoutUtil.scaling);
        make.left.mas_equalTo(0*LayoutUtil.scaling);
        make.right.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.placeholder = @"昵称";
    nameTF.textColor = [UIColor colorWithHex:@"333333"];
    nameTF.textAlignment = NSTextAlignmentCenter;
    nameTF.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(30*LayoutUtil.scaling);
        make.left.mas_equalTo(22*LayoutUtil.scaling);
        make.width.mas_equalTo(150*LayoutUtil.scaling);
        make.height.mas_equalTo(25*LayoutUtil.scaling);
    }];
    self.nameTF = nameTF;
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHex:@"a6a6a6"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTF.mas_bottom).offset(4*LayoutUtil.scaling);
        make.left.equalTo(nameTF.mas_left);
        make.right.equalTo(nameTF.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UITextField *birthTF = [[UITextField alloc] init];
    birthTF.placeholder = @"生日";
    birthTF.textColor = [UIColor colorWithHex:@"333333"];
    birthTF.textAlignment = NSTextAlignmentCenter;
    birthTF.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:birthTF];
    [birthTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(30*LayoutUtil.scaling);
        make.right.mas_equalTo(-22*LayoutUtil.scaling);
        make.width.mas_equalTo(150*LayoutUtil.scaling);
        make.height.mas_equalTo(25*LayoutUtil.scaling);
    }];
    self.birthTF = birthTF;
    [birthTF addTarget:self action:@selector(birthTFClick) forControlEvents:UIControlEventEditingDidBegin];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHex:@"a6a6a6"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthTF.mas_bottom).offset(4*LayoutUtil.scaling);
        make.left.equalTo(birthTF.mas_left);
        make.right.equalTo(birthTF.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *startBtn = [[UIButton alloc] init];
    startBtn.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [startBtn.layer setCornerRadius:8*LayoutUtil.scaling];
    [startBtn.layer setBorderColor:[UIColor colorWithHex:@"333333"].CGColor];
    [startBtn.layer setBorderWidth:1];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [startBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-38*LayoutUtil.scaling);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300*LayoutUtil.scaling);
        make.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    self.startBtn = startBtn;
    
    [self.startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraClick)];
    [circleView addGestureRecognizer:tap];
    
    if (self.userInfo.avator&&self.userInfo.avator.count>0) {
        [ImageLoader loadImageWithCache:self.userInfo.avator[0] imageView:self.sexView placeholder:nil];
    }
    [self setBirthdayField];
}
- (void)birthTFClick{
    [self valueChange:self.datePicker];
}
- (void)setBirthdayField{
    //创建UIDatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //设置本地语言
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //设置日期显示的格式
    datePicker.datePickerMode = UIDatePickerModeDate;
    //设置_birthdayField的inputView控件为datePicker
    self.birthTF.inputView = datePicker;
    self.datePicker = datePicker;
    //监听datePicker的ValueChanged事件
    [datePicker addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChange:(UIDatePicker *)datePicker{
    //创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //将日期转为指定格式显示
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    self.birthTF.text = dateStr;
    self.userInfo.birthday = dateStr;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    //确保加载时也能获取datePicker的文字
    [self valueChange:self.datePicker];
}
#pragma MARK - 相机相册
-(void)cameraClick{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    JSTFWself(weakSelf);
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf takePhoto];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf takeLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)takePhoto{
    NSUInteger sourceType = 0;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
-(void)takeLibrary{
    NSUInteger sourceType = 0;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    image = [UIImage imageByScalingToMaxSize:image];
    //上传图片
    NSString *url = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_PHOTO_UPLOAD];
    [JSTFNetRequestHandler uploadImg:image url:url success:^(NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"%@",responseObject);
        self.userInfo.avator = [NSMutableArray arrayWithArray:responseObject[@"result"]];
        if (self.userInfo.avator&&self.userInfo.avator.count>0) {
            [ImageLoader loadImageWithCache:self.userInfo.avator[0] imageView:self.sexView placeholder:nil];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}
//当用户取消选择的时候，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(void)startBtnClick{
    NSString *name = self.nameTF.text;
    NSString *birth = self.birthTF.text;
    if ([NSString isBlank:name]||[NSString isBlank:birth]||self.userInfo.avator==nil||self.userInfo.avator.count==0){
        [SVProgressHUD showInfoWithStatus:@"信息未填写完整"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    
    //请求数据
    self.userInfo.name = name;
    self.userInfo.birthday = birth;
    NSDictionary *DIC = [self.userInfo yy_modelToJSONObject];
    [DIC setValue:[self.userInfo.avator yy_modelToJSONString] forKey:@"avator"];
    NSString *URL = [NSString stringWithFormat:@"%@%@",[JSTFNetRequestHandler getRequestBaseDomain],JSTF_API_USER_LOGIN_UPDATE];
    JSTFNetRequest *request = [[JSTFNetRequest alloc] initWithUrl:URL params:DIC methodType:MSRequestMethodPost contentType:MSRequestContentDefault];
    [JSTFNetRequestHandler request:request success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString *code = responseObject[@"code"];
        if ([NSString isNotBlank:code]&&[code isEqualToString:@"0"]) {
            if (self.userInfo) {
                self.userInfo.tager = @(YES);
                NSData *Info = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
                [UserDefaultsUtil updateValue:Info forKey:@"JSTF_UserInfo"];
                [SystemUtils updateUserLoginTager:YES];
                if (self.navigationController) {
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                        [PageJumpRouter jumpToMainPage];
                    }];
                }
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
