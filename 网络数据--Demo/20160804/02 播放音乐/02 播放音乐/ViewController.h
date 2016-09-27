//
//  ViewController.h
//  02 播放音乐
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>
{

}
@property(nonatomic,strong) AVAudioPlayer *player; //播放器对象
@property(weak,nonatomic) IBOutlet UIProgressView *meterProgress;//音频播放分贝的大小
@property(weak,nonatomic) IBOutlet UISlider *volumeSider;//音量的大小
@property(weak,nonatomic) IBOutlet UISlider *progressSlider;//播放进度
@property(nonatomic,strong) NSTimer *timer;

@end

