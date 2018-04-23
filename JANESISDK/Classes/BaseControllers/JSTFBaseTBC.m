//
//  JSTFBaseTBC.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFBaseTBC.h"
#import "JSTFBaseNC.h"

#import "JSTFHomeMatchVC.h"
#import "JSTFHomeChatVC.h"
#import "JSTFHomeMineVC.h"
@interface JSTFBaseTBC ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation JSTFBaseTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = NO;
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = PanGestureLeftEdge;
    //初始化tabbar设置
    JSTFHomeMatchVC *fVC = [[JSTFHomeMatchVC alloc] init];
    fVC.tabBarItem = [self createUITabBarItem:nil normalName:@"tabbar_item_match_unselect" selectName:@"tabbar_item_match_select" tag:1000+0];
    
    JSTFHomeChatVC *sVC = [[JSTFHomeChatVC alloc] init];
    sVC.tabBarItem = [self createUITabBarItem:nil normalName:@"tabbar_item_chat_unselect" selectName:@"tabbar_item_chat_select" tag:1000+1];
    
    JSTFHomeMineVC *tVC = [[JSTFHomeMineVC alloc] init];
    tVC.tabBarItem = [self createUITabBarItem:nil normalName:@"tabbar_item_mine_unselect" selectName:@"tabbar_item_mine_select" tag:1000+2];
    
    self.delegate = self;
    
    self.tabBar.translucent = NO;
    NSArray * viewControllers = @[fVC,sVC,tVC];
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([SystemUtils userIsLogin]) {
        if ([SystemUtils readUserLoginTager]) {
            
        }else{
            NSMutableDictionary *property = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:@"JSTFUserSexVC" forKey:@"controllerName"];
            [dic setObject:property forKey:@"property"];
            [PageJumpRouter presentToViewControllerWithProperty:dic];
        }
    }else{
        [PageJumpRouter jumpToLoginPage];
    }
    
}
- (UITabBarItem *)createUITabBarItem :(NSString *)title normalName:(NSString *)normalName selectName:(NSString *)selectName tag:(int)tag{
    UIImage *normalImage = [ImageLoader loadLocalBundleImg:normalName];
    //按比例缩小原图
    normalImage = [normalImage scaleToSize:CGSizeMake(49.0, 49.0)];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [ImageLoader loadLocalBundleImg:selectName];
    selectImage = [selectImage scaleToSize:CGSizeMake(49.0, 49.0)];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //不设置title时 设置空值就可以了
    UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];
    barItem.tag = tag;
    [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0], NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:54/255.0 green:155/255.0 blue:255/255.0 alpha:1.0], NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName,nil] forState:UIControlStateSelected];
    barItem.imageInsets = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    //    [fourbarItem setTitlePositionAdjustment: UIOffsetMake(0,0)];
    barItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    return barItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
