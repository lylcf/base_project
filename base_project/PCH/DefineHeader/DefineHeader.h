//
//  DefineHeader.h
//  base_project
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

//================================字符宏======================================//

#define ZX_NETWORK_BASEURL @"http://192.168.1.192:8020" //域名




//================================便利宏======================================//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define FontMake(size) [UIFont systemFontOfSize:size]
#define BoldFontMake(size) [UIFont boldSystemFontOfSize:size]

#define WeakSelf(weakSelf)      __weak __typeof(self) weakSelf  = self;
#define StrongSelf(strongSelf)  __strong __typeof(self) strongSelf = weakSelf;

#define kUserDefault [NSUserDefaults standardUserDefaults]
#define kNotifyCenter [NSNotificationCenter defaultCenter]

#endif /* DefineHeader_h */
