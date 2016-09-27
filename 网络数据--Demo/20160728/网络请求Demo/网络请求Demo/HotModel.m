//
//  HotModel.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return  [[self alloc] initWithDictionary:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        NSString *desc = value;
        [self setValue:desc forKey:@"desc"];
    }
    if ([key isEqualToString:@"id"]) {
        NSString *ID = value;
        [self setValue:ID forKey:@"ID"];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@",self.title,self.cover,self.origin];
}
@end
