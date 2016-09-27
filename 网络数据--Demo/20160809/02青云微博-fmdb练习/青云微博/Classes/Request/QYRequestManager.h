//
//  QYRequestManager.h
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//
//QQ:369919131

//接口方法的封装类
#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "QYAccessToken.h"
#import "QYStatusModel.h"
@interface QYRequestManager : NSObject
+(instancetype) shareInstance;
//向微博获取accessToken值
-(void) request_token:(NSString *) strCode  success:(void(^)(QYAccessToken *)) success failure:(void(^)(NSError *)) failure;
//请求微博主页列表的信息
-(void) request_HomeList:(NSString *) strAccessToken sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure;
//转发微博的方法
-(void) repostMessage:(NSString *) strToken Status:(QYStatusModel *) status sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure;
//发微博的方法
-(void) addMessage:(NSString *) strToken Content:(NSString *) strContent sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure;
@end
