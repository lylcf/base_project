//
//  MCButton.h
//  cxlm_ios
//
//  Created by 亮 巴 on 2018/1/9.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MCButtonStyle) {
    MCButtonStyleImageLeft,
    MCButtonStyleImageRight,
    MCButtonStyleImageTop,
    MCButtonStyleImageBottom,
};

@interface MCButton : UIButton

//按钮样式
@property (assign, nonatomic) MCButtonStyle buttonStyle;
//图片与文字间的距离
@property (assign, nonatomic) CGFloat insetSpace;
//图片大小，不设置则使用图片原本大小
@property (assign, nonatomic) CGSize imageSize;
//label大小，不设置则适应文字
@property (assign, nonatomic) CGSize labelSize;
//内边距，若指定了按钮整体大小，只有上、左会生效
@property (assign, nonatomic) UIEdgeInsets innerInsets;
//是否允许按钮达到高亮
@property (assign, nonatomic) BOOL hightlightEnable;

+ (instancetype)mcButtonWithImageSize:(CGSize)imageSize insetSpace:(CGFloat)insetSpace style:(MCButtonStyle)style;

+ (instancetype)mcButtonWithImageSize:(CGSize)imageSize style:(MCButtonStyle)style;

+ (instancetype)mcButtonWithInsetSpace:(CGFloat)insetSpace style:(MCButtonStyle)style;

+ (instancetype)mcButtonWithStyle:(MCButtonStyle)style;

@end
