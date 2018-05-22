//
//  NSArray+ElegantNil.h
//  zx_aiChat
//
//  Created by HMC on 2018/3/7.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ElegantNil)

//根据index取对象，若index 超出范围或低于范围则返回nil
- (id)objOrNilAtIndex:(NSInteger)index;

//根据index取对象，若index超出范围或低于范围则返回空字符串
- (id)objOrEmptyStringAtIndex:(NSInteger)index;

@end

@interface NSMutableArray (ElegantNil)

//添加的对象为空则不添加
- (void)addObjOrNot:(id)anObject;

@end
