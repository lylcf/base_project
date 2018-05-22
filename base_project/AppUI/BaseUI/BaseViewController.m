//
//  BaseViewController.m
//  base_project
//
//  Created by 亮 巴 on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "BaseViewController.h"
#import <IQKeyboardManager.h>
#import "UIViewController+NetTaskStore.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hidNavigationBar animated:YES];
    [IQKeyboardManager sharedManager].enable = self.KBManagerEnable;
    [IQKeyboardManager sharedManager].enableAutoToolbar = self.KBManagerEnable;
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    if (!parent) {
        [self cancelStoredNetWorking];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

@end
