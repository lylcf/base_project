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
 *   加载最原始的图片，没有渲染
 *
 *  @param imageName 要加载的图片的名字
 *
 *  @return 返回一张没经过渲染的原图
 */
+ (instancetype)imageNameWithOriginal:(NSString *)imageName;


/**
 *  创建一个内容可拉伸，而边角不拉伸的图片
 *  @param imageName 加载的图片
 *
 *  @return 返回内容没有拉伸的图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;


/**
 创建一个横向拉伸，有圆角的图片

 @param color 颜色
 @param radius 圆角半径
 @return 图片
 */
+ (instancetype)stretchableCircleImageWithColor:(UIColor *)color radius:(CGFloat)radius;

// 生成一个圆角图片
- (UIImage *)circleImage;

/**
 *   根据传入的图片,生成一终带有边框的圆形图片;borderW边框宽度;borderColor:边框颜色;image:要生成的原始图片.
 *
 *  @param borderW 边框
 *  @param color   边框夜色
 *  @param image   需要裁剪的图片
 *
 *  @return 返回一张带边框的圆形图片
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image;


/**
 *  根据颜色生成一张尺寸为1*1的相同颜色图片
 *
 *  @param color 颜色
 *
 *  @return 返回一张相同颜色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  截取view视图上的内容生成一张图片
 *
 *  @param view 需要截取的view的内容
 *
 *  @return 返回一张view视图上的图片
 */
+ (UIImage *)imageWithView:(UIView *)view;

/**
 *  返回一张抗锯齿图片本质：在图片生成一个透明为1的像素边框
 *
 *  @return 返回一张抗锯齿图片本质
 */
- (UIImage *)imageAntialias;
@end
