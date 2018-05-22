//
//  LayoutFit.m
//  cxlm_ios
//
//  Created by HMC on 2018/1/11.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "LayoutFit.h"

static CGFloat iP6ratio = 0;

static CGFloat statusbarHeight = 20.0;

static CGFloat x_top = 0;

static CGFloat x_btm = 0;

static BOOL isiphonex = NO;

CGFloat iP6(CGFloat value) {
    return value * iP6ratio;
}

CGFloat iP6_b(CGFloat value) {
    return iP6(value) + x_btm;
}

CGFloat iP6_t(CGFloat value) {
    return iP6(value) + x_top;
}

BOOL is_iPhoneX() {
    return isiphonex;
}

CGFloat tabbarHeight() {
    return x_btm + 49.0;
}

CGFloat navbarHeight() {
    return statusbarHeight + 44.0;
}

void lf_getFitValues() {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) == 812.0) {
        x_top = 44.0;
        x_btm = 34.0;
        statusbarHeight = 44.0;
        isiphonex = YES;
    }
    iP6ratio = width/375.0;
    //isiphonex = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    NSLog(@"UI比例：%.1f",iP6ratio);
}
