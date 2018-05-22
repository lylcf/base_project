//
//  MCMethodLimiter.m
//  zx_adpacket
//
//  Created by HMC on 2018/5/21.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "MCMethodLimiter.h"
#import <objc/runtime.h>

@implementation MCMethodLimiter

+ (void)callMethodWithTarget:(id)target identify:(NSString *)identify methode:(void (^)(void))methode coolDownInterval:(NSTimeInterval)coolDown {
    MCLimitItem *item = objc_getAssociatedObject(target, &identify);
    if (item) {
        item.methode = methode;
    }else {
        item = [MCLimitItem new];
        item.coolDown = coolDown;
        item.methode = methode;
        objc_setAssociatedObject(target, &identify, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [item executeDelayMethode];
}

@end


@implementation MCLimitItem

- (void)executeDelayMethode {
    if (_isDelay) return;
    if (!_lastDate) {
        [self executeMethode];
        return;
    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_lastDate];
    if (interval >= _coolDown) {
        [self executeMethode];
    }else {
        [self beginDelay];
    }
}

//直接执行
- (void)executeMethode {
    if (_methode) _methode();
    _methode = nil;
    _lastDate = [NSDate date];
    _isDelay = NO;
}

//延时执行
- (void)beginDelay {
    _isDelay = YES;
    [self performSelector:@selector(executeMethode) withObject:nil afterDelay:_coolDown];
}

@end
