//
//  UIView+EasyMethod.m
//  ZP2_iOS
//
//  Created by 黄梦楚 on 2017/10/21.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import "UIView+EasyMethod.h"

@implementation UIView (EasyMethod)

-(void)addSubviews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
        [self addSubview:view];
    }
}

-(void)setForceHorizonContent {
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)setForceVerticalContent {
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - UIView
- (__kindof UIView *(^)(UIColor *em_bgColor))em_bgColor {
    return ^__kindof UIView *(UIColor *em_bgColor) {
        self.backgroundColor = em_bgColor;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat em_cornerRadius))em_cornerRadius {
    return ^__kindof UIView *(CGFloat em_cornerRadius) {
        self.layer.cornerRadius = em_cornerRadius;
        return self;
    };
}

- (__kindof UIView *(^)(void))em_masksToBounds {
    return ^__kindof UIView *() {
        self.layer.masksToBounds = YES;
        return self;
    };
}

- (__kindof UIView *(^)(void))em_clipsToBounds {
    return ^__kindof UIView *() {
        self.clipsToBounds = YES;
        return self;
    };
}

- (__kindof UIView *(^)(UIColor *em_borderColor))em_borderColor {
    return ^__kindof UIView *(UIColor *em_borderColor) {
        self.layer.borderColor = em_borderColor.CGColor;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat em_borderWidth))em_borderWidth {
    return ^__kindof UIView *(CGFloat em_borderWidth) {
        self.layer.borderWidth = em_borderWidth;
        return self;
    };
}

- (__kindof UIView *(^)(UIViewContentMode))em_contentMode {
    return ^__kindof UIView *(UIViewContentMode em_contentMode) {
        self.contentMode = em_contentMode;
        return self;
    };
}

- (__kindof UIView *(^)(void))forceHorizonContent {
    return ^__kindof UIView *() {
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (__kindof UIView *(^)(void))forceVerticalContent {
    return ^__kindof UIView *() {
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

#pragma mark - UILabel
- (__kindof UIView *(^)(UIFont *))em_font {
    return ^__kindof UIView *(UIFont *em_font) {
        if ([self isKindOfClass:[UILabel class]] ||
            [self isKindOfClass:[UITextField class]] ||
            [self isKindOfClass:[UITextView class]]) {
            ((UILabel *)self).font = em_font;
            return self;
        }else {
            return self;
        }
    };
}

- (__kindof UIView *(^)(UIColor *em_textColor))em_textColor {
    return ^__kindof UIView *(UIColor *em_textColor) {
        if ([self isKindOfClass:[UILabel class]] ||
            [self isKindOfClass:[UITextField class]] ||
            [self isKindOfClass:[UITextView class]]) {
            ((UILabel *)self).textColor = em_textColor;
            return self;
        }else {
            return self;
        }
    };
}

- (__kindof UIView *(^)(NSInteger em_textAlignment))em_textAlignment {
    return ^__kindof UIView *(NSInteger em_textAlignment) {
        if ([self isKindOfClass:[UILabel class]] ||
            [self isKindOfClass:[UITextField class]] ||
            [self isKindOfClass:[UITextView class]]) {
            ((UILabel *)self).textAlignment = em_textAlignment;
            return self;
        }else {
            return self;
        }
    };
}

- (__kindof UIView *(^)(NSInteger em_numberOfLines))em_numberOfLines {
    return ^__kindof UIView *(NSInteger em_numberOfLines) {
        if ([self isKindOfClass:[UILabel class]]) {
            ((UILabel *)self).numberOfLines = em_numberOfLines;
            return self;
        }else {
            return self;
        }
    };
}

@end

@implementation UIStackView (EasyMethod)

-(void)addArrangedSubviews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
        [self addArrangedSubview:view];
    }
}

+(instancetype)stackViewWithAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing {
    UIStackView *stackView = [UIStackView new];
    stackView.axis = axis;
    stackView.distribution = distribution;
    stackView.alignment = alignment;
    stackView.spacing = spacing;
    return stackView;
}

@end

//@implementation FDStackView (EasyMethod)
//
//-(void)addArrangedSubviews:(NSArray<UIView *> *)views {
//    for (UIView *view in views) {
//        [self addArrangedSubview:view];
//    }
//}
//
//+(instancetype)stackViewWithAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing {
//    FDStackView *stackView = [self new];
//    stackView.axis = axis;
//    stackView.distribution = distribution;
//    stackView.alignment = alignment;
//    stackView.spacing = spacing;
//    return stackView;
//}
//
//@end

