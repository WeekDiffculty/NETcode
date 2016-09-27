//
//  ViewController.m
//  02 播放音乐
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
    [self initUI];
}
//1.初始化播放音频的对象
-(AVAudioPlayer *) player{
    if (_player) {
        return _player;
    }
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"红颜劫" withExtension:@"mp3"];
    //初始化
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    _player.delegate=self;
    //设置循环 0 不循环播放 1 表示循环一次 -1无限循环
    _player.numberOfLoops=0;
    //设置速率是否可用
    _player.enableRate=YES;
    //设置分贝是否可用
    _player.meteringEnabled=YES;
    //调用硬件设备,准备工作
    [_player prepareToPlay];
    return _player;
}
//ui控件值初始化
-(void) initUI{
    //设置音量
    _volumeSider.maximumValue=1.0;
    _volumeSider.value=self.player.volume;
    //设置播放进度
    _progressSlider.maximumValue=self.player.duration;
    _progressSlider.value=self.player.currentTime;
}
//初始化计时器对象
-(NSTimer *) timer{
    if (_timer) {
        return _timer;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(UpdateProgress) userInfo:nil repeats:YES];
    return _timer;
}
//更新播放进度
-(void) UpdateProgress{
    self.progressSlider.value=self.player.currentTime;
    [self UpdateMeter];
}
//更新分贝值
-(void) UpdateMeter{
    //1.更新当前最新分贝值
    [self.player updateMeters];
    //2.获取通道1的平均分贝值
    float value=[self.player averagePowerForChannel:1];
    _meterProgress.progress=(value+160)/160.0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置播放状态
-(IBAction)payeOrPauseAction:(UIButton *)sender{
    //判断当前播放状态
    if (self.player.isPlaying) {
        //暂停播放
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        //暂停
        [self.player pause];
        self.timer.fireDate=[NSDate distantFuture];
    }else{
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        //音频对象播放的方法
        [self.player play];
        //启动计时器
        self.timer.fireDate=[NSDate date];
    }
}
//设置音量
-(IBAction)changeValueVolume:(id)sender{
    UISlider *slider=(UISlider *)sender;
    self.player.volume=slider.value;
}
//设置播放时间(进度)
-(IBAction)playChangeValue:(id)sender{
    UISlider *slider=(UISlider *)sender;
    self.player.currentTime=slider.value;
}
//播放速率
-(IBAction)palyRateBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 1://慢
            self.player.rate=.5;
            break;
        case 2://正常
            self.player.rate=1;
            break;
        case 3://快
            self.player.rate=2;
            break;
        default:
            break;
    }
}
//注:在appdelegate中  添加 [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];注册远程控制事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    //处理远程控制时间,接收耳机的按键事件
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            NSLog(@"播放事件响应");
            
            break;
            
        default:
            break;
    }
}
@end
