//
//  ThreadViewController.m
//  02多线程的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ThreadViewController.h"
#define Img_URL @"http://f.hiphotos.baidu.com/image/h%3D200/sign=3630dd6c4336acaf46e091fc4cd88d03/bd3eb13533fa828b5bc103b6f51f4134960a5a81.jpg"
@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)loadThreadBtn:(id)sender{
    int index=(int)((UIButton *)sender).tag;
    switch (index) {
        case 1:
            [self dynamicCreateThread];
            break;
        case 2:
            [self staticCreateThread];
            break;
        case 3:
            [self implicitCreateThread];
            break;
        default:
            break;
    }
}
//动态创建线程
-(void) dynamicCreateThread{
    //手动的方式创建线程
    NSThread *thread=[[NSThread alloc] initWithTarget:self selector:@selector(loadImageSourceThread:) object:Img_URL];
    thread.threadPriority=1; //设置线程的优先级(1 最高级 0 中级 -1 最低级,-1到1之间)
    //线程启动
    [thread start];
    
}
//静态的方式创建线程
-(void) staticCreateThread{
    //不用手动创建线程的内存空间,启动等,线程以创建就启动
    [NSThread detachNewThreadSelector:@selector(loadImageSourceThread:) toTarget:self withObject:Img_URL];
}
//隐式的方式创建线程
-(void) implicitCreateThread{
    [self performSelectorInBackground:@selector(loadImageSourceThread:) withObject:Img_URL];
}
//线程方法 子线程
-(void) loadImageSourceThread:(NSString *)url{
    NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image=[UIImage imageWithData:imgData];
    if (imgData!=nil) {
        //刷新ui
        //调用主线程方法
        [self performSelectorOnMainThread:@selector(refreshUI:) withObject:image waitUntilDone:YES];
    }else{
        NSLog(@"图片对象为空");
    }
}
//刷新ui---主线程中操作
-(void) refreshUI:(UIImage *) img{
    imgView.image=img;
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
