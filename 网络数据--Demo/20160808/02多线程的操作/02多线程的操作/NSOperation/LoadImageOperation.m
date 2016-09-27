//
//  LoadImageOperation.m
//  02多线程的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LoadImageOperation.h"
#import <UIKit/UIKit.h>
@implementation LoadImageOperation
//main方法 NSOperation 封装的类 自动调用的方法 ,入口的方法
-(void) main{
    if (self.isCancelled) {
        return;
    }
    NSURL *url=[NSURL URLWithString:self.imgUrl];
    NSData *imgData=[NSData dataWithContentsOfURL:url];
    if (self.isCancelled) {
        imgData=nil;
        return;
    }
    
    UIImage *image=[UIImage imageWithData:imgData];
    if(self.isCancelled)
    {
        image=nil;
        return;
    }
    
    if (self.loadDelegate!=nil && [self.loadDelegate respondsToSelector:@selector(loadImageFinish:)]) {
        //代理调用协议中的方法
        [(NSObject *)self.loadDelegate performSelectorOnMainThread:@selector(loadImageFinish:) withObject:image waitUntilDone:NO];
    }
    
}
@end
