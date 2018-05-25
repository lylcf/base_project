//
//  UIImage+Image.h
//  图片工具
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

/**
 创建一个可拉伸，有圆角的图片
 
 @param color 颜色
 @param radius 圆角半径
 @return 图片
 */
//水平拉伸
+ (instancetype)horizonStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius;

+ (instancetype)horizonStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size;
//垂直拉伸
+ (instancetype)verticalStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius;

+ (instancetype)verticalStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size;
//水平&垂直拉伸
+ (instancetype)stretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius;

+ (instancetype)stretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size;

/**
 根据颜色生成一张尺寸为1*1的纯色图片

 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据颜色、大小生成一张纯色图片

 @param color 颜色
 @param size 大小
 @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 截取view视图上的内容生成一张图片

 @param view 需要截取的view的内容
 @return 一张view视图上的图片
 */
+ (UIImage *)imageWithView:(UIView *)view;

@end
