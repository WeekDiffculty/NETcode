//
//  StoryModal.h
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModal : NSObject
@property(nonatomic,strong) NSArray *images;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,assign) NSInteger Id;
@property(nonatomic,strong) NSString *ga_prefix;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSNumber *multipic;
//解析字典当中的每个元素
-(id) initWithDict:(NSDictionary *) dict;

@end
