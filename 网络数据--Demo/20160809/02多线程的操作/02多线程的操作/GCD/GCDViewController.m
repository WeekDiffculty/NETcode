//
//  GCDViewController.m
//  02多线程的操作
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GCDViewController.h"
#define Img_URL @"http://f.hiphotos.baidu.com/image/h%3D200/sign=3630dd6c4336acaf46e091fc4cd88d03/bd3eb13533fa828b5bc103b6f51f4134960a5a81.jpg"
#define Img1_URL @"http://f.hiphotos.baidu.com/image/h%3D200/sign=9d661b069dcad1c8cfbbfb274f3e67c4/5bafa40f4bfbfbed064c3d5670f0f736afc31f85.jpg"
@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)gcdBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            [self globalQueue];
            break;
        case 2:
              [self mainQueue];
        case 3:
            [self dispatchApply];
        case 4:
            [self dispatchOnce];//调用一次
        case 5:
            [self dispatchAfter];//延迟执行
        case 6:
            [self defineDispatch];//自定义队列
        case 7:
            [self globalQueue2];//添加子任务
        case 8:
            [self dispatchGroup]; //在组中调用异步任务的请求
        default:
          
            
            break;
    }
}
//全局的队列(并发队列)
-(void) globalQueue{
    __weak GCDViewController *vc=self;
    NSLog(@"%s",__func__);
    //并发队列+异步任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"调用代码块");
        //代码块
        [vc loadImageSource:Img_URL];
    });
    NSLog(@"并发队列+异步任务执行");
}
//主队列(调用主线程来执行的)
-(void) mainQueue{
    //所有的ui的操作是在主线程运行,dispatch_get_main_queue()调用主队列,即队列中的主线程来刷新ui
    __weak GCDViewController *vc=self;
    //代码调用的顺序和globalQueue方法一样
    dispatch_async(dispatch_get_main_queue(),^{
        [vc loadImageSource:Img_URL];
    });

}
//并发执行循环次数
-(void) dispatchApply{
    //DISPATCH_QUEUE_PRIORITY_DEFAULT 优先级
    dispatch_queue_t quue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t size_count=10;//循环次数
    dispatch_apply(size_count, quue, ^(size_t i){
        NSLog(@"循环执行第%li",i);
    });
    
}
//只调用一次  单例
-(void) dispatchOnce{
    __weak GCDViewController *vc=self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [vc loadImageSource:Img_URL];
    });
}
//延迟执行
-(void) dispatchAfter{
    __weak GCDViewController *vc=self;
    double delaySec=3.0;//延迟3s
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaySec*NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        NSLog(@"延迟3s执行");
        [vc loadImageSource:Img_URL];
    });
}
//自定义队列
-(void) defineDispatch{
    //创建队列 标识是唯一值
    dispatch_queue_t queue=dispatch_queue_create("com.qingyun.www", NULL);
     __weak GCDViewController *vc=self;
    //在异步任务调用队列
    dispatch_async(queue, ^{
        [vc loadImageSource:Img_URL];
    });
}
-(void) globalQueue2{
    //在异步任务当中创建调用多个子异步任务 注意点:不能创建同步任务,否则会出现死锁情况
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载图片1
        NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Img_URL]];
        UIImage *image=[UIImage imageWithData:imgData];
        //下载图片2
        NSData *imgData1=[NSData dataWithContentsOfURL:[NSURL URLWithString:Img1_URL]];
        UIImage *image1=[UIImage imageWithData:imgData1];
        
        //刷新ui操作
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新2个UIimageview
            imgView.image=image;
            imgView1.image=image1;
        });
    });
}
//任务组
-(void) dispatchGroup{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_group_t group=dispatch_group_create();
        __block UIImage *imag1=nil;
        __block UIImage *image2=nil;
        //在组中创建一个异步任务(线程) 下载图片1
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Img_URL]];
            imag1=[UIImage imageWithData:imgData];
        });
        //下载图片2
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Img1_URL]];
            image2=[UIImage imageWithData:imgData];
        });
        //等待所有任务(线程)执行结束后,在主队列(线程)刷新ui
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            imgView1.image=imag1;
            imgView.image=image2;
        });
        
    });
}
//网络加载图片并显示
-(void) loadImageSource:(NSString *) strUrl{
    NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    UIImage *image=[UIImage imageWithData:imgData];
    if (image!=nil) {
        [self performSelectorOnMainThread:@selector(updateUI1:) withObject:image waitUntilDone:YES];
    }
}
//只刷新imageView1控件
-(void) updateUI1:(UIImage *) image{
    imgView1.image=image;
}

@end
