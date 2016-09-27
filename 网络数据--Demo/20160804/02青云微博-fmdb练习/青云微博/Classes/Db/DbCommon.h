//
//  DbCommon.h
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
//创建表
#define CreateTable @"CREATE TABLE if not exists WBHome (idstr text,created_at text,\"Text\" text,Source text,favorited integer,user blob,retweetedStatus blob,repostsCount integer,commentsCount integer,attitudesCount integer,PicUrls blob)"
//向WbHome表中插入一条记录
#define Insert_Home_Sql @"insert into WBHome  values(:idstr,:CreatedAt,:Text,:Source,:favorited,:user,:retweetedStatus,:repostsCount,:commentsCount,:attitudesCount,:PicUrls)"
//查询微博表中所有的记录
#define Query_Home_Sql @"SELECT * FROM WBHome;"
#define Delete_Home_Sql @"delete FROM WBHome;"
#define BaseFileName @"Weibo.sqlite"
@interface DbCommon : NSObject

@end
