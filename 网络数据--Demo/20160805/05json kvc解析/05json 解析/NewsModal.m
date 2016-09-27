//
//  NewsModal.m
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsModal.h"
#import "StoryModal.h"
@implementation NewsModal
//解析向服务器请求获得的json数据
+(NewsModal *) parse:(NSDictionary *) dDict{
    NewsModal *news=[[NewsModal alloc] init];
    news.date=dDict[@"date"];
    NSArray *stories=dDict[@"stories"];
    NSArray *top_stories=dDict[@"top_stories"];
    
    for (NSUInteger index = 0; index < stories.count; index ++) {
        NSDictionary *dict=[stories objectAtIndex:index];
        StoryModal *sModal=[[StoryModal alloc] initWithDict:dict];
        [news.stories addObject:sModal];
    }
    return news;
}
-(id) init{
    if (self=[super init]) {
        //初始化数组
        self.stories=[NSMutableArray array];
        self.top_stories=[NSMutableArray array];
    }
    return self;
}
//kvc方式解析json数据
+(NewsModal *) kvcParse:(NSDictionary *) dDict{
    NewsModal *news=[[NewsModal alloc] init];
    //kvc
    [news setValuesForKeysWithDictionary:dDict];
    NSArray *stories=dDict[@"stories"];
    news.stories=[NSMutableArray array];//初始化数组
    for (NSUInteger index = 0; index < stories.count; index ++) {
        //stories字段中值 数组中每个元素 提取出来 是字典的形式,然后进行kvc=>model(StoryModal)的转换
        NSDictionary *dict1=stories[index];
        StoryModal *story=[[StoryModal alloc] init];
        //kvc
        [story setValuesForKeysWithDictionary:dict1];
        [news.stories addObject:story];
    }
    //top_stories kvc解析json的练习
    return news;
}
@end
