//
//  OperationViewController.h
//  02多线程的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadImageOperation.h"
@interface OperationViewController : UIViewController<LoadImageDelegate>
{
    IBOutlet UIImageView *imgView;
}
@end
