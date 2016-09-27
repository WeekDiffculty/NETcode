//
//  StudentInfoDb.h
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "AbstractDb.h"
#import "StudentModal.h"

#define DB_FileName @"student.sqlite"

@interface StudentInfoDb : AbstractDb
//单例的对象
+(id) shareInstance;
//向表中插入记录
-(void) Insert:(StudentModal *) student;
//删除指定记录的方法
-(void) Delete:(NSInteger) nId;
//更新
-(void) Update:(NSInteger) nId Info:(StudentModal *) sModal;
//查询所有记录
-(NSMutableArray *) Query;
//批量插入
-(void)InsertRecords:(NSMutableArray *) mArr;
@end
