//
//  JSTFHomeChatCell.m
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFHomeChatCell.h"

@interface JSTFHomeChatCell()

@property(nonatomic, strong)UIImageView *avatorView;
@property(nonatomic, strong)UILabel *nameLab;
@property(nonatomic, strong)UILabel *contentLab;
@property(nonatomic, strong)UILabel *timeLab;
@end

@implementation JSTFHomeChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadComponent];
    }
    return self;
}
- (void)loadComponent{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView.layer setCornerRadius:6*LayoutUtil.scaling];
    [imageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(50*LayoutUtil.scaling);
    }];
    self.avatorView = imageView;
    
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    timeLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17*LayoutUtil.scaling);
        make.right.mas_equalTo(-15*LayoutUtil.scaling);
        make.width.mas_equalTo(35*LayoutUtil.scaling);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    self.timeLab = timeLab;
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    nameLab.textColor = [UIColor colorWithHex:@"333333"];
    nameLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(15*LayoutUtil.scaling);
        make.top.mas_equalTo(19*LayoutUtil.scaling);
        make.right.equalTo(timeLab.mas_left).offset(-15*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    self.nameLab = nameLab;
    
    UILabel *contentLab = [[UILabel alloc] init];
    contentLab.font = [UIFont systemFontOfSize:12*LayoutUtil.scaling];
    contentLab.textColor = [UIColor colorWithHex:@"a6a6a6"];
    contentLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentLab];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(15*LayoutUtil.scaling);
        make.top.equalTo(nameLab.mas_bottom).offset(3*LayoutUtil.scaling);
        make.right.equalTo(timeLab.mas_left).offset(-15*LayoutUtil.scaling);
        make.height.mas_equalTo(17*LayoutUtil.scaling);
    }];
    self.contentLab = contentLab;
    
}

-(void)setModel:(UserMessageModel *)model{
    _model = model;
    if (_model) {
        if (_model.avator&&_model.avator.count>0) {
            if (_indexPath.section==0) {
                [ImageLoader loadImageWithCache:_model.avator[0] imageView:self.avatorView placeholder:@""];
            }else{
                [self.avatorView setImage:[ImageLoader loadLocalBundleImg:_model.avator[0]]];
            }
        }
        self.nameLab.text = _model.name;
        self.contentLab.text = [NSString isBlank:_model.content]?@"暂无消息":_model.content;
        self.timeLab.text = _model.time;
    }
}
@end
