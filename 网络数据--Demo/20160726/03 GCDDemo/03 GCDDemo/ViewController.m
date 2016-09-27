//
//  ViewController.m
//  03 GCDDemo
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
    
}
//子线程1方法1
-(NSString *) firstThread{
    //延迟3s运行
   // [NSThread sleepForTimeInterval:3];
        return @"firstThread";
}
//子线程方法2
-(NSString *) secondThread{
     [NSThread sleepForTimeInterval:2];
    return @"secondThread";
}
//子线程方法3
-(NSString *) thirdThread{
     [NSThread sleepForTimeInterval:3];
    return @"thirdThread";
}
//子线程last方法
-(NSString *) lastThread{
     [NSThread sleepForTimeInterval:1];
    return @"lastThread";
}
//同步和异步的区别:
//同步:多个任务按顺序执行
//异步:多个任务同时执行
-(void) getDispath{
    __weak ViewController *vc=self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //任务1
        NSString *firstStr=[vc firstThread];
        NSLog(@"%@",firstStr);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //任务2
            NSString *secondStr=[vc secondThread];
            NSLog(@"%@",secondStr);
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            //任务3
            NSString *thirdStr=[vc thirdThread];
            NSLog(@"%@",thirdStr);
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //任务4
            NSString *lastStr=[vc lastThread];
            NSLog(@"%@",lastStr);
        });
        
    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 1), ^{
//        NSLog(@"子线程");
//        
//    });
}
-(void) GetGroupDispath{
    __weak ViewController *vc=self;
    dispatch_async(Queue, ^{
       //创建一个组
        dispatch_group_t group=dispatch_group_create();
        //2.first
        NSString *str=[vc firstThread];
        NSLog(@"%@",str);
        //3.group与队列建立起关系,队列的任务执行完成后,以方便回调
        dispatch_group_async(group, Queue, ^{
            NSString *strSec=[vc secondThread];
            NSLog(@"%@",strSec);
        });
        dispatch_group_async(group, Queue, ^{
            NSString *strThird=[vc thirdThread];
            NSLog(@"%@",strThird);
        });
        dispatch_group_async(group, Queue, ^{
            NSString *strLast=[vc lastThread];
            NSLog(@"%@",strLast);
        });
        //group组中所有的子线程执行完后,通知刷新ui
        dispatch_group_notify(group, Queue, ^{
            //刷新主线程ui
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"刷新主线程ui");
            });
        });
    });
}
-(IBAction)loadThreadBtn:(id)sender{
    //[self getDispath];
    [self GetGroupDispath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
