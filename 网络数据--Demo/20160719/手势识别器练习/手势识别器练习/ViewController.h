//
//  ViewController.h
//  手势识别器练习
//
//  Created by qingyun on 16/7/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UIPinchGestureRecognizer *pinGuesture;
    IBOutlet UIRotationGestureRecognizer *rotateGuesture;
}

@end

