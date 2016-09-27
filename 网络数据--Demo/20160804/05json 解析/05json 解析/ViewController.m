//
//  ViewController.m
//  05json 解析
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NewsModal.h"
#define Server_Zhihu_Url_Last @"http://news-at.zhihu.com/api/4/news/latest"
@interface ViewController ()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) NewsModal *newsModal;//json数据解析后的对象
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(AFHTTPSessionManager *) manager{
    if (_manager) {
        return _manager;
    }
    //初始化manager对象
    _manager=[AFHTTPSessionManager manager];
    return _manager;
}
-(IBAction)getBtn:(id)sender{
    __weak ViewController *temp=self;
    [self.manager GET:Server_Zhihu_Url_Last parameters:nil progress:^(NSProgress *NSProgress){
    
    } success:^(NSURLSessionDataTask *task,id responseObject){
        NSLog(@"%@",responseObject);
       NewsModal *nNews=[NewsModal parse:(NSDictionary *)responseObject];
        self.newsModal=nNews;
        //主线程刷新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格视图调用reloadData 方法
            
        });
        
    } failure:^(NSURLSessionDataTask *task,NSError *error){
        NSLog(@"网络错误%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
