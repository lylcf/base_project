//
//  MCMethodLimiter.h
//  zx_adpacket
//
//  Created by HMC on 2018/5/21.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMethodLimiter : NSObject

/**
 添加一个需要限制频率的方法

 @param target 该方法所有者，runtime会将一个延时管理对象作为属性添加到该target上
 @param identify 唯一标识符
 @param methode block，在里面调用方法
 @param coolDown 延时时间，单位秒，支持小数点后4位
 */
+ (void)callMethodWithTarget:(id)target identify:(NSString *)identify methode:(void(^)(void))methode coolDownInterval:(NSTimeInterval)coolDown;

@end

@interface MCLimitItem : NSObject

@property (assign, nonatomic) BOOL isDelay;//是否已经执行延时方法
@property (copy  , nonatomic) void (^methode)(void);//
@property (assign, nonatomic) NSTimeInterval coolDown;
@property (strong, nonatomic) NSDate *lastDate;//上次执行的时间

- (void)executeDelayMethode;

@end
