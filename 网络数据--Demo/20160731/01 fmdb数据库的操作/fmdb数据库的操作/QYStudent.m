//
//  QYStudent.m
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYStudent.h"

@implementation QYStudent
+(instancetype) modeWithDic:(NSDictionary *) dic{
    QYStudent *student=[[QYStudent alloc] init];
    [student setValuesForKeysWithDictionary:dic];
    return student;
}
-(void) setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"未定义属性%@",key);
}
@end
