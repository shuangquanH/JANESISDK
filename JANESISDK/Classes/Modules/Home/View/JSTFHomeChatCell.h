//
//  JSTFHomeChatCell.h
//  JSTempFun
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMessageModel.h"

@interface JSTFHomeChatCell : UITableViewCell

@property(nonatomic, strong)UserMessageModel *model;
@property(nonatomic, strong)NSIndexPath *indexPath;

@end
