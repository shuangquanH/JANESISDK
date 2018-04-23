//
//  JSTFUserTagDetailCell.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserTagDetailCell.h"
#define PreLoadCellNum 20

@interface JSTFUserTagDetailCell()

@property(nonatomic, strong)UIButton *iconBtn;
@property(nonatomic, strong)UILabel *contentLab;
@property(nonatomic, strong)UIView *tagView;
@property(nonatomic, strong)UIColor *btnColor;
@property(nonatomic, strong)UIColor *btnTextColor;

//预加载固定个数button
@property(nonatomic, strong)NSMutableArray *btnArr;

@end

@implementation JSTFUserTagDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadComponent];
    }
    return self;
}
- (void)loadComponent{
    
    UIButton *icon = [[UIButton alloc] init];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(20*LayoutUtil.scaling);
    }];
    self.iconBtn = icon;
    
    UIView *tagView = [[UIView alloc] init];
    tagView.backgroundColor = [UIColor colorWithHex:@"ffffff"];
    [self.contentView addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*LayoutUtil.scaling);
        make.bottom.mas_equalTo(-10*LayoutUtil.scaling);
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.left.equalTo(icon.mas_right).offset(15*LayoutUtil.scaling);
    }];
    self.tagView = tagView;
    
    UILabel *content = [[UILabel alloc] init];
    content.text = @"";
    content.textColor = [UIColor colorWithHex:@"a6a6a6"];
    content.textAlignment = NSTextAlignmentLeft;
    content.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.contentView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.height.mas_equalTo(22);
    }];
    self.contentLab = content;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0*LayoutUtil.scaling);
        make.height.mas_equalTo(1*LayoutUtil.scaling);
    }];
    
    self.btnArr = [NSMutableArray array];
    for(int i=0;i<PreLoadCellNum;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.showsTouchWhenHighlighted = YES;
        btn.titleLabel.lineBreakMode = NSLineBreakByClipping;
        btn.titleLabel.font = [UIFont systemFontOfSize:14*LayoutUtil.scaling];
        btn.hidden = YES;
        [self.btnArr addObject:btn];
        [self.tagView addSubview:btn];
    }
    
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    self.contentLab.hidden = NO;
    self.contentLab.text = @"暂无";
    [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@""] forState:UIControlStateNormal];
    self.btnColor = [UIColor colorWithHex:@""];
    self.btnTextColor = [UIColor colorWithHex:@""];
    if (_userInfo) {
        if (_indexPath.section==1) {
            [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_me"] forState:UIControlStateNormal];
            self.btnColor = [UIColor colorWithHex:@"E0E9F7"];
            self.btnTextColor = [UIColor colorWithHex:@"247BFF"];
            NSArray *strArr = _userInfo.lables;
            if (strArr&&strArr.count>0) {
                self.contentLab.hidden = YES;
                [self addTagBtn:strArr];
            }
            return;
        }
        NSArray *strArr;
        switch (_indexPath.row) {
            case 1:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_sport"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"Ceffdd"];
                self.btnTextColor = [UIColor colorWithHex:@"15AC44"];
                strArr = _userInfo.run;
            }
                break;
            case 2:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_music"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"dee5f5"];
                self.btnTextColor = [UIColor colorWithHex:@"2157D3"];
                strArr = _userInfo.music;
            }
                break;
            case 3:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_food"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"f4e7e0"];
                self.btnTextColor = [UIColor colorWithHex:@"D87338"];
                strArr = _userInfo.cate;
            }
                break;
            case 4:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_book"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"F4EED7"];
                self.btnTextColor = [UIColor colorWithHex:@"DAB72F"];
                strArr = _userInfo.book;
            }
                break;
            case 5:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_tv"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"DEDCF4"];
                self.btnTextColor = [UIColor colorWithHex:@"4239A3"];
                strArr = _userInfo.film;
            }
                break;
            case 6:
            {
                [self.iconBtn setImage:[ImageLoader loadLocalBundleImg:@"personal_img_label_travel"] forState:UIControlStateNormal];
                self.btnColor = [UIColor colorWithHex:@"DBEAF4"];
                self.btnTextColor = [UIColor colorWithHex:@"4390C2"];
                strArr = _userInfo.usualPlace;
            }
                break;
            default:
            {
                
            }
                break;
        }
        if (strArr&&strArr.count>0) {
            self.contentLab.hidden = YES;
            [self addTagBtn:strArr];
        }
    }
}

-(void)addTagBtn:(NSArray *)arr{
    CGSize size = CGSizeMake(LayoutUtil.screenWidth-(15+20+15+15)*LayoutUtil.scaling, (50-20)*LayoutUtil.scaling);
    CGFloat btnHeight = 30*LayoutUtil.scaling;
    CGFloat btnMarginX = 5*LayoutUtil.scaling;
    CGFloat btnMarginY = 5*LayoutUtil.scaling;
    CGFloat btnPadding = 20*LayoutUtil.scaling;
    CGFloat viewMarginX = 0*LayoutUtil.scaling;
    CGFloat cornerRadius = 5*LayoutUtil.scaling;
    CGFloat w = viewMarginX;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高,y值
    if (arr&&arr.count>self.btnArr.count) {
        for(long i=self.btnArr.count;i<arr.count;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.userInteractionEnabled = NO;
            btn.showsTouchWhenHighlighted = YES;
            btn.titleLabel.lineBreakMode = NSLineBreakByClipping;
            btn.titleLabel.font = [UIFont systemFontOfSize:14*LayoutUtil.scaling];
            btn.hidden = NO;
            [self.btnArr addObject:btn];
            [self.tagView addSubview:btn];
        }
    }else{
        //重置按钮的状态
        for(long i=0;i<self.btnArr.count;i++){
            UIButton *btn = self.btnArr[i];
            btn.hidden = YES;
        }
    }
    for (int i = 0; i < arr.count; i++) {
        NSString *title = arr[i];
        
        UIButton *btn = self.btnArr[i];
        btn.hidden = NO;
        btn.layer.cornerRadius = cornerRadius;//设置按钮圆角
        [btn setTitleColor:self.btnTextColor forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14*LayoutUtil.scaling]};
        CGFloat width = [title boundingRectWithSize:CGSizeMake(size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        CGFloat btnWidth = 0;
        if ([NSString isNotBlank:title]) {
            btnWidth = MIN(size.width/2.0,btnPadding+width);
        }
        //设置button的frame
        btn.frame = CGRectMake( w, h, btnWidth, btnHeight);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(w + btnMarginX + btnWidth > size.width-viewMarginX){
            w = viewMarginX; //换行时将w置为0
            h = h + btnHeight + btnMarginY;//距离父视图也变化
            btn.frame = CGRectMake( w, h, btnWidth, btnHeight);//重设button的frame
        }
        
        w = btn.frame.size.width + btn.frame.origin.x + btnMarginX;
        [btn setBackgroundColor:self.btnColor];
    }
    //    return btnMarginY + h + btnHeight;
    
}

@end
