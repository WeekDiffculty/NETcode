//
//  InfoModel.m
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descrip"];
    }
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
