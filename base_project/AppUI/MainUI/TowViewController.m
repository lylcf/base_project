//
//  TowViewController.m
//  base_project
//
//  Created by 亮 巴 on 2018/5/31.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "TowViewController.h"

@interface TowViewController ()

@end

@implementation TowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusBarStyle = UIStatusBarStyleLightContent;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"改变导航栏颜色" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeStatusBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (void)changeStatusBar {
    if (self.statusBarStyle==UIStatusBarStyleDefault) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }else {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
}

@end
