//
//  QYAccessToken.h
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
//实体的定义要和json数据中的每个字段名要一样,如果不一样,自动解析json数据报错.
//kvc的方式自动解析json数据
@interface QYAccessToken : NSObject
@property(nonatomic,strong) NSString *access_token;
@property(nonatomic,strong) NSString *expires_in;
@property(nonatomic,strong) NSString *remind_in;
@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,strong) QYAccessToken *token;
+(instancetype) shareInstance;
@end
