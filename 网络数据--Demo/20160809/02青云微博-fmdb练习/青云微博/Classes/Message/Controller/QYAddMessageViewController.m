//
//  QYAddMessageViewController.m
//  青云微博
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYAddMessageViewController.h"
#import "QYRequestManager.h"
#import "QYAccessToken.h"
@interface QYAddMessageViewController ()

@end

@implementation QYAddMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加边框的颜色
    txtView.layer.borderColor=[UIColor blackColor].CGColor;
    //设置边框的宽度
    txtView.layer.borderWidth=1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回按钮
-(IBAction)cancelBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];

}
//发微博按钮
-(IBAction)addMsgBtn:(id)sender{
    //获取要发微博的文本
    NSString *strMsg=txtView.text;
    //网络请求 发微博
    [[QYRequestManager shareInstance] addMessage:[QYAccessToken shareInstance].access_token Content:strMsg sucess:^(NSMutableArray *arr){
        NSLog(@"微博发送成功");
        //关闭视图控制器
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *err){
        NSLog(@"网络失败%@",err);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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
