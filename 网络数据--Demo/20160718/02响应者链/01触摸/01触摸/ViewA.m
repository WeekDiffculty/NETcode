//
//  ViewA.m
//  01触摸
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
//}

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"ViewA hitTest方法响应");
    //viewA的光标位置转换为viewB的光标位置
    CGPoint hitPoint=[viewB convertPoint:point fromView:self];
    if ([viewB pointInside:hitPoint withEvent:event]) {
        NSLog(@"在viewA中点击viewB");
        UIView *viewB1=[viewB hitTest:point withEvent:event];
        return viewB1;
    }
    UIView *view = [super hitTest:point withEvent:event];
    
    return view;
    
//    return self; 
}
@end
