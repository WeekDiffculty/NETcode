//
//  ViewController.m
//  01手势识别器
//
//  Created by qingyun on 16/7/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //2.双击手势
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleGuesture:)];
    //设置点击次数
    doubleTap.numberOfTapsRequired=2;
    //手指的个数
    doubleTap.numberOfTouchesRequired=2;
    [self.view addGestureRecognizer:doubleTap];
//    //3.滑动手势
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGuesture:)];
    swipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
//    //4.旋转的手势
//    UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateGuesture:)];
//    [self.view addGestureRecognizer:rotation];
//    //5.捏合手势
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGuesture:)];
    [self.view addGestureRecognizer:pinch];
//    UIScreenEdgePanGestureRecognizer *screenGusture=[[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeGueture:)];
//    screenGusture.edges=UIRectEdgeRight;
//    [self.view addGestureRecognizer:screenGusture];
    //6.平移手势
//    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGuesture:)];
//    [self.view addGestureRecognizer:pan];
      //7.长按手势
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGuesture:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) tapGuesture:(UITapGestureRecognizer *) tapGuesture{
    NSLog(@"单击操作");
}
-(void) doubleGuesture:(UITapGestureRecognizer *) tapGuesture{
    NSLog(@"双击的操作");
}
-(void) swipeGuesture:(UISwipeGestureRecognizer *) swipGuesture{
    NSLog(@"滑动手势%@",swipGuesture.description);
    NSLog(@"%ld",swipGuesture.direction);
    if (swipGuesture.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左滑动");
    }
    
}
-(void) rotateGuesture:(UIRotationGestureRecognizer *) rotateGuesture{
    NSLog(@"旋转手势");
}
-(void) pinGuesture:(UIPinchGestureRecognizer *) pinGuesture{
    NSLog(@"捏合手势%f %f",pinGuesture.scale,pinGuesture.velocity);
}
-(void) edgeGueture:(UIScreenEdgePanGestureRecognizer *) edgePanGuesture{
    NSLog(@"屏幕边缘手势");
}
-(void) panGuesture:(UIPanGestureRecognizer *) panGuesture{
    NSLog(@"平移手势");
    CGPoint point=[panGuesture translationInView:panGuesture.view];
    NSLog(@"距离%@",NSStringFromCGPoint(point));
}
-(void)longPressGuesture:(UILongPressGestureRecognizer *) lonGuesture{
    if (lonGuesture.state==UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始");
    }else if(lonGuesture.state==UIGestureRecognizerStateChanged){
        NSLog(@"长按变化");
    }else if(lonGuesture.state==UIGestureRecognizerStateEnded){
        NSLog(@"长按结束");
    }
}
@end
