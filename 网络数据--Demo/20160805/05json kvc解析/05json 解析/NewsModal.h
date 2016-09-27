//
//  NewsModal.h
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryModal.h"
@interface NewsModal : NSObject
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSMutableArray<StoryModal *> *stories;//表示数组中每个元素的指定类型StoryModal
@property(nonatomic,strong) NSMutableArray *top_stories;
//手动的方式解析向服务器请求的json数据
+(NewsModal *) parse:(NSDictionary *) dDict;
//kvc方式解析json数据
+(NewsModal *) kvcParse:(NSDictionary *) dDict;
-(id) init;
@end
