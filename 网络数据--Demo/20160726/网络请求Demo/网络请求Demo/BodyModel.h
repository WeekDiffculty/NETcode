//
//  BodyModel.h
//  网络请求Demo
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TipModel;
@interface BodyModel : NSObject

@property (nonatomic, strong) TipModel *tipModel;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
