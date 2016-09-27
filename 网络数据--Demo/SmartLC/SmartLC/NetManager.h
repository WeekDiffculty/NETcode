//
//  NetManager.h
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AFHTTPSessionManager.h"
typedef void (^Callback) (id response, id error);

@interface NetManager : AFHTTPSessionManager

+ (instancetype)shareManager;
/**
 *  封装info_list请求方式
 *
 *  @param param    请求参数-因为page是可变的整形,所以作为参数
 *  @param callBack 对网络请求下来的数据进行回调
 */
- (void)requestInfo_ListDataWithParam:(NSDictionary *)param callBack:(Callback)callBack;

- (void)requestImagesCallBack:(Callback)callBack;

@end
