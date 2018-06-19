//
//  UIImage+load.m
//  base_project
//
//  Created by 亮 巴 on 2018/6/19.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "UIImage+load.h"

@implementation UIImage (load)

+ (UIImage *)imageFileNamed:(NSString *)fileName {
    return [self imageFileNamed:fileName type:@"png"];
}

+ (UIImage *)imageFileNamed:(NSString *)fileName type:(NSString *)type {
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:type]];
}

@end
