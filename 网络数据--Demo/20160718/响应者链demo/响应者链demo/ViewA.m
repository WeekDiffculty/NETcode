//
//  ViewA.m
//  响应者链demo
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A is touched");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    NSLog(@"point: %@",NSStringFromCGPoint(point));
}

@end
