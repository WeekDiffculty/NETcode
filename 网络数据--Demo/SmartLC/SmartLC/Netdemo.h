//
//  Netdemo.h
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Success)(id task,id response);
@interface Netdemo : NSObject

- (void)get:(NSString *)url parameters:(NSDictionary *)param success:(Success)success;
@end
