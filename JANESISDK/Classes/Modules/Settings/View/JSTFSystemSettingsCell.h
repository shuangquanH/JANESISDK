//
//  JSTFSystemSettingsCell.h
//  JSTempFun
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JSTFSystemSettingsCellDelegate <NSObject>
@optional

-(void)openPushBtn:(BOOL)isOpen;
@end

@interface JSTFSystemSettingsCell : UITableViewCell

@property (weak, nonatomic) id<JSTFSystemSettingsCellDelegate>delegate;

-(void)configUI:(NSDictionary *)dic;


@end
