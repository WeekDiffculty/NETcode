//
//  OperationViewController.m
//  02多线程的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "OperationViewController.h"
#import "LoadImageOperation.h"
#define Img_URL @"http://f.hiphotos.baidu.com/image/h%3D200/sign=3630dd6c4336acaf46e091fc4cd88d03/bd3eb13533fa828b5bc103b6f51f4134960a5a81.jpg"
@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)operationBtn:(id)sender{
    int index=(int)((UIButton *)sender).tag;
    switch (index) {
        case 1:
            [self useInVoncationOperation];
            break;
        case 2:
            [self useBlockOpeartion];
            break;
        case 3:
            [self useSubclassOperation];
            break;
        default:
            break;
    }
}
//使用NSInvocation 调用选择器的方法
-(void) useInVoncationOperation{
    //创建一操作(子线程)
    NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImageSourceThread:) object:Img_URL];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    //把操作添加到操作队列,一旦添加后就自动运行线程的方法
    [queue addOperation:operation];
}
//Block方法调用选择器的方法
-(void) useBlockOpeartion{
    //创建操作(子线程)
    __weak OperationViewController *tempVC=self;
    NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
        [tempVC loadImageSourceThread:Img_URL];
    }];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [queue addOperation:blockOperation];
}
//使用继承NSOperation子类的方法
-(void) useSubclassOperation{
    LoadImageOperation *operation=[[LoadImageOperation alloc] init];
    operation.loadDelegate=self;
    operation.imgUrl=Img_URL;
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [queue addOperation:operation];
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
-(void) loadImageFinish:(UIImage *) image{
    [self refreshUI:image];
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
