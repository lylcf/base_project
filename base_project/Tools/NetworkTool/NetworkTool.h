//
//  NetworkTool.h
//  base_project
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#define kNetWorkTool [NetworkTool sharedTool]

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "MCParamenter.h"

@interface NetworkTool : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *manager;

+ (NetworkTool *)sharedTool;

- (NSURLSessionDataTask *)postWithURL:(NSString *)url
                           parameters:(NSDictionary *)parameters
                             getCache:(BOOL)getCache
                              showHUD:(BOOL)showHUD
                              success:(void (^)(id response, BOOL isCache))success
                              failure:(void (^)(NSString *errorString, id response, NSError *error))failure;

- (NSURLSessionDataTask *)getWithURL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                            getCache:(BOOL)getCache
                             showHUD:(BOOL)showHUD
                             success:(void (^)(id response, BOOL isCache))success
                             failure:(void (^)(NSString *errorString, id response, NSError *error))failure;

+ (NSError *)deleteCache;

@end
