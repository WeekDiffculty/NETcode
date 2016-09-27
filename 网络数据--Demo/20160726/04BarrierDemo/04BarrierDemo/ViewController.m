//
//  ViewController.m
//  04BarrierDemo
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
    [self BarrierLoad];
}
-(void) login{
    NSLog(@"%s",__func__);
}
-(void) BarrierLoad{
    //1.创建一个并发队列,
    dispatch_queue_t queue=dispatch_queue_create("com.qing.www", DISPATCH_QUEUE_CONCURRENT);
    //2. 分发任务
    __weak ViewController *vc=self;
    //一个任务,子线程
    dispatch_async(queue, ^{
        //在任务中调用多个任务,子线程中子线程
        //2.1登录
        [vc login];
        //2.2获取配置信息
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        //2.3 获取好友信息
        dispatch_async(queue, ^{
            NSLog(@"4");
        });
        //2.3 个人资料
        dispatch_async(queue, ^{
            NSLog(@"5");
        });
        //2.4.显示主界面,需要设置内存屏障,内存障碍
        //等上面所有的任务(子线程)执行结束后, dispatch_barrier_async 才会执行
        dispatch_barrier_async(queue, ^{
            NSLog(@"2");
        });
        //2.5获取好友的聊天列表
        dispatch_async(queue, ^{
            NSLog(@"1");
        });
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
