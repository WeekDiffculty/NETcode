//
//  Netdemo.m
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Netdemo.h"

@implementation Netdemo

- (void)get:(NSString *)url parameters:(NSDictionary *)param success:(Success)success
{
    NSLog(@"url:^%@",url);
    NSLog(@"param:%@",param);
    NSLog(@"另起一个子线程请求");
    NSLog(@"正在进行网络请求");
    NSLog(@"这里已经在子线程中请求了几秒钟");
    
    NSString *response = @"请求下来的结果";
    success(nil,response);
    
}
@end
