//
//  NewsModal.h
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModal : NSObject
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSMutableArray *stories;
@property(nonatomic,strong) NSMutableArray *top_stories;
//解析向服务器请求的json数据
+(NewsModal *) parse:(NSDictionary *) dDict;
-(id) init;
@end
