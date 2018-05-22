//
//  ViewController.m
//  base_project
//
//  Created by 亮 巴 on 2018/4/10.
//  Copyright © 2018年 zxhlrj. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTool.h"
#import "UIViewController+NetTaskStore.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *test;

@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"释放VC");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _test= @"aaa";
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    if (!parent) {
        [self cancelStoredNetWorking];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableDictionary *parameters = [MCParamenter makeParamenters:^(MCParaMaker *maker) {
        maker.add.key(@"Page").def(@"1");
        maker.add.key(@"Mumber").def(@"10");
    }];
    if (!parameters) return;
    NSURLSessionDataTask *task = [kNetWorkTool postWithURL:@"http://vip.yuntunetwork.com/AppService/YunTu_Rank.ashx" parameters:parameters getCache:NO cacheData:NO showHUD:YES success:^(id response, BOOL isCache) {
        _test = @"bbb";
    } failure:^(NSString *errorString, id response, NSError *error) {

    }];
    [self addNetTask:task];
}

- (void)aTask {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
