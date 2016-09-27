//
//  ViewController.m
//  03AVAudioPlayer
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self InitUI];
}
//懒加载 初始化文件路径
-(NSString *) filePath{
    if (_filePath) {
        return _filePath;
    }
    NSString *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath=[documentsPath stringByAppendingPathComponent:@"temp.caf"];
    NSLog(@"%@",_filePath);
    return _filePath;
}
//设置录音音频格式
-(NSMutableDictionary *) setAudioSettings{
    NSMutableDictionary *setS=[NSMutableDictionary dictionary];
    //1.设置编码格式,PCM,存储文件的格式不能是mp3,只能用caf wav
    [setS setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //2.设置采样率
    [setS setObject:@(8000) forKey:AVSampleRateKey];
    //3.设置通道数量
    [setS setObject:@(2) forKey:AVNumberOfChannelsKey];
    //4.设置增量化位数
    [setS setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //5.设置编码的质量
    [setS setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    return setS;
}
-(AVAudioRecorder *) recorder{
    if (_recorder) {
        return _recorder;
    }
    //初始化录制音频对象
    NSError *err;
    _recorder=[[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.filePath] settings:[self setAudioSettings] error:&err];
    NSLog(@"error==%@",err);
    //准备录制
    [_recorder prepareToRecord];
    return _recorder;
}
-(AVAudioPlayer *) player{
    if (_player) {
        return _player;
    }
    //初始化播放器的对象
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.filePath] error:nil];
    //准备播放
    [_player prepareToPlay];
    return _player;
}
-(void) InitUI{
    //1.录制音频的按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"录制" forState:UIControlStateNormal];
    btn.frame=CGRectMake(100, 100, 100, 50);
    [btn addTarget:self action:@selector(recorderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //2.录制音频停止按钮
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setTitle:@"音频录制停止" forState:UIControlStateNormal];
    btn2.frame=CGRectMake(100, 200, 100, 50);
    [btn2 addTarget:self action:@selector(stopBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    //播放按钮
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setTitle:@"播放" forState:UIControlStateNormal];
    btn3.frame=CGRectMake(100, 300, 100, 50);
    [btn3 addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}
//播放音频的方法
-(void) playBtn:(UIButton *)sender{
    if (self.player.isPlaying) {
        [self.player pause];
    }else{
        [self.player play];
    }
}
//录音的按钮
-(void) recorderBtn:(UIButton *) sender{
    if (self.recorder.isRecording) {
        [sender setTitle:@"录音" forState:UIControlStateNormal];
        [self.recorder pause];
    }else{
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self.recorder record];
    }
}
//停止录音
-(void) stopBtn:(id) sender{
    [self.recorder stop];
    if ([self.recorder deleteRecording]) {
        NSLog(@"删除内存中的音频流");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
