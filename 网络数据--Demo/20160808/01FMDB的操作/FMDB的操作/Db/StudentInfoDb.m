//
//  StudentInfoDb.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "StudentInfoDb.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@implementation StudentInfoDb
//单例的对象
+(id) shareInstance{
    static StudentInfoDb *shanredInstance=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shanredInstance=[[self alloc] init];
    });
    return shanredInstance;
}
-(id) init{
    if (self=[super init]) {
        [self initDb];
    }
    return self;
}
//初始化数据库
-(void) initDb{
    self.queue=[FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    [self.queue inDatabase:^(FMDatabase *db){
        //创建表
        NSString *sql=@"CREATE TABLE if not exists studentInfo (Id integer PRIMARY KEY,Name text,Age text,Phone text,FamilyAddress text)";
        if ([db executeUpdate:sql]) {
            NSLog(@"初始化数据库成功");
        }else{
            NSLog(@"初始化数据库失败");
        }
    }];
}
//向表中插入记录
-(void) Insert:(StudentModal *) student{
    NSString *strSql=[NSString stringWithFormat:@"insert into studentInfo(Id,Name,Age,Phone,FamilyAddress) values(%ld,\"%@\",\"%@\",\"%@\",\"%@\")",student.Id,student.Name,student.Age,student.Phone,student.FamilyAddress];
    [self.queue inDatabase:^(FMDatabase *db){
        if ([db executeUpdate:strSql]) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
    }];
}
//删除指定记录的方法
-(void) Delete:(NSInteger) nId{
    NSString *strSql=[NSString stringWithFormat:@"delete from studentInfo where Id=%ld",nId];
    [self.queue inDatabase:^(FMDatabase *db){
        if ([db executeUpdate:strSql]) {
            NSLog(@"删除成功");
        }
    }];
    
}
//更新
-(void) Update:(NSInteger) nId Info:(StudentModal *) sModal{
    NSString *strSql=[NSString stringWithFormat:@"update studentInfo set Phone=\"%@\",Age=\"%@\",FamilyAddress=\"%@\" where Id=%ld ",sModal.Phone,sModal.Age,sModal.FamilyAddress,nId];
    [self.queue inDatabase:^(FMDatabase *db){
        if ([db executeUpdate:strSql]) {
            NSLog(@"更新成功");
        }
    }];
}
//查询所有记录
-(NSMutableArray *) Query{
    NSMutableArray *mArr=[NSMutableArray array];
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    //打开数据库
    if ([db open]) {
        NSString *strSql=@"SELECT * FROM studentInfo;";
       FMResultSet *rs =[db executeQuery:strSql];
        while ([rs next]) {
            //方式1.手动的方式根据字段名解析记录中指定字段
//            StudentModal *sModal=[[StudentModal alloc] init];
//            sModal.Id=[rs intForColumn:@"Id"];
//            sModal.Name=[rs stringForColumn:@"Name"];
//            sModal.Age=[rs stringForColumn:@"Age"];
//            sModal.Phone=[rs stringForColumn:@"Phone"];
//            sModal.FamilyAddress=[rs stringForColumn:@"FamilyAddress"];
//            [mArr addObject:sModal];
            //2.kvc的方式 字典=>模型
            NSDictionary *dict=[rs resultDictionary];
            StudentModal *sModal=[[StudentModal alloc] init];
            [sModal setValuesForKeysWithDictionary:dict];
            [mArr addObject:sModal];
        }
    }
    //关闭数据库
    [db close];
    
    return mArr;
}
//事务的方式实现批量插入
-(void)InsertRecords:(NSMutableArray *) mArr{
    [self.queue inDatabase:^(FMDatabase *db){
        NSLog(@"开始插入");
        //开始事务
        [db beginTransaction];
        for (NSUInteger index = 0; index < mArr.count; index ++) {
            StudentModal *student=[mArr objectAtIndex:index];
            NSString *strSql=[NSString stringWithFormat:@"insert into studentInfo(Id,Name,Age,Phone,FamilyAddress) values(%ld,\"%@\",\"%@\",\"%@\",\"%@\")",student.Id,student.Name,student.Age,student.Phone,student.FamilyAddress];
            if (![db executeUpdate:strSql]) {
                NSLog(@"插入失败");
            }
            
        }
        //结束事务
        [db commit];
        NSLog(@"插入结束");
    }];
}
@end
