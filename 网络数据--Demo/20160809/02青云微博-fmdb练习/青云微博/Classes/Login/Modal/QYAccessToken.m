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
        //单例的对象只初始化一次的时候,getModeFromPath进行解档的操作
        token=[QYAccessToken getModeFromPath];
        if(!token){
            token=[[self alloc] init];
        }
        
    });
    return token;
}
//方式一.nsuserdefaults
////token值的保存
//-(void) saveToken{
//    
//    [[NSUserDefaults standardUserDefaults] setObject:self.access_token forKey:ACCESS_TOKEN];
//    [[NSUserDefaults standardUserDefaults] setObject:self.expires_in forKey: EXPIRES_IN];
//    [[NSUserDefaults standardUserDefaults] setObject:self.remind_in forKey:REMIND_IN];
//    [[NSUserDefaults standardUserDefaults] setInteger:self.uid forKey:UID];
////    //读取
////   NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
////    NSLog(@"%@",strToken);
//}
////懒加载 读取的操作
////-(NSString *) access_token{
////    return [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
////}
//-(void) readToken{
//    self.access_token=[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
//}
/*
    NSCoding 协议
 */
//解档的方法 从aDecoder读取数据,保存到相应的属性或者变量当中,就是反序列化数据
-(instancetype) initWithCoder:(NSCoder *) aDecoder{
    if (self=[super init]) {
        _access_token=[aDecoder decodeObjectForKey:ACCESS_TOKEN];
        _expires_in=[aDecoder decodeObjectForKey:EXPIRES_IN];
        _uid=(NSInteger)[aDecoder decodeObjectForKey:UID];
        _remind_in=[aDecoder decodeObjectForKey:REMIND_IN];
    }
    return self;
}
//归档的方法 读取实例变量 就是对象中属性的值,,并且把这些值保存到coder中,就是序列化数据
-(void) encodeWithCoder:(NSCoder *) aCoder{
    //NSCoder
    [aCoder encodeObject:_access_token forKey:ACCESS_TOKEN];
    [aCoder encodeObject:_remind_in forKey:REMIND_IN];
    [aCoder encodeInt:(int)_uid forKey:UID];
    [aCoder encodeObject:_expires_in forKey:EXPIRES_IN];
    
}
//将数据模型保存至沙盒当中
-(BOOL) presistenceData{
    //序列化 模型转换成文件 自动调用归档的方法 encodeWithCoder
    return [NSKeyedArchiver archiveRootObject:self toFile:[QYAccessToken getFilePath]];
}
//读取沙盒当中的文件,转换至模型
+(QYAccessToken *) getModeFromPath{
    //反序列化
    QYAccessToken *token=[NSKeyedUnarchiver unarchiveObjectWithFile:[QYAccessToken getFilePath]];
    return token;
}
//获取文件要保存的路径
+(NSString *) getFilePath{
    //1.获取沙盒目录
    NSString *strDocPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
   // NSLog(@"%@",strDocPath);
    //2.合并路径
    return [strDocPath stringByAppendingPathComponent:@"accesstoken"];
}
@end
