//
//  UIAlertController+Show.m
//  base_project
//
//  Created by 亮 巴 on 2018/6/8.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "UIAlertController+Show.h"

@implementation UIAlertController (Show)

- (void)show {
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *presentedVC = [[window rootViewController] presentedViewController];
    if (presentedVC) {
        [presentedVC presentViewController:self animated:animated completion:nil];
    }else {
        [window.rootViewController presentViewController:self animated:animated completion:nil];
    }
}

@end
