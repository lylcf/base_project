//
//  MCParamenter.m
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/12/11.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import "MCParamenter.h"
#import "MBProgressHUD+SVPLike.h"

@interface MCParamenter ()
@property (strong, nonatomic) MCParaMaker *maker;
@end

@implementation MCParamenter

+ (NSMutableDictionary *)makeParamenters:(void (^)(MCParaMaker *))block {
    MCParaMaker *maker = [MCParaMaker new];
    block(maker);
    NSMutableDictionary *paramenters = [NSMutableDictionary dictionary];
    NSString *errorMsg = [maker pourInto:paramenters];
    if (errorMsg) {
        [MBProgressHUD showErrorWithStatus:errorMsg];
        [MBProgressHUD dismissWithDelay:1.0];
        return nil;
    }
    return paramenters;
}

@end



@interface MCParaMaker ()
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation MCParaMaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

- (MCParaMakerItem *)add {
    MCParaMakerItem *item = [MCParaMakerItem new];
    [self.items addObject:item];
    return item;
}

- (NSString *)pourInto:(NSMutableDictionary *)paramenters {
    for (MCParaMakerItem *item in _items) {
        if (!item.a_key) return @"error:key is empty";
        //_a_value和_a_def不能是NSNull
        if ([item.a_value isKindOfClass:[NSNull class]]) item.a_value = nil;
        if ([item.a_def isKindOfClass:[NSNull class]]) item.a_def = nil;
        
        //没有_a_value就用_a_def代替
        if (!item.a_value) item.a_value = item.a_def;
        
        
        if (item.a_value) {
            //有_a_value
            if (item.a_condition) {
                //需要验证
                if (item.a_condition(item.a_value)==YES) {
                    //验证通过，添加参数
                    [paramenters setObject:item.a_value forKey:item.a_key];
                }else {
                    //验证失败
                    if (!item.a_message) {
                        //跳过此参数的添加
                        continue;
                    }else {
                        //返回_a_message作为Toast内容
                        return item.a_message;
                    }
                }
            }else {
                //无需验证，直接添加参数
                [paramenters setObject:item.a_value forKey:item.a_key];
            }
        }else {
            //无_a_value
            if (!item.a_message) {
                //如果_a_value还是没有，也没有_a_message，则跳过此参数的添加
                continue;
            }else {
                //如果_a_value还是没有，有_a_message，则返回_a_message作为Toast内容
                return item.a_message;
            }
        }
        
    }
    return nil;
}

@end



@implementation MCParaMakerItem

- (MCParaMakerItem *(^)(NSString *key))key {
    return ^MCParaMakerItem *(NSString *key) {
        self.a_key = key;
        return self;
    };
}

- (MCParaMakerItem *(^)(id value))value {
    return ^MCParaMakerItem *(id value) {
        self.a_value = value;
        return self;
    };
}

- (MCParaMakerItem *(^)(id (^)(void)))valueBy {
    return ^MCParaMakerItem *(id (^valueBy)(void)) {
        self.a_value = valueBy();
        return self;
    };
}

- (MCParaMakerItem *(^)(id def))def {
    return ^MCParaMakerItem *(id def) {
        self.a_def = def;
        return self;
    };
}

- (MCParaMakerItem *(^)(id (^)(void)))defBy {
    return ^MCParaMakerItem *(id (^defBy)(void)) {
        self.a_def = defBy();
        return self;
    };
}

- (MCParaMakerItem *(^)(BOOL (^)(id value)))condition {
    return ^MCParaMakerItem *(BOOL (^condition)(id value)) {
        self.a_condition = condition;
        return self;
    };
}

- (MCParaMakerItem *(^)(NSString *message))message {
    return ^MCParaMakerItem *(NSString *message) {
        self.a_message = message;
        return self;
    };
}

@end
