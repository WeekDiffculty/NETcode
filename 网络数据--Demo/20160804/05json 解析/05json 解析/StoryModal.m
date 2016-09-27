//
//  StoryModal.m
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "StoryModal.h"

@implementation StoryModal
-(id) initWithDict:(NSDictionary *) dict{
    if (self=[super init]) {
        self.images=dict[@"images"];
        self.type=[dict[@"type"] integerValue];
        self.Id=[dict[@"id"] integerValue];
        self.ga_prefix=dict[@"ga_prefix"];
        self.title=dict[@"title"];
        self.multipic=[NSNumber numberWithInteger:[dict[@"multipic"] integerValue]];
        
    }
    return self;
}
@end
