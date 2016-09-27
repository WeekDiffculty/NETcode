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
@end
