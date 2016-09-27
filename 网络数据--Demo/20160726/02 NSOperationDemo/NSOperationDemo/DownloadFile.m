//
//  DownloadFile.m
//  NSOperationDemo
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DownloadFile.h"

@implementation DownloadFile
//初始化方法:实现下载的功能
-(instancetype) initWithDownloadUrl:(NSString *)url{
    if (self=[super init]) {
        //初始化一个url对象
        download_URL=[NSURL URLWithString:url];
    }
    return self;
}
-(void) main{
    //此方法会调用一次,是在该对象,该任务添加到队列的时候就会调用
    NSLog(@"%s",__func__);
    //下载的功能
    [self downloadImage];
}
-(void) downloadImage{
    //1.网络请求
    NSData *data=[NSData dataWithContentsOfURL:download_URL];
    //2.nsdata=>UIImage
    UIImage *image=[UIImage imageWithData:data];
    //3.通过block块传值,传到ViewController中
    _block(image);
    
}
@end
