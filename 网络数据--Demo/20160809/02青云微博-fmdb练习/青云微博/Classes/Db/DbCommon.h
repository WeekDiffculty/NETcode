//
//  DbCommon.h
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
//创建表
#define CreateTable @"CREATE TABLE if not exists WBHome (idstr text,created_at text,\"text\" text,source text,favorited integer,user blob,retweeted_status blob,reposts_count integer,comments_count integer,attitudes_count integer,pic_urls blob)"
//向WbHome表中插入一条记录
//#define Insert_Home_Sql @"insert into WBHome  values(:idstr,:CreatedAt,:Text,:Source,:favorited,:user,:retweetedStatus,:repostsCount,:commentsCount,:attitudesCount,:PicUrls)"
#define Insert_Home_Sql @"insert into WBHome  values(:idstr,:created_at,:text,:source,:favorited,:user,:retweeted_status,:reposts_count,:comments_count,:attitudes_count,:pic_urls)"

//查询微博表中所有的记录
#define Query_Home_Sql @"SELECT * FROM WBHome;"
#define Delete_Home_Sql @"delete FROM WBHome;"
//数据库的文件名
#define BaseFileName @"Weibo.sqlite"
@interface DbCommon : NSObject

@end
