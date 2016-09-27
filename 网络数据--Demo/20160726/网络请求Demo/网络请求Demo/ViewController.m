//
//  ViewController.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "BodyModel.h"
#define BASE_URL @"http://api.iclient.ifeng.com/newsdocs?imgwidth=300&aid=imcp_111486272,imcp_111486422,imcp_111489103,imcp_111482849,imcp_111485520,imcp_111476942,imcp_111483937,imcp_111487976,imcp_111486812,imcp_111446786,imcp_111488600,imcp_111487634,imcp_111487535&channel=push&chid=&vt=2&piece=3&android=1&gv=5.2.2&av=5.2.2&uid=866028022694420&deviceid=866028022694420&proid=ifengnews&os=android_19&df=androidphone&vt=5&screen=480x854&publishid=2011&nw=wifi"
@interface ViewController ()
@property (nonatomic, copy)NSArray *arrList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSMutableArray *muarr = [NSMutableArray array];
    [manager GET:BASE_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSArray *datas = responseObject;
//        for (NSDictionary *dict in datas) {
//            NSDictionary *bodyDict = dict[@"body"];
//            BodyModel *model = [[BodyModel alloc] initWithDict:bodyDict];
//            [muarr addObject:model];
//        }
//        _arrList = muarr;
        NSLog(@"response:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
