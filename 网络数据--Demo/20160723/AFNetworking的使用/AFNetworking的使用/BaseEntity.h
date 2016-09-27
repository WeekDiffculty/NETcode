//
//  BaseEntity.h
//  AFNetworking的使用
//
//  Created by qingyun on 16/7/23.
//  Copyright © 2016年 青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject
@property(nonatomic,strong) NSString *date;//日期
-(id) initWithDict:(NSDictionary *) dDict;

@end
