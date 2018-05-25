//
//  UIImage+Image.m
//  图片工具
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2012年 itcast. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype)horizonStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    return [self stretchableImageWithColor:color radius:radius size:CGSizeZero type:1];
}

+ (instancetype)verticalStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    return [self stretchableImageWithColor:color radius:radius size:CGSizeZero type:2];
}

+ (instancetype)stretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    return [self stretchableImageWithColor:color radius:radius size:CGSizeZero type:0];
}

+ (instancetype)horizonStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size {
    return [self stretchableImageWithColor:color radius:radius size:size type:1];
}

+ (instancetype)verticalStretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size {
    return [self stretchableImageWithColor:color radius:radius size:size type:2];
}

+ (instancetype)stretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size {
    return [self stretchableImageWithColor:color radius:radius size:size type:0];
}

+ (instancetype)stretchableImageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size type:(NSInteger)type {
    CGSize imageSize = CGSizeZero;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        if (type==1) {
            imageSize = CGSizeMake(ceil(radius)*2+1, radius*2);
        }else if (type==2) {
            imageSize = CGSizeMake(radius*2, ceil(radius)*2+1);
        }else {
            imageSize = CGSizeMake(ceil(radius)*2+1, ceil(radius)*2+1);
        }
    }else {
        imageSize = CGSizeMake(MAX(size.width, radius*2), MAX(size.height, radius*2));
    }
    UIImage *image = [self imageWithColor:color size:imageSize];
    UIImage *newimage = image;
    if (radius!=0) {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:radius];
        [clipPath addClip];
        [image drawAtPoint:CGPointZero];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (type==1) {
        //水平拉伸
        return [newimage stretchableImageWithLeftCapWidth:ceil(radius) topCapHeight:0];
    }
    if (type==2) {
        //垂直拉伸
        return [newimage stretchableImageWithLeftCapWidth:0 topCapHeight:ceil(radius)];
    }
    //水平&垂直拉伸
    return [newimage stretchableImageWithLeftCapWidth:ceil(radius) topCapHeight:ceil(radius)];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1.0, 1.0)];
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

@end
