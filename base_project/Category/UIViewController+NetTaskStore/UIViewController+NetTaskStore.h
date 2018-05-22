//
//  UIViewController+NetTaskStore.h
//  base_project
//
//  Created by HMC on 2018/4/11.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NetTaskStore)

/**
 将这个方法写在viewDidDisappear里或者willMoveToParentViewController里
 可以在页面消失时取消addNetTask:添加的网络请求
 
 例子：
 -(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self cancelNetWorking];
 }
 
 - (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    if (!parent) {
        [self cancelNetWorking];
    }
 }
 */
- (void)cancelStoredNetWorking;

/**
 将想要跟随页面一起取消的网络请求添加进来

 @param task 网络请求的task
 */
- (void)addNetTask:(NSURLSessionDataTask *)task;

@end

@interface UIView (NetTaskStore)

/**
 如果页面中的某个封装控件内部有网络请求，可以通过这个方法将网络请求添加到该控件所在的页面里
 
 @param task 网络请求的task
 */
- (void)addNetTask:(NSURLSessionDataTask *)task;


/**
 返回该view所属的ViewController

 @return 该view所属的ViewController
 */
- (UIViewController *)belongViewController;

@end
