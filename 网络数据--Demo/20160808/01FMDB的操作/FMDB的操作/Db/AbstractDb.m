//
//  AbstractDb.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AbstractDb.h"

@implementation AbstractDb
-(id) init{
    if (self=[super init]) {
        NSString *strDoc=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        self.dbPath=[strDoc stringByAppendingPathComponent:DB_FileName];
        NSLog(@"数据文件路径%@",self.dbPath);
    }
    return self;
}
@end
