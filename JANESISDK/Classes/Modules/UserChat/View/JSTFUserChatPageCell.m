//
//  JSTFUserChatPageCell.m
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFUserChatPageCell.h"
#import "JSTFDialogBoxView.h"

@interface JSTFUserChatPageCell()

@property(nonatomic, strong)UIImageView *avatorView;
@property(nonatomic, strong)UILabel *contentLab;

@end
@implementation JSTFUserChatPageCell

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
    self.contentView.backgroundColor = [UIColor colorWithHex:@"f4f5f5"];
}

-(void)setModel:(UserChatModel *)model{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _model = model;
    if (_model) {
        if ([NSString isNotBlank:_model.userModified]) {//用户发送，右边
            CGFloat screenWidth = LayoutUtil.screenWidth;
            CGFloat spacingX = 15*LayoutUtil.scaling;
            CGFloat spacingY = 12*LayoutUtil.scaling;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*LayoutUtil.scaling]};
            CGSize size = [_model.userModified boundingRectWithSize:CGSizeMake(screenWidth-(15+40+10)*LayoutUtil.scaling*2-spacingX*2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView.layer setCornerRadius:6*LayoutUtil.scaling];
            [imageView.layer setMasksToBounds:YES];
            if ([NSString isNotBlank:_avator]) {
                [ImageLoader loadImageWithCache:_avator imageView:imageView placeholder:nil];
            }
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20*LayoutUtil.scaling);
                make.right.mas_equalTo(-15*LayoutUtil.scaling);
                make.width.height.mas_equalTo(40*LayoutUtil.scaling);
            }];
            self.avatorView = imageView;
            
            JSTFDialogBoxView *box = [[JSTFDialogBoxView alloc] initWithDirection:JSTFDialogBoxDirectionRight];
            [self.contentView addSubview:box];
            [box mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20*LayoutUtil.scaling);
                make.right.mas_equalTo(-(15+40+10)*LayoutUtil.scaling);
                make.width.mas_equalTo(size.width+spacingX*2);
                make.height.mas_equalTo(size.height+spacingY*2);
            }];
            
            UILabel *content = [[UILabel alloc] init];
            content.numberOfLines = 0;
            content.text = _model.userModified;
            content.textAlignment = NSTextAlignmentLeft;
            content.textColor = [UIColor colorWithHex:@"ffffff"];
            [box addSubview:content];
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(box.mas_centerX);
                make.centerY.equalTo(box.mas_centerY);
                make.width.mas_equalTo(size.width);
                make.height.mas_equalTo(size.height);
            }];
            self.contentLab = content;
            if (!_model.isVaild) {
                UIImageView *isVaildView = [[UIImageView alloc] init];
                [isVaildView setImage:[ImageLoader loadLocalBundleImg:@"chat_img_input_error"]];
                [self.contentView addSubview:isVaildView];
                [isVaildView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(box.mas_centerY);
                    make.right.equalTo(box.mas_left).inset(15*LayoutUtil.scaling);
                    make.width.height.mas_equalTo(25*LayoutUtil.scaling);
                }];
            }
            
        }else{
            CGFloat screenWidth = LayoutUtil.screenWidth;
            CGFloat spacingX = 15*LayoutUtil.scaling;
            CGFloat spacingY = 12*LayoutUtil.scaling;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*LayoutUtil.scaling]};
            CGSize size = [_model.toUserModified boundingRectWithSize:CGSizeMake(screenWidth-(15+40+10)*LayoutUtil.scaling*2-spacingX*2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView.layer setCornerRadius:6*LayoutUtil.scaling];
            [imageView.layer setMasksToBounds:YES];
            if ([NSString isNotBlank:_avator]) {
                if (_isSystemMess) {
                    [imageView setImage:[ImageLoader loadLocalBundleImg:_avator]];
                }else{
                    [ImageLoader loadImageWithCache:_avator imageView:imageView placeholder:nil];
                }
            }
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20*LayoutUtil.scaling);
                make.left.mas_equalTo(15*LayoutUtil.scaling);
                make.width.height.mas_equalTo(40*LayoutUtil.scaling);
            }];
            self.avatorView = imageView;
            
            JSTFDialogBoxView *box = [[JSTFDialogBoxView alloc] initWithDirection:JSTFDialogBoxDirectionLeft];
            [self.contentView addSubview:box];
            [box mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20*LayoutUtil.scaling);
                make.left.mas_equalTo((15+40+10)*LayoutUtil.scaling);
                make.width.mas_equalTo(size.width+spacingX*2);
                make.height.mas_equalTo(size.height+spacingY*2);
            }];
            
            UILabel *content = [[UILabel alloc] init];
            content.numberOfLines = 0;
            content.text = _model.toUserModified;
            content.textAlignment = NSTextAlignmentLeft;
            content.textColor = [UIColor colorWithHex:@"333333"];
            [box addSubview:content];
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(box.mas_centerX);
                make.centerY.equalTo(box.mas_centerY);
                make.width.mas_equalTo(size.width);
                make.height.mas_equalTo(size.height);
            }];
            self.contentLab = content;
        }
    }
}

@end
