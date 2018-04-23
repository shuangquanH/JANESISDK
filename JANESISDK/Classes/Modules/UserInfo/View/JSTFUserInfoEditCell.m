//
//  JSTFUserInfoEditCell.m
//  JSTempFun
//
//  Created by mc on 2018/4/8.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserInfoEditCell.h"

@interface JSTFUserInfoEditCell()

@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *contentLab;

@end
@implementation JSTFUserInfoEditCell

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
    UILabel *title = [[UILabel alloc] init];
    title.text = @"";
    title.textColor = [UIColor colorWithHex:@"a6a6a6"];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(95*LayoutUtil.scaling);
        make.height.mas_equalTo(22);
    }];
    self.titleLab = title;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImage:[ImageLoader loadLocalBundleImg:@"cell_icon_click_gray"]];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(9*LayoutUtil.scaling);
        make.height.mas_equalTo(14*LayoutUtil.scaling);
    }];
    
    UILabel *content = [[UILabel alloc] init];
    content.text = @"";
    content.textColor = [UIColor colorWithHex:@"cccccc"];
    content.textAlignment = NSTextAlignmentLeft;
    content.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.contentView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(8*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(imageView.mas_left).offset(8*LayoutUtil.scaling);
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
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if (_userInfo) {
        switch (_indexPath.row) {
            case 1:
            {
                self.titleLab.text = @"行业";
                if ([NSString isNotBlank:_userInfo.profession]) {
                    self.contentLab.textColor = [UIColor colorWithHex:@"333333"];
                    self.contentLab.text = _userInfo.profession;
                }else{
                    self.contentLab.text = @"添加你的职位信息";
                    self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
                }
            }
                break;
            case 2:
            {
                self.titleLab.text = @"工作领域";
                if ([NSString isNotBlank:_userInfo.work]) {
                    self.contentLab.textColor = [UIColor colorWithHex:@"333333"];
                    self.contentLab.text = _userInfo.work;
                }else{
                    self.contentLab.text = @"添加你的工作领域";
                    self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
                }
            }
                break;
            case 3:
            {
                self.titleLab.text = @"来自";
                if ([NSString isNotBlank:_userInfo.city]) {
                    self.contentLab.textColor = [UIColor colorWithHex:@"333333"];
                    self.contentLab.text = _userInfo.city;
                }else{
                    self.contentLab.text = @"添加你的家乡信息";
                    self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
                }
            }
                break;
            case 4:
            {
                self.titleLab.text = @"经常出没";
                if ([NSString isNotBlank:_userInfo.hauntAbout]) {
                    self.contentLab.textColor = [UIColor colorWithHex:@"333333"];
                    self.contentLab.text = _userInfo.hauntAbout;
                }else{
                    self.contentLab.text = @"添加你经常去的地方";
                    self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
                }
                
            }
                break;
            case 5:
            {
                self.titleLab.text = @"个人签名";
                if ([NSString isNotBlank:_userInfo.idiograph]) {
                    self.contentLab.textColor = [UIColor colorWithHex:@"333333"];
                    self.contentLab.text = _userInfo.idiograph;
                }else{
                    self.contentLab.text = @"编辑你的个人签名";
                    self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
                }
                
            }
                break;
            default:
            {
                self.titleLab.text = @"";
                self.contentLab.text = @"";
                self.contentLab.textColor = [UIColor colorWithHex:@"cccccc"];
            }
                break;
        }
    }
}
@end
