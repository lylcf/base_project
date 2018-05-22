//
//  NSString+AES.m
//  ZhaiHuiBang_PS
//
//  Created by LCY on 17/2/21.
//  Copyright © 2017年 LCY. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (AES)

/**
 AES加密
 
 @param key 秘钥32位
 @return 加密结果
 */
- (NSString *)AES128Encrypt:(NSString *)key {

    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    NSUInteger diff = (kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128)) % kCCKeySizeAES128;
    NSUInteger newLength = dataLength + diff;
    char dataPtr[newLength];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++) {
        dataPtr[dataLength + i] = 0x00;
    }
    
    size_t bufferSize = newLength + kCCKeySizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          nil,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        resultData = [resultData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return resultString;
    }
    free(buffer);
    return nil;
}

/**
 AES解密
 
 @param key 秘钥32位
 @return 加密结果
 */
- (NSString *)AES128Decrypt:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data =  [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCKeySizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          nil,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        resultString = [resultString stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
        return resultString;
    }
    free(buffer);
    return nil;
}
@end
