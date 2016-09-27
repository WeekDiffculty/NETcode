//
//  HttpRequest.h
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"
@interface HttpRequest : NSObject
+(instancetype) sharedInstance;
-(void) Post:(NSString *) strURL Param:(NSDictionary *) dParamDict success:(void(^)(NSDictionary *dict)) success failure:(void(^)(NSError *)) failure;
-(void) Get:(NSString *) strURL Param:(NSDictionary *) dParamDict success:(void(^)(NSDictionary *dict)) success failure:(void(^)(NSError *)) failure;
@end
