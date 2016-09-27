//
//  ViewController.m
//  NSURLSessionDatataskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
//#define BDURL @"http://www.baidu.com/?参数1=值1&参数2=值2"
#define BD_ImgURL @"https://www.baidu.com/img/bd_logo1.png"
#define BDURL @"http://afnetworking.sinaapp.com/request_post_body_http.json?foo=bar"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//向百度请求数据
-(IBAction)requestBD:(id)sender{
    [self requestServer];
}
-(void) requestServer{
//    //1.创建url地址
//    NSURL *url=[NSURL URLWithString:BDURL];
//    //2.创建nsurlrequest对象
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    //3.创建会话的对象
//    NSURLSession * session=[NSURLSession sharedSession];
//    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
//        if(error){
//            NSLog(@"error %@",error);
//        }
//        //判断状态响应码
//        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
//        if(httpresponse.statusCode==200){
//            //请求成功,解析数据
//            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",str);
//        }
//        
//    }];
//    //4.启动请求
//    [task resume];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{};
    
    [manager GET:@"" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(IBAction)DownloadImgBtn:(id)sender{
    //1.创建url对象
    NSURL *url=[NSURL URLWithString:BD_ImgURL];
    //2.创建一个会话的对象
    NSURLSession *session=[NSURLSession sharedSession];
    //3.向服务器请求加载
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        //3.1判断数据获取是否成功
        if(error){
            NSLog(@"网络请求错误%@",error);
            return ;
        }
        //判断状态响应码
        __weak UIImageView *temp=imgView;
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200)
        {
            //3.2解析数据
            UIImage *img=[UIImage imageWithData:data];
            //3.3刷新ui,调用主线程处理
            //GCD的方式 异步刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                temp.image=img;
            });
            
        }
    }];
    //4.启动请求
    [task resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
