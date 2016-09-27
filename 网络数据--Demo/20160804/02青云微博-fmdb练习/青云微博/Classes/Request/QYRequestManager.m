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
@end
