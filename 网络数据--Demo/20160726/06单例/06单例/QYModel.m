//
//  QYModel.m
//  06单例
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYModel.h"

@implementation QYModel
+(instancetype) shareInstance{
    static QYModel *instance;
//    //方式1
//    if (!instance) {
//        NSLog(@"对象内存空间分配一次");
//        instance=[[QYModel alloc] init];
//    }
    //方式2
    static dispatch_once_t once;
    dispatch_once(&once,^{
        NSLog(@"此对象的内存空间分配一次");
        instance=[[QYModel alloc] init];
    });
    
    return instance;
}
@end
