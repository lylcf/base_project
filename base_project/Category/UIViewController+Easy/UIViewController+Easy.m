//
//  UIViewController+Easy.m
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/11/27.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import "UIViewController+Easy.h"
#import <objc/runtime.h>

@implementation UIViewController (Easy)

#pragma Setter & Getter

- (void)setKBManagerEnable:(BOOL)KBManagerEnable {
    objc_setAssociatedObject(self, @selector(KBManagerEnable), @(KBManagerEnable), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)KBManagerEnable {
    NSNumber *num = objc_getAssociatedObject(self, @selector(KBManagerEnable));
    if (!num) {
        objc_setAssociatedObject(self, @selector(KBManagerEnable), @(NO), OBJC_ASSOCIATION_RETAIN);
        num = @(NO);
    }
    return [num integerValue];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    objc_setAssociatedObject(self, @selector(statusBarStyle), @(statusBarStyle), OBJC_ASSOCIATION_RETAIN);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)statusBarStyle {
    NSNumber *num = objc_getAssociatedObject(self, @selector(statusBarStyle));
    if (!num) {
        objc_setAssociatedObject(self, @selector(statusBarStyle), @(UIStatusBarStyleLightContent), OBJC_ASSOCIATION_RETAIN);
        num = @(UIStatusBarStyleLightContent);
    }
    return [num integerValue];
}

- (void)setHidNavigationBar:(BOOL)hidNavigationBar {
    objc_setAssociatedObject(self, @selector(hidNavigationBar), @(hidNavigationBar), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hidNavigationBar {
    NSNumber *num = objc_getAssociatedObject(self, @selector(hidNavigationBar));
    if (!num) {
        objc_setAssociatedObject(self, @selector(hidNavigationBar), @(NO), OBJC_ASSOCIATION_RETAIN);
        num = @(NO);
    }
    return [num boolValue];
}

@end
