//
//  ViewController.h
//  01MPMoviePlayerController
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController : UIViewController
@property(nonatomic,strong) MPMoviePlayerController *mpController;
//MPMoviePlayerViewController 在ios9以上不推荐
//@property(nonatomic,strong) MPMoviePlayerViewController
@end

