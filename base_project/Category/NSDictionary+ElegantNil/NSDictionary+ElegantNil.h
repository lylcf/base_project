//
//  NSDictionary+ElegantNil.h
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/12/4.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ElegantNil)

- (id)objOrNilForKey:(id)aKey;

- (id)objOrEmptyStringForKey:(id)aKey;

@end

@interface NSMutableDictionary (ElegantNil)

- (void)setObjOrEmptyString:(id)anObject forKey:(id)aKey;

- (void)setObjOrNot:(id)anObject forKey:(id)aKey;

@end
