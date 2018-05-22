//
//  MBProgressHUD+SVPLike.m
//  test
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "MBProgressHUD+SVPLike.h"
#import <objc/runtime.h>

@implementation MBProgressHUD (SVPLike)

#pragma mark - 公共方法
#pragma mark 系统自带的菊花图
+ (void)show {
    [self showWithStatus:nil];
}

+ (void)showWithStatus:(nullable NSString *)status {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = status;
    [[self frontWindow] addSubview:hud];
    [hud showAnimated:YES];
}

+ (void)showWithTextOnly:(nullable NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [[self frontWindow] addSubview:hud];
    [hud showAnimated:YES];
}

#pragma mark 圆弧进度条
+ (void)showProgress:(float)progress {
    [self showProgress:progress status:nil];
}

+ (void)showProgress:(float)progress status:(nullable NSString *)status {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = status;
    hud.progress = progress;
    if (hud.superview) {
        return;
    }
    [[self frontWindow] addSubview:hud];
    [hud showAnimated:YES];
}

+ (void)setStatus:(nullable NSString *)status {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    hud.detailsLabel.text = status;
}

#pragma mark 图片
+ (void)showImage:(UIImage *)image status:(nullable NSString *)status {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.detailsLabel.text = status;
    [[self frontWindow] addSubview:hud];
    [hud showAnimated:YES];
}

+ (void)showInfoWithStatus:(nullable NSString *)status {
    [self showImage:[self infoImage] status:status];
}

+ (void)showSuccessWithStatus:(nullable NSString *)status {
    [self showImage:[self successImage] status:status];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [self showImage:[self errorImage] status:status];
}

#pragma mark 消失
+ (void)dismiss {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    [hud hideAnimated:YES afterDelay:0];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD shareHUD];
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)dismissWithStatus:(nullable NSString *)status {
    [self showWithStatus:status];
    [self dismissWithDelay:1.5];
}

+ (void)dismissWithInfo:(nullable NSString *)info {
    [self showInfoWithStatus:info];
    [self dismissWithDelay:1.5];
}

+ (void)dismissWithSuccess:(nullable NSString *)success {
    [self showSuccessWithStatus:success];
    [self dismissWithDelay:1.5];
}

+ (void)dismissWithError:(nullable NSString *)error {
    [self showErrorWithStatus:error];
    [self dismissWithDelay:1.5];
}


#pragma mark - 私有方法
//和SVP一样使用同一个HUD
+ (MBProgressHUD *)shareHUD {
    static MBProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MBProgressHUD alloc] initWithSVPLike];
    });
    return instance;
}

//初始化并设置成接近SVP的样式
- (instancetype)initWithSVPLike {
    //用view初始化并不会让HUD成为该view的子view，只是给了HUD Frame而已
    self = [self initWithView:UIApplication.sharedApplication.delegate.window];
    if (self) {
        //消失后从父视图里移除
        self.removeFromSuperViewOnHide = YES;
        //弹窗效果为纯色
        self.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        //弹窗内容(文字+图片)为白色
        self.contentColor = [UIColor whiteColor];
        //弹窗颜色黑色略带透明
        self.bezelView.color = [UIColor colorWithWhite:0 alpha:0.9];
        //显示动画为放大、缩小
        self.animationType = MBProgressHUDAnimationZoom;
        //显示时不遮挡用户操作
        self.userInteractionEnabled = NO;
        //详情label的字体，详情label可以显示多行
        self.detailsLabel.font = [UIFont boldSystemFontOfSize:14];
        //内容的边距
        self.margin = 15.0;
        //向上偏移
        self.offset = CGPointMake(self.offset.x, -34);
    }
    return self;
}

//获取展示HUD的window，此方法和SVP一样
+ (UIWindow *)frontWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    return nil;
}

+ (UIImage *)infoImage {
    static UIImage *info = nil;
    if (!info) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"MBProgressHUD+SVPLike" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        info = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"info" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return info;
}

+ (UIImage *)errorImage {
    static UIImage *error = nil;
    if (!error) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"MBProgressHUD+SVPLike" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        error = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return error;
}

+ (UIImage *)successImage {
    static UIImage *success = nil;
    if (!success) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"MBProgressHUD+SVPLike" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        success = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return success;
}

@end
