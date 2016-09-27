//
//  QYStudent.h
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYStudent : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) NSInteger age;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSData *icon;
@property(nonatomic,strong) NSString *Id;
+(instancetype) modeWithDic:(NSDictionary *) dic;
@end
