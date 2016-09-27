//
//  ViewController.m
//  NSOperationDemo
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "DownloadFile.h"
#define IMG_URL @"http://www.4k123.com/data/attachment/forum/201402/10/011607sgwbg81m1ussrogn.jpg"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化操作队列
    operationQueue=[[NSOperationQueue alloc] init];
}
-(IBAction)DownloadBtn:(id)sender{
#if 0
    //方式1. 通过选择器的方式
    //1.初始化任务,每个任务看做一个线程
    NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadThread) object:nil];
    //2.将任务添加到队列
    [operationQueue addOperation:operation];
    //方式2. 通过block块的方式
    __weak ViewController *vc=self;
    //初始化任务,通过block块实现
    NSBlockOperation *operationBlock=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operationBlock");
        [vc downloadThread];
    }];
    [operationQueue addOperation:operationBlock];
#endif
    [self downloadFile];

}
-(void) downloadFile{
    //1.初始化任务对象
    DownloadFile *downloadFile=[[DownloadFile alloc] initWithDownloadUrl:IMG_URL];
    __weak UIImageView *tempImgView=imgView;

    downloadFile.block=^(UIImage *image){
        if([[NSThread currentThread] isMainThread]){
            NSLog(@"是主线程");
        }else{
            NSLog(@"子线程");
            //刷新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                tempImgView.image=image;
            });

        }
    };
    //将任务添加至操作队列
    [operationQueue addOperation:downloadFile];
    
}
-(void) downloadThread{
    NSLog(@"downloadThread");
    //1.nsurl对象
    NSURL *url=[NSURL URLWithString:IMG_URL];
    //2.下载图片文件
    NSData *data=[NSData dataWithContentsOfURL:url];
    //3.NSDATA=>UIImage
    UIImage *img=[UIImage imageWithData:data];
    //4.刷新ui
    if ([NSThread currentThread].isMainThread) {
        imgView.image=img;
    }else{
        __weak UIImageView *tempImgView=imgView;
        dispatch_async(dispatch_get_main_queue(), ^{
            tempImgView.image=img;
        });
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
