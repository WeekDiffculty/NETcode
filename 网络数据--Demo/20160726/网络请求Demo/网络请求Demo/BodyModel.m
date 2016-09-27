//
//  BodyModel.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BodyModel.h"
#import "TipModel.h"
@implementation BodyModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSDictionary *tipDict = dict[@"tip"];
        _tipModel = [[TipModel alloc] initWithDict:tipDict];
        _title = dict[@"title"];
    }
    return self;
}
@end
