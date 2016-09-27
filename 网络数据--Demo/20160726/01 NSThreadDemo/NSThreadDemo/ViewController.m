//
//  ViewController.m
//  NSThreadDemo
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#define BD_Logo_Url @"http://www.4k123.com/data/attachment/forum/201402/10/011607sgwbg81m1ussrogn.jpg"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSURL *url=[NSURL URLWithString:BD_Logo_Url];
//    //2.下载图片文件
//    NSData *data=[NSData dataWithContentsOfURL:url];
//    //3.刷新UI
//    UIImage *image=[UIImage imageWithData:data];
//    _imgView.image=image;
//    NSLog(@"图片下载完毕");
}
-(IBAction) donwloadImageBtn:(id) sender{
    //判断主线程
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"downloadImageBtn 是主线程");
    }
    [NSThread detachNewThreadSelector:@selector(downloadThread) toTarget:self withObject:nil];
    NSLog(@"图片下载完毕");
}
//线程方法:下载图片的功能
-(void) downloadThread{
    NSLog(@"正在下载图片");
    //判断主线程
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"downloadThread 是主线程");
    }
    //1.NSURL
    NSURL *url=[NSURL URLWithString:BD_Logo_Url];
    //2.下载图片文件
    NSData *data=[NSData dataWithContentsOfURL:url];
    //3.刷新UI
    UIImage *image=[UIImage imageWithData:data];
  //方式1  dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
    //方式2.
    [self performSelectorOnMainThread:@selector(updateUITread:) withObject:image waitUntilDone:YES];
}
//刷新ui控件
-(void) updateUITread:(UIImage *) image{
    _imgView.image=image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
