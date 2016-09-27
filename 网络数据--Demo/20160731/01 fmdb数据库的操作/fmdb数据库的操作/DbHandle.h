//
//  DbHandle.h
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "QYStudent.h"
#define BaseFileName @"Student.db"
@interface DbHandle : NSObject
@property(nonatomic,strong) NSString *DbPath;//数据库文件的路径

@property(nonatomic,strong) FMDatabase *base;//sqlite数据库文件操作的对象
//单例
+(instancetype) shareInstance;
-(BOOL) insertIntoStudent:(QYStudent *) student;
//向student 更新指定记录
-(void) update:(QYStudent *) student;
//删除指定记录
-(void) delete:(NSString *) strName;
//查询指定记录
-(NSMutableArray *) queryBy:(NSString *) strId;
//查询所有记录
-(NSMutableArray *) query;

@end
