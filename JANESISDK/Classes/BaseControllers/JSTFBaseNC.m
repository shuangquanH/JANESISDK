//
//  JSTFBaseNC.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "JSTFBaseNC.h"
#import "JSTFBaseTBC.h"

@interface JSTFBaseNC ()

@end

@implementation JSTFBaseNC

-(instancetype)init{
    JSTFBaseTBC *tabVC = [[JSTFBaseTBC alloc] init];
    self = [super initWithRootViewController:tabVC];
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setParam:(NSDictionary *)param {
    [[NSUserDefaults standardUserDefaults] setObject:param forKey:@"KPARAMFORJANESIAPI"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _param = param;
}


@end
