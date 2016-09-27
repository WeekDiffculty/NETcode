//
//  NSCoderVC.h
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSCoderVC : UIViewController
@property(weak,nonatomic) IBOutlet UITextField *userNameTf;
@property(weak,nonatomic) IBOutlet UITextField *pwdTf;
@property(strong,nonatomic) NSString *filePath;
@end
