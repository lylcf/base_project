//
//  MBProgressHUD+SVPLike.h
//  test
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (SVPLike)

+ (void)show;
+ (void)showWithStatus:(nullable NSString*)status;
+ (void)showWithTextOnly:(nullable NSString *)text;

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(nullable NSString*)status;

+ (void)setStatus:(nullable NSString*)status;

+ (void)showInfoWithStatus:(nullable NSString*)status;

+ (void)showSuccessWithStatus:(nullable NSString*)status;

+ (void)showErrorWithStatus:(nullable NSString*)status;

+ (void)showImage:(nonnull UIImage*)image status:(nullable NSString*)status;

+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithStatus:(nullable NSString *)status;
+ (void)dismissWithInfo:(nullable NSString *)info;
+ (void)dismissWithSuccess:(nullable NSString *)success;
+ (void)dismissWithError:(nullable NSString *)error;

@end
