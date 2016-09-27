//
//  StoryEntity.m
//  AFNetworking的使用
//
//  Created by qingyun on 16/7/23.
//  Copyright © 2016年 青云. All rights reserved.
//

#import "StoryEntity.h"

@implementation StoryEntity
-(id) initWithDict:(NSDictionary *) dDict{
  //在父类初始化
    if (self=[super initWithDict:dDict]) {
        NSLog(@"%@",dDict);
        self.title=dDict[@"title"];
        self.nId=[dDict[@"id"] intValue];
        self.type=[dDict[@"type"] intValue];
        
        self.multipic=[NSNumber numberWithInteger:[dDict[@"multipic"] intValue]];
        self.images=dDict[@"images"];
        self.image=dDict[@"image"];
    }
    return self;
}
//解析Json数据
+(NSMutableArray *) parseJson:(NSDictionary *) dDict Type:(NSString *) strType{
    NSMutableArray *mArr=[NSMutableArray array];
    NSString *strDate=[dDict objectForKey:@"date"];
    NSArray *mStories=[dDict objectForKey:strType];
    for (NSUInteger index = 0; index < mStories.count; index ++) {
        NSDictionary *dStory=[mStories objectAtIndex:index];
        
        StoryEntity *sStory=[[StoryEntity alloc] initWithDict:dStory];
        sStory.date=strDate;
        //解析的实体放到数组中
        [mArr addObject:sStory];
    }
    
    return mArr;
}

+(NSDictionary *) parse:(NSDictionary *) dDict{
   NSMutableArray *mStories =[StoryEntity parseJson:dDict Type:@"stories"];
    NSMutableArray *mTopStories=[StoryEntity parseJson:dDict Type:@"top_stories"];
    return @{@"stories":mStories,@"top_stories":mTopStories};
}

@end
