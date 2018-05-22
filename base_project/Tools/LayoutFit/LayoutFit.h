//
//  LayoutFit.h
//  cxlm_ios
//
//  Created by HMC on 2018/1/11.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

//需要在app启动后第一时间调用
extern void lf_getFitValues(void);

//填入基于iPhone6尺寸的UI数值，会根据当前屏幕尺寸换算成新数值
extern CGFloat iP6(CGFloat value);

//填入基于iPhone6尺寸的UI数值，会根据当前屏幕尺寸换算成新数值，并针对iPhoneX给新数值增加底部非安全区的高度
extern CGFloat iP6_b(CGFloat value);

//填入基于iPhone6尺寸的UI数值，会根据当前屏幕尺寸换算成新数值，并针对iPhoneX给新数值增加顶部非安全区的高度
extern CGFloat iP6_t(CGFloat value);

extern CGFloat tabbarHeight(void);

extern CGFloat navbarHeight(void);

extern BOOL is_iPhoneX(void);
