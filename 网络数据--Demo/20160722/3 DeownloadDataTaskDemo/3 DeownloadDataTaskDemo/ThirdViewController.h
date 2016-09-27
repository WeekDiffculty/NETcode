//
//  ThirdViewController.h
//  3 DeownloadDataTaskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<NSURLSessionDownloadDelegate>
{
    IBOutlet UIImageView *imgView;
    IBOutlet UIProgressView *progressView;
    NSURLSessionDownloadTask *task;//下载任务对象
    NSData *resumeData;//断点续传的对象
    NSURL *imgFileUrl;
}
@end
