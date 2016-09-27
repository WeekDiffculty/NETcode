//
//  NetManager.m
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NetManager.h"
#import "InfoModel.h"
@implementation NetManager
+ (instancetype)shareManager
{
    static NetManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [NetManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/xml", nil];
    });
    return manager;
}

- (void)requestInfo_ListDataWithParam:(NSDictionary *)param callBack:(Callback)callBack
{
    NSString *url = @"http://www.zhihuiluanchuan.com/index.php";
    [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//      直接在网络类里进行数据解析,外部使用时拿到的就是数据模型
        NSArray *data = responseObject[@"data"];
        NSMutableArray *muarr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            InfoModel *model = [InfoModel modelWithDictionary:dict];
            [muarr addObject:model];
        }
        callBack(muarr,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(nil,error);
    }];
}

- (void)requestImagesCallBack:(Callback)callBack
{
    NSString *url = @"http://www.zhihuiluanchuan.com/index.php?s=Api/index/slide/tag/tongcheng";
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *muarr = [NSMutableArray array];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            [muarr addObject:dict[@"image"]];
        }
        callBack(muarr,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(nil,error);
    }];
}
@end
