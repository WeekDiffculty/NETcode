//
//  AppDelegate.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "QYMainViewController.h"
#import "QYGuideViewController.h"
#import "QYAccessToken.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window setBackgroundColor:[UIColor whiteColor]];
    
    // 根据条件设置跟控制器
    // 1, 从info.plist文件中读取当前的外部版本号
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    // 2, 读取自己上一次运行引导页保存的版本号
    NSString *strVersionMine = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersionKey"];
    
    //读取accessToken值
    [[QYAccessToken shareInstance] readToken];
    if ([strVersion isEqualToString:strVersionMine]) { // 版本相同, 进入主页
        [self loadMainController];
    } else { // 版本不同, 进入引导页
        [_window setRootViewController:[[QYGuideViewController alloc] init]];
    }
    
    [_window makeKeyAndVisible];
    
    return YES;
}

// 直接跳转到主控制器
- (void)loadMainController {
    [_window setRootViewController:[[QYMainViewController alloc] init]];
}

@end
