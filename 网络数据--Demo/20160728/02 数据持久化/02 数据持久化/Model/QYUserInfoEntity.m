//
//  QYUserInfoEntity.m
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYUserInfoEntity.h"
//用户名
#define UserName @"username"
#define Pwd @"pwd"
@implementation QYUserInfoEntity
/*
    归档的操作 将内存当中的实体对象转换成NSData数据类型
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userName forKey:UserName];
    [aCoder encodeObject:_pwd forKey:Pwd];
}
/*
    解档的操作 将NSData数据转换成内存中实体的对象
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    _userName=[aDecoder decodeObjectForKey:UserName];
    _pwd=[aDecoder decodeObjectForKey:Pwd];
    return self;
}
@end
