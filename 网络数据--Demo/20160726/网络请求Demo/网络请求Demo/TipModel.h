//
//  TipModel.h
//  网络请求Demo
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipModel : NSObject
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
