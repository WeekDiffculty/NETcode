//
//  ViewC.m
//  01触摸
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewC.h"

@implementation ViewC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSLog(@"%s",__func__);
    //获取一个UITouch对象
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    NSLog(@"%@",NSStringFromCGPoint(point));
    NSLog(@"%ld",touch.tapCount);
    //点击次数
    if (touch.tapCount==1) {
        //NSLog(@"单击一次");
        //延迟1s进行单击操作
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:1];
    }else{
        //NSLog(@"再次单击");
        //取消单击的操作
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
        [self doubleTap];
    }
    
    
}
//单击操作
-(void) singleTap{
    NSLog(@"单击了");
}
-(void) doubleTap{
    NSLog(@"双击");
}
//移动手势时调用
-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"===%s",__func__);
}
//手势停止的时候调用
-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"===%s",__func__);

}
//手势取消时调用的方法
-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"===%s",__func__);
}
@end
