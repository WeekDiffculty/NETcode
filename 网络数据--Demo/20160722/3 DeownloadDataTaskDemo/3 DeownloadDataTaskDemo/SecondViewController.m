//
//  SecondViewController.m
//  3 DeownloadDataTaskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SecondViewController.h"
#define IMG_URL @"http://img.warting.com/allimg/2016/0315/vcirw2ma1lb-1781.jpg"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)DownloadBtn:(id)sender{
    //1.创建URL
    NSURL *url=[NSURL URLWithString:IMG_URL];
    //2.创建session对象
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //3.创建下载任务对象
    NSURLSessionDownloadTask *task=[session downloadTaskWithURL:url];
    //4.启动
    [task resume];
}
#pragma mark NSURLSessionDownloadDelegate
//文件下载结束时调用此方法
-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"文件临时保存的位置:%@",location.absoluteString);
    NSData *data=[[NSData alloc] initWithContentsOfURL:location];
    UIImage *image=[UIImage imageWithData:data];
    //更新ui
    __weak UIImageView *tempImge=imgView;
    dispatch_async(dispatch_get_main_queue(), ^{
        tempImge.image=image;
        imgView.image = image;
    });
    
}
//获取当前文件正在下载的进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
 //计算当前文件下载的进度
    float fProgress=(double)totalBytesWritten/(double)totalBytesExpectedToWrite;
    NSLog(@"当前下载进度%f",fProgress);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    NSLog(@"123");
}
@end
