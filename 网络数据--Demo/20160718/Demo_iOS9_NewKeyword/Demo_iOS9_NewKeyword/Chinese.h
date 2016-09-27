//
//  Chinese.h
//  Demo_iOS9_NewKeyword
//
//  Created by qingyun on 16/7/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chinese : NSObject

+ (__kindof Chinese *)modelWithDictionary:(NSDictionary *)dicData;
+ (instancetype)modelWith:(NSDictionary *)dicData;

@end
