//
//  ViewController.m
//  06FinalDemo
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    dispatch_queue_t queue=dispatch_queue_create("com.qingyun.www", NULL);
//    //同步sync 异步async
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"2");
//    });
//    NSLog(@"1");
//    
}
//在队列中调用多个任务(子线程)
-(IBAction)touchDownBtn:(id)sender{
    //队列分为3种:
    /*
     1.串行队列 dispatch_queue_create("com.qingyun.com", NULL)
     NULL默认表示DISPATCH_QUEUE_SERIAL串行 表示任务按顺序执行
     DISPATCH_QUEUE_CONCURRENT 并行 (并发执行) 表示任务同时执行
     2.主队列 系统预定义的运行在主线程的一个主队列
     dispatch_get_main_queue(); 与主线程同步执行的一些任务
     //3.并发队列
     (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); 任务同时进行
     */
    //1.创建一个串行队列
    dispatch_queue_t queue=dispatch_queue_create("com.qingyun.com", NULL);
    //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_get_main_queue();
    //dispatch_queue_create("com.qingyun.com", NULL);
    dispatch_async(queue, ^{
        //2.1等待的操作 ,延迟1s
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1");
        //同步任务,造成死锁,在队列当中,不能添加同步任务,如果添加同步任务,会造成死锁.
        dispatch_sync(queue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2");
        });
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3");
        });
    
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
