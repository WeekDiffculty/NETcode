//
//  ViewController.m
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NetManager.h"
#import "SDCycleScrollView.h"
#define kURL @"http://www.zhihuiluanchuan.com/index.php"
#define kImageUrl @"http://www.zhihuiluanchuan.com/index.php?s=Api/index/slide/tag/tongcheng"
@interface ViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    
   
//    NSDictionary *param = @{@"page":@(1),
//                            @"s":@"/Api/information/info_list"};
//    [[NetManager shareManager] requestInfo_ListDataWithParam:param callBack:^(id response, id error) {
//        if (error) {
//            
//        }else{
//            NSLog(@"%@",response);
//        }
//    }];
//    CGRectMake(0, 20, self.view.frame.size.width, 180)
    
}
- (void)setup
{
    SDCycleScrollView *scroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 180) delegate:self placeholderImage:nil];
    [self.view addSubview:scroll];
    [[NetManager shareManager] requestImagesCallBack:^(id response, id error) {
        if (!error) {
            scroll.imageURLStringsGroup = response;
            NSLog(@"response:%@",response);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
