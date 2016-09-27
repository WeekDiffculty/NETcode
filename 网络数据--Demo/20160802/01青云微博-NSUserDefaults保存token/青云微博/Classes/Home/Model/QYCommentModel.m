//
//  QYCommentModel.m
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYCommentModel.h"
#import "QYUserModel.h"
#import "NSString+QYString.h"

@implementation QYCommentModel

+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData {
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    QYCommentModel *comment = [self new];
    
    comment.user = [QYUserModel userModelWithDictionary:dicData[@"user"]];
    comment.strCreateAt = dicData[@"created_at"];
    comment.strText = dicData[@"text"];
    
    return comment;
}

- (void)setStrCreateAt:(NSString *)strCreateAt {
    _strCreateAt = [strCreateAt copy];
    _strTimeDes = [NSString descriptionWithString:_strCreateAt];
}

@end
