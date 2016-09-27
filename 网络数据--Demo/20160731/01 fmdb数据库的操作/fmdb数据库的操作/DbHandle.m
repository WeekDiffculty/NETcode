//
//  DbHandle.m
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DbHandle.h"
#import "QYStudent.h"
@implementation DbHandle
//单例
+(instancetype) shareInstance{
    static DbHandle *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[DbHandle alloc] init];
        [instance initDb];
    });
    return instance;
}

//初始化数据库
-(BOOL) initDb{
    //生成一个fmdb对象
    
    self.base=[FMDatabase databaseWithPath:self.DbPath];
    if (![self.base open]) {
        NSLog(@"数据库文件打开失败%@",[_base lastErrorMessage]);
    }
    //判断此表是否存在,如果不存在就创建
    NSString *sql=@"CREATE TABLE if not exists students (Id text PRIMARY KEY,name text,age integer,phone text,icon blob)";
    //执行创建表的操作
    BOOL result=[_base executeUpdate:sql];
    if (!result) {
        NSLog(@"创建表失败%@",[_base lastErrorMessage]);
        
    }
    return result;
}
//懒加载 生成一个数据库文件所在的路径
-(NSString *) DbPath{
   NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir=[paths objectAtIndex:0];
    NSLog(@"%@",docDir);
    //拼接成数据库文件的路径
    return [docDir stringByAppendingPathComponent:BaseFileName];
}
//向students插入记录
-(BOOL) insertIntoStudent:(QYStudent *) student{
    //1.编写sql语句
    //方式1:通过问号的形式 插入数据,适合插入blob字段使用或特殊字符
    NSString *sql=@"insert into students(Id,name,age,phone,icon) values(?,?,?,?,?)";
//    //方式2:字符拼接的方式
//    NSString *sql1=[NSString stringWithFormat: @"insert into students(Id,name,age,phone) values(\'%@\',\'%@\',%ld,\'%@\')",student.Id,student.name,student.age,student.phone];
//    [self.base executeUpdate:sql1];
    //2. 执行sql语句
    BOOL result=[self.base executeUpdate:sql,student.Id,student.name,@(student.age),student.phone,student.icon];
    if (!result) {
        NSLog(@"插入失败%@",[_base lastErrorMessage]);
    }
    return result;
}
//向student 更新指定记录
-(void) update:(QYStudent *) student{
    //1.编写sql语句
    //除了头像 id 之外的字段更新数据
    //方式一:传参数的形式
    NSString *sql=@"update students set name=:name,age=:age,phone=:phone where Id=:Id";
//    //方式二:字符拼接的方式
//    NSString *sql1=[NSString stringWithFormat: @"update students set name=\'%@\' where Id=\'%@\'",student.name,student.Id];
//    [self.base executeUpdate:sql1];
    BOOL result=[self.base executeUpdate:sql,student.name,@(student.age),student.phone,student.Id];
    if (!result) {
        NSLog(@"更新失败%@",[_base lastErrorMessage]);
    }
}
//删除指定记录
-(void) delete:(NSString *) strName{
    //1.编写sql语句
    NSString *sql=[NSString stringWithFormat:@"delete from students where name=\'%@\'",strName];
    //2.执行sql
    [self.base executeUpdate:sql];
}
//查询指定记录
-(NSMutableArray *) queryBy:(NSString *) strId{
    //1.sql语句
    NSString *sql=[NSString stringWithFormat:@"select * from students where Id=\'%@\'",strId];
    //2.执行查询
   FMResultSet *set =[self.base executeQuery:sql];
    NSMutableArray *dataArr=[NSMutableArray array];
    //对结果遍历,取出数据
    while ([set next]) {
        QYStudent *student=[self modeFrom:set];
        [dataArr addObject:student];
    }
    return dataArr;
}
//查询所有记录
-(NSMutableArray *) query{
    //1.sql语句
    NSString *sql=@"select * from students";
    //2.执行查询
    FMResultSet *set=[self.base executeQuery:sql];
    //3.查询的结果遍历,取出数据
    NSMutableArray *dataArr=[NSMutableArray array];
    while ([set next]) {
        QYStudent *student=[self extractModeFrom:set];
        [dataArr addObject:student];
    }
    return dataArr;
}
//方式1:
//把FMResultSet 获取的值以kvc的方式赋值
-(QYStudent *) modeFrom:(FMResultSet *) set{
    //1.set 把结果转换成字典
    NSMutableDictionary *dic=(NSMutableDictionary *)[set resultDictionary];
    //2.通过kvc的方式 字典转换实体model
    QYStudent *mode=[QYStudent modeWithDic:dic];
    return mode;
}
//方式2:
//按指定字段名提取
-(QYStudent *) extractModeFrom:(FMResultSet *) set{
    QYStudent *student=[[QYStudent alloc] init];
    student.Id=[set stringForColumn:@"Id"];
    student.name=[set stringForColumn:@"name"];
    student.age=[set intForColumn:@"age"];
    student.phone=[set stringForColumn:@"phone"];
    student.icon=[set dataForColumn:@"icon"];
    return student;
}

@end
