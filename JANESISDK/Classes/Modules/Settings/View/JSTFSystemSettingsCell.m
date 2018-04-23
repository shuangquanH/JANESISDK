//
//  JSTFSystemSettingsCell.m
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFSystemSettingsCell.h"

@implementation JSTFSystemSettingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configUI:(NSDictionary *)dic{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UISwitch *switchBtn = [[UISwitch alloc] init];
    NSString *isPush = [dic objectForKey:@"push"];
    if ([NSString isNotBlank:isPush]&&[isPush isEqualToString:@"0"]) {
        switchBtn.on = YES;
    }else{
        switchBtn.on = NO;
    }
    [self.contentView addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16*LayoutUtil.scaling);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [switchBtn addTarget:self action:@selector(swithClick:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *title = [[UILabel alloc] init];
    title.textAlignment = NSTextAlignmentLeft;
    title.textColor = [UIColor colorWithHex:@"333333"];
    title.text = [dic objectForKey:@"title"];
    title.font = [UIFont systemFontOfSize:16*LayoutUtil.scaling];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(15*LayoutUtil.scaling);
        make.right.equalTo(switchBtn.mas_left).offset(-15*LayoutUtil.scaling);
        make.height.mas_equalTo(22*LayoutUtil.scaling);
    }];
    
}
-(void)swithClick:(UISwitch *)switchBtn{
    if ([self.delegate respondsToSelector:@selector(openPushBtn:)]) {
        [self.delegate openPushBtn:switchBtn.on];
    }
}
@end
