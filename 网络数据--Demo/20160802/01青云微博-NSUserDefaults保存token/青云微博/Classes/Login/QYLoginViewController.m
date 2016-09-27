//
//  QYLoginViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYLoginViewController.h"
#import "ConfigFile.h"
#import "QYRequestManager.h"
#import "QYAccessToken.h"
@interface QYLoginViewController ()

@property(nonatomic,strong) UIWebView *myWeb;

@end

@implementation QYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.添加webView
    [self.view addSubview:self.myWeb];
    //2.请求用户授权的token
    [self getUserTempToken];
    
}
//1.
-(UIWebView *) myWeb{
    if (_myWeb)
    {
        return _myWeb;
    }
    //初始化webiew
    _myWeb=[[UIWebView alloc] initWithFrame:self.view.bounds];
    _myWeb.delegate=self;
    _myWeb.scalesPageToFit=YES;
    return _myWeb;

}
//可以监听到request请求,获取授权码Temptoken
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *strURL=[request.URL absoluteString];
    NSLog(@"%@",strURL);
    //1.判断url地址是否是微博回调地址,如果存在,表示授权请求成功,获取授权码
    if ([strURL hasPrefix:DIRPATH]) {
        //2.获取请求授权码
        NSArray *arr=[strURL componentsSeparatedByString:@"="];
        NSString *code=arr.lastObject;
        //3.向服务器请求accessToken
        [self getAccessToekenRequest:code];
        return NO;
    }
    return YES;
}
//2.用户授权请求token
-(void) getUserTempToken{
    
//    //1.URL对象
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:AUTHORIZE]];
    //NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=644299207&redirect_uri=http://www.hnqingyun.com&response_type=code"];
    //2.设置请求方式
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //请求方法
    request.HTTPMethod=@"POST";
    //3.设置请求体
   
    request.HTTPBody=[[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@&response_type=code",APPKEY,DIRPATH ] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",APPKEY,DIRPATH ]);
    
    //4.webView请求
    [self.myWeb loadRequest:request];
//
    
}
//获取accessToken值
-(void) getAccessToekenRequest:(NSString *) code{
    __weak QYLoginViewController *loginVC=self;
    [[QYRequestManager shareInstance] request_token:code success:^(QYAccessToken *token){
        //NSLog(@"token%@",token.access_token);
        [QYAccessToken shareInstance].access_token=token.access_token;
        [QYAccessToken shareInstance].expires_in=token.expires_in;
        [QYAccessToken shareInstance].remind_in=token.remind_in;
        [QYAccessToken shareInstance].uid=token.uid;
        //将数据保存至沙盒当中
        [[QYAccessToken shareInstance] saveToken];
        //注:在block块中实现ui的操作,都要在主线程中操作
        dispatch_async(dispatch_get_main_queue(), ^{
             [loginVC.navigationController popViewControllerAnimated:YES];
        });
       
    }  failure:^(NSError *error){
        NSLog(@"网络错误%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
