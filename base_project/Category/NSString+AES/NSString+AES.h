//
//  NSString+AES.h
//  ZhaiHuiBang_PS
//
//  Created by LCY on 17/2/21.
//  Copyright © 2017年 LCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

/**
 AES加密

 @param key 秘钥32位
 @return 加密结果
 */
- (NSString *)AES128Encrypt:(NSString *)key;

/**
 AES解密
 
 @param key 秘钥32位
 @return 加密结果
 */
- (NSString *)AES128Decrypt:(NSString *)key;
@end
