//
//  NetworkTool.m
//  base_project
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "NetworkTool.h"
#import "NSString+MD5For32Bit.h"

@implementation NetworkTool

+ (NetworkTool *)sharedTool {
    static NetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //        config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        //        //设置请求时不走手机现在设置的http代理，防止抓包
        //        config.connectionProxyDictionary = @{};
        //        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:config];
        
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求
        //self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 10.f;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        self.manager.session.configuration.connectionProxyDictionary = @{};
        //        [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //        [self.manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        //        [self.manager.requestSerializer setValue:@"APIClient Platform/iOS" forHTTPHeaderField:@"User-agent"];
        //        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //        self.manager.requestSerializer.HTTPShouldHandleCookies = YES;
    }
    return self;
}

- (NSURLSessionDataTask *)postWithURL:(NSString *)url
                           parameters:(NSDictionary *)parameters
                             getCache:(BOOL)getCache
                              showHUD:(BOOL)showHUD
                              success:(void (^)(id response, BOOL isCache))success
                              failure:(void (^)(NSString *errorString, id response, NSError *error))failure
{
    NSString *pathString = url;
    //pathString = [@"post" stringByAppendingString:pathString];
    /*
    //在url后拼接用户id可以根据用户区分不同的缓存，请自行根据项目的用户模型编写逻辑
    if ([kSharedUserManager getLocationUsername]) {
        pathString = [url stringByAppendingString:kSharedUserManager.getLocationUsername];
    }
     */
    if (getCache && success) {
        id response = [NetworkTool getCacheWithNameString:pathString];
        if (response) {
            success(response, YES);
        }
    }
    if (showHUD) {
        [MBProgressHUD show];
    }
    NSURLSessionDataTask *task = [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showHUD) {
            [MBProgressHUD dismiss];
        }
        if (!responseObject && success) {
            success(nil, NO);
            return;
        }
        NSString *state = responseObject[@"state"];
        if ([state isEqualToString:@"success"]) {
            //成功
            success(responseObject, NO);
            if (getCache) {
                [NetworkTool cacheDataWithFileNameString:pathString responseObject:responseObject];
            }
        }else {
            //失败
            NSString *errorString = responseObject[@"message"];
            if (showHUD) {
                [MBProgressHUD showErrorWithStatus:errorString];
                [MBProgressHUD dismissWithDelay:2.0];
            }
            if (failure) {
                failure(errorString,responseObject,nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code==NSURLErrorCancelled) {
            if (showHUD) {
                [MBProgressHUD dismiss];
            }
            return;
        }
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        if (showHUD) {
            [MBProgressHUD showErrorWithStatus:error.userInfo[NSLocalizedDescriptionKey]];
            [MBProgressHUD dismissWithDelay:2.0];
        }
        if (failure) {
            failure(error.userInfo[NSLocalizedDescriptionKey],nil,error);
        }
    }];
    return task;
}

- (NSURLSessionDataTask *)getWithURL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                            getCache:(BOOL)getCache
                             showHUD:(BOOL)showHUD
                             success:(void (^)(id response, BOOL isCache))success
                             failure:(void (^)(NSString *errorString, id response, NSError *error))failure
{
    NSString *pathString = url;
    //pathString = [@"get" stringByAppendingString:pathString];
    /*
     //在url后拼接用户id可以根据用户区分不同的缓存，请自行根据项目的用户模型编写逻辑
     if ([kSharedUserManager getLocationUsername]) {
     pathString = [url stringByAppendingString:kSharedUserManager.getLocationUsername];
     }
     */
    if (getCache && success) {
        id response = [NetworkTool getCacheWithNameString:pathString];
        if (response) {
            success(response, YES);
        }
    }
    if (showHUD) {
        [MBProgressHUD show];
    }
    NSURLSessionDataTask *task = [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showHUD) {
            [MBProgressHUD dismiss];
        }
        if (!responseObject && success) {
            success(nil, NO);
            return;
        }
        NSString *state = responseObject[@"state"];
        if ([state isEqualToString:@"success"]) {
            //成功
            success(responseObject, NO);
            if (getCache) {
                [NetworkTool cacheDataWithFileNameString:pathString responseObject:responseObject];
            }
        }else {
            //失败
            NSString *errorString = responseObject[@"message"];
            if (showHUD) {
                [MBProgressHUD showErrorWithStatus:errorString];
                [MBProgressHUD dismissWithDelay:2.0];
            }
            if (failure) {
                failure(errorString,responseObject,nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code==NSURLErrorCancelled) {
            if (showHUD) {
                [MBProgressHUD dismiss];
            }
            return;
        }
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        if (showHUD) {
            [MBProgressHUD showErrorWithStatus:error.userInfo[NSLocalizedDescriptionKey]];
            [MBProgressHUD dismissWithDelay:2.0];
        }
        if (failure) {
            failure(error.userInfo[NSLocalizedDescriptionKey],nil,error);
        }
    }];
    return task;
}

#pragma mark - 缓存
#pragma mark 读取缓存
+ (id)getCacheWithNameString:(NSString *)nameString {
    if (!nameString || nameString.length==0) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:[self cachePathWithNameString:nameString]];
    return [data mj_JSONObject];
}

#pragma mark 缓存数据
+ (void)cacheDataWithFileNameString:(NSString *)nameString responseObject:(id)responseObject {
    if (!nameString || nameString.length==0) {
        return;
    }
    if (!responseObject) {
        return;
    }
    NSData *data = responseObject;
    if (![responseObject isKindOfClass:[NSData class]]) {
        data = [responseObject mj_JSONData];
    }
    [data writeToFile:[self cachePathWithNameString:nameString] atomically:YES];
}

#pragma mark 删除缓存
+ (NSError *)deleteCacheWithNameString:(NSString *)nameString {
    NSString *filePath = [self cachePathWithNameString:nameString];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:filePath];
    if (bRet) {
        NSError *err;
        [fileMgr removeItemAtPath:filePath error:&err];
        return err;
    }
    return nil;
}

+ (NSError *)deleteCache {
    //NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *netCachesDir = [tempDir stringByAppendingPathComponent:@"ZXNetCache"];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:netCachesDir];
    if (bRet) {
        NSError *err = nil;
        [fileMgr removeItemAtPath:netCachesDir error:&err];
        return err;
    }
    return nil;
}

#pragma mark 缓存路径
+ (NSString *)cachePathWithNameString:(NSString *)nameString {
    //NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *netCachesDir = [tempDir stringByAppendingPathComponent:@"ZXNetCache"];
    BOOL isDir = NO;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:netCachesDir isDirectory:&isDir];
    if (!exist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:netCachesDir withIntermediateDirectories:NO attributes:nil error:nil];
    }else {
        if (!isDir) {
            [[NSFileManager defaultManager] removeItemAtPath:netCachesDir error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:netCachesDir withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
    
    NSString *path = [netCachesDir stringByAppendingPathComponent:[nameString md532BitLower]];
    NSLog(@"%@",path);
    return path;
}

@end
