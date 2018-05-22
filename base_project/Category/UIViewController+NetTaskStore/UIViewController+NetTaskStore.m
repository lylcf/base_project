//
//  UIViewController+NetTaskStore.m
//  base_project
//
//  Created by HMC on 2018/4/11.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "UIViewController+NetTaskStore.h"
#import <objc/runtime.h>

static NSString *taskStore = @"taskStore";

@implementation UIViewController (NetTaskStore)

- (void)cancelStoredNetWorking {
    NSPointerArray *pointer = objc_getAssociatedObject(self, &taskStore);
    if (!pointer) {
        return;
    }
    for (NSURLSessionDataTask *task in pointer) {
        if (task && [task respondsToSelector:@selector(cancel)]) {
            NSLog(@"取消网络请求");
            [task cancel];
        }
    }
}

- (void)addNetTask:(NSURLSessionDataTask *)task {
    //用弱引用数组持有task，网络请求完毕的task会自动释放
    NSPointerArray *pointer = objc_getAssociatedObject(self, &taskStore);
    if (!pointer) {
        pointer = [NSPointerArray weakObjectsPointerArray];
        objc_setAssociatedObject(self, &taskStore, pointer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [pointer addPointer:(__bridge void * _Nullable)(task)];
}

@end

@implementation UIView (NetTaskStore)

- (void)addNetTask:(NSURLSessionDataTask *)task {
    UIViewController *belongVC = self.belongViewController;
    if (belongVC) {
        [belongVC addNetTask:task];
    }
}

- (UIViewController *)belongViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end





