//
//  ProjectColor.m
//  base_project
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "ProjectColor.h"

@implementation ProjectColor

+ (ProjectColor *)shareColor {
    static ProjectColor *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ProjectColor alloc] init];
    });
    return instance;
}

- (UIColor *)themeColor {
    if (!_themeColor) {
        _themeColor = UIColorHex(@"52b3ff");
    }
    return _themeColor;
}

@end
