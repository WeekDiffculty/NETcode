//
//  QYRequestManager.m
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYRequestManager.h"
#import "ConfigFile.h"
#import "QYAccessToken.h"
#import "QYStatusModel.h"
@implementation QYRequestManager
+(instancetype) shareInstance{
    static QYRequestManager *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request=[[self alloc] init];
    });
    return request;
}
-(void) request_token:(NSString *) strCode  success:(void(^)(QYAccessToken *)) success failure:(void(^)(NSError *)) failure{
    //调用httpRequest对象中的 post方法 这种调用的方式是单例的调用方式
//    HttpRequest *httpRequest=[HttpRequest sharedInstance];
//    httpRequest Post:<#(NSString *)#> Param:<#(NSDictionary *)#>
    NSDictionary *dDict=@{@"client_id":APPKEY,@"client_secret":APPSECRET,@"grant_type":@"authorization_code",@"code":strCode,@"redirect_uri":DIRPATH};
    
    NSString *url=[BASEURL stringByAppendingPathComponent:ACCESSTOKEN];
    
    [[HttpRequest sharedInstance] Post:url Param:dDict success:^(NSDictionary *dict){
        //sucecess(dict);
        NSLog(@"%@",dict);
        //解析json数据
        QYAccessToken *token=[[QYAccessToken alloc] init];
        [token setValuesForKeysWithDictionary:dict];
        success(token);
        
    } failure:^(NSError *error){
        NSLog(@"网络请求错误%@",error);
        failure(error);
    }];
}

//请求微博主页列表的信息
-(void) request_HomeList:(NSString *) strAccessToken sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure{
    //stringByAppendingPathComponent:
    NSString *strUrl=[NSString stringWithFormat:@"%@?access_token=%@&page=1",[BASEURL stringByAppendingPathComponent:HOMELIST],strAccessToken];
    NSLog(@"%@",strUrl);
    [[HttpRequest sharedInstance] Get:strUrl Param:nil success:^(NSDictionary * dict){
        NSLog(@"%@",dict);
        //解析json数据
        NSMutableArray *mArr=[NSMutableArray new];
        NSMutableArray *mStatuses=[dict objectForKey:@"statuses"];
        for (NSUInteger index = 0; index < mStatuses.count; index ++) {
            NSDictionary *dStatus=[mStatuses objectAtIndex:index];
            QYStatusModel *sModel=[QYStatusModel statusModelWithDictionary:dStatus];
            [mArr addObject:sModel];
        }
       success(mArr);
    }
    failure:^(NSError *error){
        NSLog(@"网络请求错误%@",error);
        failure(error);
    }];
}

/*
 转发微博方法
    strToken accessToken值
    status  每条微博对应对象
    success 网络请求成功时调用 block方法返回视图控制器
    failure 网络请求失败时调用block方法返回视图控制器
 
 */
-(void) repostMessage:(NSString *) strToken Status:(QYStatusModel *) status sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure{
    NSDictionary *pars=@{@"access_token":strToken,@"id":status.strIdstr};
    [[AFHTTPSessionManager manager] POST:[BASEURL stringByAppendingPathComponent:REPOSTMESSAGE] parameters:pars progress:^(NSProgress *uploadProgress){} success:^(NSURLSessionDataTask *task,id responseObject){//成功
        //服务器返回的数据
        NSLog(@"%@",responseObject);
        //json的数据解析
        //转发微博接口返回的json数据不需要解析
        success(nil);
    } failure:^(NSURLSessionDataTask *task,NSError *error){//失败
        NSLog(@"请求失败%@",error);
    }];

}
/*
    发微博
    strToken accessToken值
    strContent 发微博的内容
 */
-(void) addMessage:(NSString *) strToken Content:(NSString *) strContent sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure{
    NSDictionary *dict=@{@"access_token":strToken,@"status":strContent};
//    [[HttpRequest sharedInstance] Post:[BASEURL stringByAppendingPathComponent:ADDMESSAGE] Param:dict success:^(NSDictionary *dict){
//        success(nil);
//    } failure:^(NSError *err){
//        NSLog(@"请求失败%@",err);
//        failure(err);
//    }];
    //设置接收微博数据序列化 它的歌声
    [AFHTTPSessionManager manager].responseSerializer=[AFJSONResponseSerializer serializer];
    [AFHTTPSessionManager manager].responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/JavaScript",@"text/html",@"text/plain", nil];
    [[AFHTTPSessionManager manager] POST:[BASEURL stringByAppendingPathComponent:ADDMESSAGE] parameters:dict progress:^(NSProgress *progress){} success:^(NSURLSessionDataTask *task,id response){
        success(nil);
    } failure:^(NSURLSessionDataTask *task,NSError *err){
        NSLog(@"请求失败%@",err);
        failure(err);
    }];
}
@end
