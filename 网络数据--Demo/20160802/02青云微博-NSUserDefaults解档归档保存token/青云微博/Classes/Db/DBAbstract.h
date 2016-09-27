//
//  DBAbstract.h
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "DbCommon.h"
@interface DBAbstract : NSObject
@property(nonatomic,strong) NSString *dbPath;//数据库文件路径
@property(nonatomic,strong) FMDatabaseQueue *queue;//数据库操作的对象-队列
@end
