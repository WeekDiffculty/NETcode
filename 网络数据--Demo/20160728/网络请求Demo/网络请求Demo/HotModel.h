//
//  HotModel.h
//  网络请求Demo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger view;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
