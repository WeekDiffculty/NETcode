//
//  DBAbstract.m
//  青云微博
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DBAbstract.h"

@implementation DBAbstract
//会自动调用这个方法里的内容
-(DBAbstract *) init{
    self=[super init];
    NSString *strDoc=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.dbPath=[strDoc stringByAppendingPathComponent:BaseFileName];
    return self;
}

@end
