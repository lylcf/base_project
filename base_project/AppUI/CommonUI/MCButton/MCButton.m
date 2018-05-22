//
//  MCButton.m
//  cxlm_ios
//
//  Created by 亮 巴 on 2018/1/9.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "MCButton.h"

@interface MCButton ()

@property (assign, nonatomic) CGSize intrinsicSize;
@property (weak  , nonatomic) UILabel *originalLabel;

@end

@implementation MCButton

-(void)awakeFromNib {
    [super awakeFromNib];
    self.buttonStyle = MCButtonStyleImageLeft;
    self.insetSpace = 0;
    self.imageSize = CGSizeZero;
    self.labelSize = CGSizeZero;
    self.originalLabel = self.titleLabel;
}

-(instancetype)init {
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonStyle = MCButtonStyleImageLeft;
        self.insetSpace = 0;
        self.imageSize = CGSizeZero;
        self.labelSize = CGSizeZero;
        self.originalLabel = self.titleLabel;
    }
    return self;
}

+ (instancetype)mcButtonWithImageSize:(CGSize)imageSize insetSpace:(CGFloat)insetSpace style:(MCButtonStyle)style
{
    MCButton *button = [super buttonWithType:UIButtonTypeCustom];
    if (button) {
        button.buttonStyle = style;
        button.insetSpace = insetSpace;
        button.imageSize = imageSize;
        //注意，若在titleRectForContentRect直接用 self.titleLabel 来获取titleLabel，会陷入死循环，因此用另外一个属性来获取titleLabel
        button.originalLabel = button.titleLabel;
    }
    return button;
}

+(instancetype)mcButtonWithImageSize:(CGSize)imageSize style:(MCButtonStyle)style
{
    return [self mcButtonWithImageSize:imageSize insetSpace:0.0 style:style];
}

+(instancetype)mcButtonWithInsetSpace:(CGFloat)insetSpace style:(MCButtonStyle)style
{
    return [self mcButtonWithImageSize:CGSizeZero insetSpace:insetSpace style:style];
}

+(instancetype)mcButtonWithStyle:(MCButtonStyle)style
{
    return [self mcButtonWithImageSize:CGSizeZero insetSpace:0.0 style:style];
}

+(instancetype)buttonWithType:(UIButtonType)buttonType
{
    return [self mcButtonWithImageSize:CGSizeZero insetSpace:0.0 style:MCButtonStyleImageLeft];
}

-(CGSize)caculateImageSize
{
    CGSize imageSize = CGSizeZero;
    if (self.currentImage) {
        imageSize = CGSizeMake(_imageSize.width==0?self.currentImage.size.width:_imageSize.width, _imageSize.height==0?self.currentImage.size.height:_imageSize.height);
    }
    return imageSize;
}

