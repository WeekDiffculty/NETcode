//
//  QYUserInfoEntity.h
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUserInfoEntity : NSObject<NSCoding>
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *pwd;
@end
