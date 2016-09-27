//
//  ViewController.h
//  03AVAudioPlayer
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController
@property(nonatomic,strong) AVAudioPlayer *player;//播放音频的对象
@property(nonatomic,strong) AVAudioRecorder *recorder;//录制音频的对象
@property(nonatomic,strong) NSString *filePath;//录制/播放音频文件
@end

