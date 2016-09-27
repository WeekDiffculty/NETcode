//
//  AbstractDb.h
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#define DB_FileName @"student.sqlite"
@interface AbstractDb : NSObject
@property(nonatomic,strong) NSString *dbPath;//数据库文件路径
@property(nonatomic,strong) FMDatabaseQueue *queue;//数据库操作队列
-(id) init;
@end
