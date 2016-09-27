//
//  main.m
//  01触摸
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QYApplication.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        //表示接收的两个参数
        //第三个参数:表示当前的iPhone应用程序本身,会读取info.plist文件获取配置信息,
        //第四个参数:代理类,
        return UIApplicationMain(argc, argv, NSStringFromClass([QYApplication class]),NSStringFromClass([AppDelegate class]) );
    }
}
