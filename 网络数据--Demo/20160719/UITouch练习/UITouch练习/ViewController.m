//
//  ViewController.m
//  UITouch练习
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取光标当前点击的点
    CGPoint point=[self locationInTouch:touches];
    
    //判断当前点是否在imageView区域内
   // if ([self isImageViewContatinPoint:point]) {
        [UIView animateWithDuration:.25 animations:^{
            imgView.center=point;
        }];
    //}
    
}
//判断一个点是否在ImageView区域内
-(BOOL) isImageViewContatinPoint:(CGPoint) point{
    if (CGRectContainsPoint(imgView.frame, point)) {
        return YES;
    }
    return NO;
}
-(CGPoint) locationInTouch:(NSSet<UITouch *> *) touches{
    //1.获取手势
    UITouch *touch=[touches anyObject];
    //2.获取当前光标所在点
    CGPoint point=[touch locationInView:self.view];
    return point;
}
@end
