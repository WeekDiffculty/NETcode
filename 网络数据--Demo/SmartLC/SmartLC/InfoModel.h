//
//  InfoModel.h
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *lianxiren;
@property (nonatomic, copy) NSString *pics;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger type_id;
@property (nonatomic, assign) NSInteger uid;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
