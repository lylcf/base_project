//
//  BaseNavigationController.m
//  base_project
//
//  Created by 亮 巴 on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (self.viewControllers.count>=1) {
        [self setBackButtonFor:viewController];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if (viewControllers.count>=2) {
        UIViewController *viewController = [viewControllers lastObject];
        [self setBackButtonFor:viewController];
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        BOOL open = self.viewControllers.count>1;
        return open;
    }
    return NO;
}

#pragma mark - 私有方法
- (void)setBackButtonFor:(UIViewController *)viewController {
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
//    viewController.navigationItem.leftBarButtonItem = item;
}


@end
