//
//  ThirdViewController.m
//  3 DeownloadDataTaskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ThirdViewController.h"
#define IMG_URL @"http://img.warting.com/allimg/2016/0315/vcirw2ma1lb-1781.jpg"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)DownloadBtn:(id)sender{
     //1.URL对象
    NSURL *url=[NSURL URLWithString:IMG_URL];
    //2.创建会话对象
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //3.创建下载任务
    if(resumeData==nil){
        //首次或者重新下载
        task=[session downloadTaskWithURL:url];
    }else{
        //暂停后继续下载
        task=[session downloadTaskWithResumeData:resumeData];
    }
    //任务启动
    [task resume];
}
//暂停按钮
-(IBAction)PauseBtn:(id)sender{
    //暂停任务
    [task cancelByProducingResumeData:^(NSData *data){
        resumeData=data;
        //暂停时清空任务
        task=nil;
    }];
}
//文件下载结束后调用的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    imgFileUrl=location;
    //1.location=>NSData
    NSData *data=[NSData dataWithContentsOfURL:location];
    //2. data=>UIImage
    UIImage *imge=[UIImage imageWithData:data];
    //3.更新UI,通过主线程
    __weak UIImageView *tempImgView=imgView;
    __weak UIProgressView *tempProView=progressView;

    dispatch_async(dispatch_get_main_queue(), ^{
        tempImgView.image=imge;
        tempProView.hidden=YES;
    });

}
//当前文件下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //计算当前文件下载的进度
    float fProgress=(double)totalBytesWritten/(double)totalBytesExpectedToWrite;
    //更新进度条
    __weak UIImageView *tempImgView=imgView;
    NSData *data=[NSData dataWithContentsOfURL:imgFileUrl];
    UIImage *imge=[UIImage imageWithData:data];

    __weak UIProgressView *tempProView=progressView;
    dispatch_async(dispatch_get_main_queue(), ^{
        tempProView.progress=fProgress;
        //tempImgView.image=imge;
    });
}
//文件暂停调用的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
