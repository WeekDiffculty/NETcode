//
//  StudatusDb.h
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBAbstract.h"
#import "QYStatusModel.h"
@interface StudatusDb : DBAbstract
+(id) shareIntance;
-(void) Insert:(QYStatusModel *) status;
//插入微博主页中每条记录(微博)
-(void) InsertStatues:(NSMutableArray *) arr;
//查询微博主页数据
-(NSMutableArray *) Query;
@end
