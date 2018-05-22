//
//  NSDictionary+ElegantNil.m
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/12/4.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import "NSDictionary+ElegantNil.h"

@implementation NSDictionary (ElegantNil)

- (id)objOrNilForKey:(id)aKey
{
    if (!aKey) {return nil;}
    id object = [self objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (id)objOrEmptyStringForKey:(id)aKey
{
    if (!aKey) return @"";
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) object = nil;
    return object ? object : @"";
}

@end

@implementation NSMutableDictionary (ElegantNil)

- (void)setObjOrEmptyString:(id)anObject forKey:(id)aKey {
    if (!aKey) return;
    if (!anObject) {
        [self setObject:@"" forKey:aKey];
        return;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)setObjOrNot:(id)anObject forKey:(id)aKey {
    if (!aKey) return;
    if (!anObject) return;
    [self setObject:anObject forKey:aKey];
}

@end
