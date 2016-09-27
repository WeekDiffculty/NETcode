//
//  QYAccessToken.m
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYAccessToken.h"

@implementation QYAccessToken
+(instancetype) shareInstance{
    static QYAccessToken *token;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       token=[[self alloc] init];
    });
    return token;
}

@end
