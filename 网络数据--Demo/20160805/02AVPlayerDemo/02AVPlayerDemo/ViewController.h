//
//  ViewController.h
//  02AVPlayerDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface ViewController : UIViewController
@property(nonatomic,strong) AVPlayerViewController *playerViewController;
//ui控件
@property(weak,nonatomic) IBOutlet UIView *playView;
@property(weak,nonatomic) IBOutlet UISlider *proSlider;
@property(weak,nonatomic) IBOutlet UIProgressView *progressView;
//播放器的对象
@property(nonatomic,strong) AVPlayer *player;
//媒体资源管理对象,
@property(nonatomic,strong) AVPlayerItem *playerItem;

//声明播放当前的状态变量,判断是否正在播放
@property(nonatomic) BOOL isPlaying;
@end

