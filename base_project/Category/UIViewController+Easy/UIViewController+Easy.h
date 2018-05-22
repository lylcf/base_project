//
//  UIViewController+Easy.h
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/11/27.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Easy)

@property (assign, nonatomic) BOOL KBManagerEnable;
@property (assign, nonatomic) BOOL hidNavigationBar;

/*
 info.plist 设置ViewController对StatusBar的设置优先级高于Application:
 View controller-based status bar appearance : YES
 
 如果ViewController是NavigationController的根控制器
     1.在NavigationController里：
     - (UIStatusBarStyle)preferredStatusBarStyle {
         return self.statusBarStyle;
     }
     - (UIViewController *)childViewControllerForStatusBarStyle {
         return self.topViewController;
     }
     2.在ViewController里
     - (void)viewDidLoad {
         [super viewDidLoad];
         self.statusBarStyle = ...;
     }
     - (UIStatusBarStyle)preferredStatusBarStyle {
         return self.statusBarStyle;
     }
 如果ViewController是Window的根控制器
     直接进行上面的第2.步骤
 */
@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;

@end
