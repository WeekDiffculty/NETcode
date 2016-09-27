//
//  ViewController.m
//  02NSURLSessionDataTaskPOST
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#define BaseURL @"http://afnetworking.sinaapp.com/request_post_body_http.json"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)PostBtn:(id)sender{
    //1.创建URL对象
    NSURL *url=[NSURL URLWithString:BaseURL];
    //2.创建数据请求对象
    NSMutableURLRequest *request=[ NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod=@"POST";
    //2.2 设置请求体 客户端向服务器提交的数据
    NSString *bodyStr=@"foo=bar";
    request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    //4.创建NSURLSessionDataTask对象
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if (error) {
            NSLog(@"网络出现错误%@",error);
        }
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
            //
            NSLog(@"post提交成功");
            //1.解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            //2.通过主线程的方式刷新UI
            //GCD的方式 异步刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新ui
                
            });
            
        }
    }];
    //5.请求
    [task resume];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
