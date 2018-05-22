//
//  NSString+MD5For32Bit.h
//  zx_yuepao
//
//  Created by zxhlrj on 17/6/17.
//  Copyright © 2017年 zxhlrj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5For32Bit)

/**
 小写md5

 @return md5
 */
- (NSString*)md532BitLower;


/**
 大写md5

 @return md5
 */
- (NSString*)md532BitUpper;

@end
