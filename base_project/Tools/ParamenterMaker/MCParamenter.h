//
//  MCParamenter.h
//  jiaxiaoqin
//
//  Created by 黄梦楚 on 2017/12/11.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCParamenter;
@class MCParaMaker;
@class MCParaMakerItem;

@interface MCParamenter : NSObject

@property (strong, nonatomic) NSMutableDictionary *dict;

/**
 生成网络请求参数

 @param block 在此block内用链式编程编辑网络请求参数
 @return 最终生成的请求参数
 */
+ (NSMutableDictionary *)makeParamenters:(void(^)(MCParaMaker *maker))block;

@end

@interface MCParaMaker : NSObject


/**
 添加一组key:value时调用，告知maker接下来的操作会添加一组key:value

 @return 返回MCParaMakerItem进行链式编程
 */
- (MCParaMakerItem *)add;

//私有方法，由内部调用
- (NSString *)pourInto:(NSMutableDictionary *)paramenters;

@end

@interface MCParaMakerItem : NSObject

@property (strong, nonatomic) NSString *a_key;
@property (strong, nonatomic) id a_value;
@property (strong, nonatomic) id a_def;
@property (copy  , nonatomic) BOOL (^a_condition)(id value);
@property (strong, nonatomic) NSString *a_message;

/**
 设置key
 */
- (MCParaMakerItem *(^)(NSString *key))key;

/**
 设置value
 */
- (MCParaMakerItem *(^)(id value))value;

/**
 借助block通过自定义逻辑设置value
 */
- (MCParaMakerItem *(^)(id (^)(void)))valueBy;

/**
 设置默认值，生成请求参数时如果没有value，会取用默认值
 */
- (MCParaMakerItem *(^)(id def))def;

/**
 借助block通过自定义逻辑设置默认值
 */
- (MCParaMakerItem *(^)(id (^)(void)))defBy;

/**
 借助block设置参数校验逻辑
 */
- (MCParaMakerItem *(^)(BOOL (^)(id value)))condition;

/**
 设置提示语，设置后如果没有value，会终停止生成请求参数并弹出错误提示，并返回一个nil字典
 */
- (MCParaMakerItem *(^)(NSString *message))message;

@end
