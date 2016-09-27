//
//  ViewB.m
//  01触摸
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewB.h"

@implementation ViewB

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
    当在对应的视图上进行触摸操作的时候,这个方法会自动调用
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"ViewB hitTest方法响应");
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    BOOL is = [super pointInside:point withEvent:event];
    NSLog(@"------%@",NSStringFromCGPoint(point));
    return is;
}
@end
