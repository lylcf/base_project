//
//  UIView+EasyMethod.h
//  ZP2_iOS
//
//  Created by 黄梦楚 on 2017/10/21.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FDStackView.h>

@interface UIView (EasyMethod)

-(void)addSubviews:(NSArray<UIView *> *)views;

-(void)setForceHorizonContent;
-(void)setForceVerticalContent;

//UIView
- (__kindof UIView *(^)(UIColor *em_bgColor))        em_bgColor;
- (__kindof UIView *(^)(CGFloat em_cornerRadius))    em_cornerRadius;
- (__kindof UIView *(^)(void))                       em_masksToBounds;
- (__kindof UIView *(^)(UIColor *em_borderColor))    em_borderColor;
- (__kindof UIView *(^)(CGFloat em_borderWidth))     em_borderWidth;
- (__kindof UIView *(^)(UIViewContentMode em_contentMode)) em_contentMode;
- (__kindof UIView *(^)(void))                       em_clipsToBounds;
- (__kindof UIView *(^)(void))                       forceHorizonContent;
- (__kindof UIView *(^)(void))                       forceVerticalContent;

//UILabel
- (__kindof UIView *(^)(UIFont *em_font))            em_font;
- (__kindof UIView *(^)(UIColor *em_textColor))      em_textColor;
- (__kindof UIView *(^)(NSInteger em_alignment))     em_textAlignment;
- (__kindof UIView *(^)(NSInteger em_numberOfLines)) em_numberOfLines;

@end

@interface UIStackView (EasyMethod)

-(void)addArrangedSubviews:(NSArray<UIView *> *)views;

+(instancetype)stackViewWithAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing;

@end

//@interface FDStackView (EasyMethod)
//
//-(void)addArrangedSubviews:(NSArray<UIView *> *)views;
//
//+(instancetype)stackViewWithAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing;
//
//@end

