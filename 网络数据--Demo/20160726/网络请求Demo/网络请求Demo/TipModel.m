//
//  TipModel.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TipModel.h"

@implementation TipModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
