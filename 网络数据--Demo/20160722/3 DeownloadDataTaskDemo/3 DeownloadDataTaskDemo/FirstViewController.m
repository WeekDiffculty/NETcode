//
//  FirstViewController.m
//  3 DeownloadDataTaskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FirstViewController.h"
#define IMG_URL @"http://img.warting.com/allimg/2016/0315/vcirw2ma1lb-1781.jpg"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)DownloadBtn:(id)sender{
    //1.创建URL对象
    NSURL *url=[NSURL URLWithString:IMG_URL];
    //2.创建session对象
    NSURLSession *session=[NSURLSession sharedSession];
    __weak UIImageView *tempImgView=imgView;
    //3.创建文件下载任务
    NSURLSessionDownloadTask *task=[session downloadTaskWithURL:url completionHandler:^(NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error){
        if (error) {
            NSLog(@"下载失败%@",error);
        }
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
            //NSURL=>NSString
            NSLog(@"文件的保存位置%@",location.absoluteString);
            NSData *data=[NSData dataWithContentsOfURL:location];
            UIImage *img=[UIImage imageWithData:data];
            //刷新ui界面
            if (img) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    tempImgView.image=img;
                });
            }
        }
    }];
    [task resume];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
