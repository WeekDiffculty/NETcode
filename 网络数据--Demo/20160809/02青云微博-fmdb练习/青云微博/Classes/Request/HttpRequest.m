//
//  HttpRequest.m
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
//单例的作用:在应用程序运行期间,只生成一个对象,用来在内存当中保存数据或者调用指定的方法
+(instancetype) sharedInstance{
    static HttpRequest *httpRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequest=[[self alloc] init];
    });
    return httpRequest;
}
//在方法中的2个参数定义2个block块 success failure 进行传值
-(void) Post:(NSString *) strURL Param:(NSDictionary *) dParamDict success:(void(^)(NSDictionary *dict)) success failure:(void(^)(NSError *)) failure{
    //创建manager 对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //2.1设置响应的接收类型
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    [manager POST:strURL parameters:dParamDict progress:^(NSProgress *downloadProgress){
    
    } success:^(NSURLSessionTask *task,id responseObject){
        //网络请求成功时调用的block块
        NSLog(@"网络请求成功的方法2");
        success(responseObject);
    } failure:^(NSURLSessionTask *task,NSError *error){
        //网络失败时调用的block块
        failure(error);
    }];
    NSLog(@"对象的方法1");
    
    
}
-(void) Get:(NSString *) strURL Param:(NSDictionary *) dParamDict success:(void(^)(NSDictionary *dict)) success failure:(void(^)(NSError *)) failure{
    //创建manager 对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //2.1设置响应的接收类型
    //manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    [manager GET:strURL parameters:dParamDict progress:^(NSProgress *downloadProgress){
        
    } success:^(NSURLSessionTask *task,id responseObject){
        //网络请求成功时调用的block块
        NSLog(@"网络请求成功的方法2");
        success(responseObject);
    } failure:^(NSURLSessionTask *task,NSError *error){
        //网络失败时调用的block块
        failure(error);
    }];
    NSLog(@"对象的方法1");
}
@end
