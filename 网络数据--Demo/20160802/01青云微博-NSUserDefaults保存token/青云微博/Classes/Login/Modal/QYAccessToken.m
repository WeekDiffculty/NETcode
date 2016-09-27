//
//  QYAccessToken.m
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYAccessToken.h"
/*
 *access_token;
 @property(nonatomic,strong) NSString *expires_in;
 @property(nonatomic,strong) NSString *remind_in;
 @property(nonatomic,assign) NSInteger uid;
 */
#define EXPIRES_IN @"expires_in"
#define ACCESS_TOKEN @"access_token"
#define REMIND_IN @"remind_in"
#define UID @"uid"
@implementation QYAccessToken
+(instancetype) shareInstance{
    static QYAccessToken *token;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       token=[[self alloc] init];
    });
    return token;
}
//token值的保存
-(void) saveToken{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.access_token forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:self.expires_in forKey: EXPIRES_IN];
    [[NSUserDefaults standardUserDefaults] setObject:self.remind_in forKey:REMIND_IN];
    [[NSUserDefaults standardUserDefaults] setInteger:self.uid forKey:UID];
//    //读取
//   NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
//    NSLog(@"%@",strToken);
}
//懒加载 读取的操作
//-(NSString *) access_token{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
//}
-(void) readToken{
    self.access_token=[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
}

@end
