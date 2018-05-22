//
//  UIColor+Hex.h
//  quanmintoupiao
//
//  Created by Admin HC on 15/11/20.
//  Copyright © 2015年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
//#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#define UIColorHex(_hex_)   [UIColor colorWithHexString:_hex_]
#define UIColorHexAlpha(_hex_, _alpha_)   [UIColor colorWithHexString:_hex_ alpha:(_alpha_)]

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
