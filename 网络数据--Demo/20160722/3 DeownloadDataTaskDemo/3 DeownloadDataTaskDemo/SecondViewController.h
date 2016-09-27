//
//  SecondViewController.h
//  3 DeownloadDataTaskDemo
//
//  Created by qingyun on 16/7/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<NSURLSessionDownloadDelegate>
{
    IBOutlet __weak UIImageView *imgView;
}
@end
