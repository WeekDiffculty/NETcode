//
//  ViewController.m
//  手势识别器练习
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
    pinGuesture.delegate=self;
    rotateGuesture.delegate=self;
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//捏合手势 放大缩小视图
-(IBAction)pinAction:(UIPinchGestureRecognizer *) sender{
    //1.获取当前缩放的比例
    float scale=sender.scale; 
    NSLog(@"%f",scale);
    sender.view.transform=CGAffineTransformScale(sender.view.transform, scale, scale);
    sender.scale=1;
    
}
//拖动手势
-(IBAction)panAction:(UIPanGestureRecognizer *)sender{
    //先获取当前手势所在的点,所在的位置
    CGPoint point=[sender translationInView:sender.view.superview];
    [sender setTranslation:CGPointZero inView:sender.view.superview];
    sender.view.center=CGPointMake(sender.view.center.x+point.x, sender.view.center.y+point.y);
}
//旋转手势
-(IBAction)rotateAction:(UIRotationGestureRecognizer *)sender{
    NSLog(@"旋转角度%f",sender.rotation);
    //设置旋转的角度
    sender.view.transform=CGAffineTransformRotate(sender.view.transform, sender.rotation);
    sender.rotation=0;
    
}
-(BOOL) gestureRecognizer:(UIGestureRecognizer *) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end
