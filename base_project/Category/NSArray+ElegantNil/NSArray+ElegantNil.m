//
//  NSArray+ElegantNil.m
//  zx_aiChat
//
//  Created by HMC on 2018/3/7.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "NSArray+ElegantNil.h"

@implementation NSArray (ElegantNil)

- (id)objOrNilAtIndex:(NSInteger)index {
    if (self.count==0 || index<0 || index > self.count-1) {
        return nil;
    }else {
        id object = [self objectAtIndex:index];
        return [object isEqual:[NSNull null]] ? nil : object;
    }
}

- (id)objOrEmptyStringAtIndex:(NSInteger)index {
    id obj = [self objOrNilAtIndex:index];
    if (!obj) obj = @"";
    return obj;
}

@end

@implementation NSMutableArray (ElegantNil)

- (void)addObjOrNot:(id)anObject {
    if (!anObject) return;
    [self addObject:anObject];
}

@end
