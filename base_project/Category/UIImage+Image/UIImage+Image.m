//
//  UIImage+Image.m
//  图片工具
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2012年 itcast. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype)imageNameWithOriginal:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
     // 返回一个没有渲染图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

+ (instancetype)stretchableCircleImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    UIImage *image = [UIImage imageWithColor:color size:CGSizeMake(radius*2+2, radius*2)];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:radius];
    [clipPath addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [newimage stretchableImageWithLeftCapWidth:radius+1 topCapHeight:0];
}

// 生成一个圆角图片
- (UIImage *)circleImage
{
    // 裁剪图片: 图形上下文
    // 1.开启图形上下文
    // scale:比例因素 点:像素比例 0:自动识别比例因素
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述圆形裁剪路径
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置为裁剪区域
    [clipPath addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image{
    //    1.开启一个和原始图片一样大小的位图上下文.
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size,NO,0);
    //    2.绘制一个大圆,填充
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    //    3.添加一个裁剪区域.
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    //    4.把图片绘制到裁剪区域当中.
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    //    5.生成一张新图片.
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //    6.关闭上下文.
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    //2.获取位图上下文
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    //3.把当前View的内容渲染到上下文
    [view.layer renderInContext:ctx];
    //4.从上下文当中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}


// 在周边加一个边框为1的透明像素
- (UIImage *)imageAntialias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}
@end
