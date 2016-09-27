//
//  AppDelegate.m
//  01 sandboxDemo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.获取应用程序它的根目录(沙盒路径)
    NSString *homePath=NSHomeDirectory();
    NSLog(@"根目录地址%@",homePath);
    //2.app所在的路径
    NSString *bundlePath=[[NSBundle mainBundle] bundlePath];
    NSLog(@"项目资源文件地址%@",bundlePath);
    //3.Documents
   NSArray *docArr= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSLog(@"%@",docArr);
    NSString *docPath=[docArr objectAtIndex:0];
    NSLog(@"%@",docPath);
    //4.Library Path
    NSArray *libraryArr=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //NSLog(@"%@",libraryArr);
    NSString *libraryPath=[libraryArr objectAtIndex:0];
    NSLog(@"%@",libraryPath);
    //5.caches path
    NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",cachePath);
    //7.temp Path
    NSString *tempPath=NSTemporaryDirectory();
    
    NSLog(@"%@",tempPath);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
