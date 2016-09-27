//
//  StudatusDb.m
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "StudatusDb.h"

@implementation StudatusDb
//单例
+(id) shareIntance{
    static DBAbstract *sharedInstance=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance=[[self alloc] init];
    });
    return sharedInstance;
}
-(id) init{
    if (self=[super init]) {
        [self initDb];
    }
    return self;
}
//初始化数据库 创建表
-(void) initDb{
    NSLog(@"%@",self.dbPath);
    self.queue=[FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    [self.queue inDatabase:^(FMDatabase *db){
        BOOL res=[db executeStatements:CreateTable];
        if (!res) {
            NSLog(@"创建表失败");
        }else{
            NSLog(@"创建表成功");
        }
    }];
}
//给表添加记录
-(void) Insert:(QYStatusModel *) status{
    //序列化的方式archivedDataWithRootObject 需要自动调用该对象中nscoding协议中的encoder 进行归档
    NSData *userData=[NSKeyedArchiver archivedDataWithRootObject:status.user];
    NSData *retweetData=[NSKeyedArchiver archivedDataWithRootObject:status.retweetedStatus];
    NSData *picUrlsData= [NSKeyedArchiver archivedDataWithRootObject:status.arrPicUrls];
    NSDictionary *dict=@{@"idstr":status.strIdstr,
                         @"created_at":status.strCreatedAt,
                         @"text":status.strText,
                         @"source":status.strSource,
                         @"favorited":[NSNumber numberWithBool:status.favorited],
                         @"user":userData?:[NSNull null],
                         @"retweeted_status":retweetData?:[NSNull null],
                         @"reposts_count":[NSNumber numberWithInteger: status.repostsCount],
                         @"comments_count":[NSNumber numberWithInteger:status.commentsCount],
                         @"attitudes_count":[NSNumber numberWithInteger:status.attitudesCount],
                         @"pic_urls":picUrlsData?:[NSNull null]
                         };
 
    [self.queue inDatabase:^(FMDatabase *db){
        if ([db executeUpdate:Insert_Home_Sql withParameterDictionary:dict]) {
            NSLog(@"数据插入成功");
        }else{
            NSLog(@"数据插入失败 %@",[db lastErrorMessage]);
        }
    }];
        
}
//插入微博记录之前,要把之前插入的数据删掉
-(void) InsertStatues:(NSMutableArray *) arr{
    [self delete];
    for (NSUInteger index = 0; index < arr.count; index ++) {
        QYStatusModel *status=[arr objectAtIndex:index];
        [self Insert:status];
    }
}
//查询微博主页数据
-(NSMutableArray *) Query{
    NSMutableArray *mArr=[[NSMutableArray alloc] init];
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet *rs=[db executeQuery:Query_Home_Sql];
        while ([rs next]) {
            //@"CREATE TABLE if not exists WBHome (idstr text,created_at text,\"Text\" text,Source text,favorited integer,user blob,retweetedStatus blob,repostsCount integer,commentsCount integer,attitudesCount integer,PicUrls blob)"
//            //方式一:通过手动解析指定的字段
//            QYStatusModel *qStatus=[[QYStatusModel alloc] init];
//            qStatus.strIdstr=[rs stringForColumn:@"idStr"];
//            qStatus.strCreatedAt=[rs stringForColumn:@"created_at"];
//            qStatus.strText=[rs stringForColumn:@"text"];
//            qStatus.strSource=[rs stringForColumn:@"Source"];
//            qStatus.favorited=[rs boolForColumn:@"favorited"];
//            cr=[NSKeyedUnarchiver unarchiveObjectWithData:usrData];
//            NSData *retData=[rs objectForColumnName:@"retweetedStatus"];
//            qStatus.retweetedStatus=[NSKeyedUnarchiver unarchiveObjectWithData:retData];
//            qStatus.repostsCount=[rs intForColumn:@"repostsCount"];
//            qStatus.commentsCount=[rs intForColumn:@"commentsCount"];
//            qStatus.attitudesCount=[rs intForColumn:@"attitudesCount"];
//            
//            //反序列化的操作
//            NSData *retPicUrls=[rs objectForColumnName:@"PicUrls"];
//            qStatus.arrPicUrls=[NSKeyedUnarchiver unarchiveObjectWithData:retPicUrls];
//            [mArr addObject:qStatus];
            //方式二:KVC 练习  从记录中以字典的形式传入到模型中
            NSMutableDictionary *dict =(NSMutableDictionary *)[rs resultDictionary];
            //NSData *data=dict[@"user"];
            NSData *usrdata=dict[@"user"];
            NSData *retweetdata=dict[@"retweeted_status"];
            NSData *picdata=dict[@"pic_urls"];
            dict[@"user"]=[NSNull null];
            dict[@"retweeted_status"]=[NSNull null];
            dict[@"pic_urls"]=[NSNull null];
            QYStatusModel *qStatus=[QYStatusModel statusModelWithDictionary:dict];
            qStatus.user=[NSKeyedUnarchiver unarchiveObjectWithData:usrdata];
            qStatus.retweetedStatus=[NSKeyedUnarchiver unarchiveObjectWithData:retweetdata];
            qStatus.arrPicUrls=[NSKeyedUnarchiver unarchiveObjectWithData:picdata];
            [mArr addObject:qStatus];
        }
    }
    //关闭数据库
    [db close];
    return mArr;
}
-(void) delete{
//    //FMDatabaseQueue 异步的方式
//    [self.queue inDatabase:^(FMDatabase *db){
//        if ([db executeQuery:Delete_Home_Sql]) {
//            NSLog(@"删除成功");
//        }
//    }];
    //同步的方式
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        [db executeUpdate:Delete_Home_Sql];
    }
    [db close];
}
@end
