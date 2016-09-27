//
//  LoadImageOperation.h
//  02多线程的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//声明了协议
@protocol LoadImageDelegate<NSObject>
-(void) loadImageFinish:(UIImage *) image;
@end

@interface LoadImageOperation : NSOperation
@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,retain) id<LoadImageDelegate> loadDelegate;
@end
