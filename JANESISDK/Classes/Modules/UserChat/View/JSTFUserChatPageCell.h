//
//  JSTFUserChatPageCell.h
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserChatModel.h"

@interface JSTFUserChatPageCell : UITableViewCell

@property(nonatomic, strong)UserChatModel *model;
@property(nonatomic, copy)NSString *avator;
@property(nonatomic, assign)BOOL isSystemMess;
@end
