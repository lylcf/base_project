//
//  ProjectColor.h
//  base_project
//
//  Created by HMC on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>
#define pColor [ProjectColor shareColor]

@interface ProjectColor : NSObject

+ (ProjectColor *)shareColor;

@property (strong, nonatomic) UIColor *themeColor;


@end
