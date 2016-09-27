//
//  BaseEntity.m
//  AFNetworking的使用
//
//  Created by qingyun on 16/7/23.
//  Copyright © 2016年 青云. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity
-(id) initWithDict:(NSDictionary *) dDict{
    if (self=[super init]) {
        self.date=dDict[@"date"];
    }
    return self;
}
@end
