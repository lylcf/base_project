//
//  UIImage+load.h
//  base_project
//
//  Created by 亮 巴 on 2018/6/19.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (load)

/**
 读取图片但不缓存(不用时释放)

 @param fileName 图片名
 @return 图片
 */
+ (UIImage *)imageFileNamed:(NSString *)fileName;

/**
 读取图片但不缓存(不用时释放)

 @param fileName 图片名
 @param type 图片文件的后缀
 @return 图片
 */
+ (UIImage *)imageFileNamed:(NSString *)fileName type:(NSString *)type;

@end