-(CGSize)caculateTitleLabelSize
{
    CGSize labelSize = CGSizeZero;
    if (_labelSize.height!=0 && _labelSize.width!=0) {
        return _labelSize;
    }
    if (self.currentTitle) {
        labelSize = [self.currentTitle boundingRectWithSize:CGSizeZero
                                                    options:\
                     NSStringDrawingTruncatesLastVisibleLine |
                     NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:_originalLabel.font?_originalLabel.font:[UIFont systemFontOfSize:18]}
                                                    context:nil].size;
    }
    return labelSize;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (!self.currentImage) {
        return [super imageRectForContentRect:contentRect];
    }
    
    CGSize imageSize = [self caculateImageSize];
    CGSize labelSize = [self caculateTitleLabelSize];
    
    CGFloat space = self.currentTitle ? _insetSpace : 0;
    
    if (_buttonStyle==MCButtonStyleImageLeft||_buttonStyle==MCButtonStyleImageRight) {
        
        CGSize minContent = CGSizeMake(imageSize.width+space+labelSize.width, MAX(imageSize.height, labelSize.height));
        CGFloat minContent_X, minContent_Y = 0;
        if (UIEdgeInsetsEqualToEdgeInsets(_innerInsets, UIEdgeInsetsZero)) {
            minContent_X = (contentRect.size.width-minContent.width)/2;
            minContent_Y = (contentRect.size.height-minContent.height)/2;
        }else {
            minContent_X = _innerInsets.left;
            minContent_Y = _innerInsets.top;
        }
        
        _intrinsicSize = CGSizeMake(minContent.width + _innerInsets.left + _innerInsets.right,
                                    minContent.height + _innerInsets.top + _innerInsets.bottom);
        [self invalidateIntrinsicContentSize];
        
        if (_buttonStyle==MCButtonStyleImageLeft) {
            return CGRectMake(minContent_X, minContent_Y+(minContent.height-imageSize.height)/2, imageSize.width, imageSize.height);
        }else {
            return CGRectMake(minContent_X+labelSize.width+space, minContent_Y+(minContent.height-imageSize.height)/2, imageSize.width, imageSize.height);
        }
        
    }else {
        
        CGSize minContent = CGSizeMake(MAX(imageSize.width, labelSize.width), imageSize.height+space+labelSize.height);
        CGFloat minContent_X, minContent_Y = 0;
        if (UIEdgeInsetsEqualToEdgeInsets(_innerInsets, UIEdgeInsetsZero)) {
            minContent_X = (contentRect.size.width-minContent.width)/2;
            minContent_Y = (contentRect.size.height-minContent.height)/2;
        }else {
            minContent_X = _innerInsets.left;
            minContent_Y = _innerInsets.top;
        }
        
        _intrinsicSize = CGSizeMake(minContent.width + _innerInsets.left + _innerInsets.right,
                                    minContent.height + _innerInsets.top + _innerInsets.bottom);
        [self invalidateIntrinsicContentSize];
        
        if (_buttonStyle==MCButtonStyleImageTop) {
            return CGRectMake(minContent_X+(minContent.width-imageSize.width)/2, minContent_Y, imageSize.width, imageSize.height);
        }else {
            return CGRectMake(minContent_X+(minContent.width-imageSize.width)/2, minContent_Y+labelSize.height+space, imageSize.width, imageSize.height);
        }
        
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (!self.currentTitle) {
        return [super titleRectForContentRect:contentRect];
    }
    
    CGFloat space = self.currentImage ? _insetSpace : 0;
    
    CGSize labelSize = [self caculateTitleLabelSize];
    CGSize imageSize = [self caculateImageSize];
    
    if (_buttonStyle==MCButtonStyleImageLeft||_buttonStyle==MCButtonStyleImageRight) {
        
        CGSize minContent = CGSizeMake(imageSize.width+space+labelSize.width, MAX(imageSize.height, labelSize.height));
        CGFloat minContent_X, minContent_Y = 0;
        if (UIEdgeInsetsEqualToEdgeInsets(_innerInsets, UIEdgeInsetsZero)) {
            minContent_X = (contentRect.size.width-minContent.width)/2;
            minContent_Y = (contentRect.size.height-minContent.height)/2;
        }else {
            minContent_X = _innerInsets.left;
            minContent_Y = _innerInsets.top;
        }
        
        _intrinsicSize = CGSizeMake(minContent.width + _innerInsets.left + _innerInsets.right,
                                    minContent.height + _innerInsets.top + _innerInsets.bottom);
        [self invalidateIntrinsicContentSize];
        
        if (_buttonStyle==MCButtonStyleImageLeft) {
            return CGRectMake(minContent_X+imageSize.width+space, minContent_Y+(minContent.height-labelSize.height)/2, labelSize.width, labelSize.height);
        }else {
            return CGRectMake(minContent_X, minContent_Y+(minContent.height-labelSize.height)/2, labelSize.width, labelSize.height);
        }
        
    }else {
        
        CGSize minContent = CGSizeMake(MAX(imageSize.width, labelSize.width), imageSize.height+space+labelSize.height);
        CGFloat minContent_X, minContent_Y = 0;
        if (UIEdgeInsetsEqualToEdgeInsets(_innerInsets, UIEdgeInsetsZero)) {
            minContent_X = (contentRect.size.width-minContent.width)/2;
            minContent_Y = (contentRect.size.height-minContent.height)/2;
        }else {
            minContent_X = _innerInsets.left;
            minContent_Y = _innerInsets.top;
        }
        
        _intrinsicSize = CGSizeMake(minContent.width + _innerInsets.left + _innerInsets.right,
                                    minContent.height + _innerInsets.top + _innerInsets.bottom);
        [self invalidateIntrinsicContentSize];
        
        if (_buttonStyle==MCButtonStyleImageTop) {
            return CGRectMake(minContent_X+(minContent.width-labelSize.width)/2, minContent_Y+imageSize.height+space, labelSize.width, labelSize.height);
        }else {
            return CGRectMake(minContent_X+(minContent.width-labelSize.width)/2, minContent_Y, labelSize.width, labelSize.height);
        }
        
    }
}

-(CGSize)intrinsicContentSize
{
    return _intrinsicSize;
}

-(void)setHighlighted:(BOOL)highlighted {
    if (_hightlightEnable) {
        [super setHighlighted:highlighted];
    }
}

@end
