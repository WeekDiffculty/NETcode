//
//  QYRequestManager.h
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//
//QQ:369919131
#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "QYAccessToken.h"
@interface QYRequestManager : NSObject
+(instancetype) shareInstance;
//向微博获取accessToken值
-(void) request_token:(NSString *) strCode  success:(void(^)(QYAccessToken *)) success failure:(void(^)(NSError *)) failure;
//请求微博主页列表的信息
-(void) request_HomeList:(NSString *) strAccessToken sucess:(void(^)(NSMutableArray *arrList)) success failure:(void(^)(NSError *error)) failure;
@end
