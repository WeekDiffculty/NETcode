//
//  StoryEntity.h
//  AFNetworking的使用
//
//  Created by qingyun on 16/7/23.
//  Copyright © 2016年 青云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface StoryEntity : BaseEntity
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,assign) NSInteger nId;
@property(nonatomic,strong) NSNumber *multipic;//Bool值
@property(nonatomic,strong) NSString *image;//是在topStories 字段解析的时候使用
@property(nonatomic,strong) NSArray *images;//是在Stories字段解析的时候使用
-(id) initWithDict:(NSDictionary *) dDict;
//根据指定字段解析Json数据
+(NSMutableArray *) parseJson:(NSDictionary *) dDict Type:(NSString *) strType;
//解析所有字段的Json数据
+(NSDictionary *) parse:(NSDictionary *) dDict;
@end
