//
//  UIView+HidenWithLayoutConstraints.h
//  zx_aiChat
//
//  Created by 亮 巴 on 2018/2/6.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HidenWithLayoutConstraints)

- (void)hideView:(BOOL)hidden withAttributes:(NSLayoutAttribute)attributes,...NS_REQUIRES_NIL_TERMINATION;

@end
