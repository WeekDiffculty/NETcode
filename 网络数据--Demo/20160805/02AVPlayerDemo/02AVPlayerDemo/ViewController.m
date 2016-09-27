//
//  ViewController.m
//  02AVPlayerDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)AVPlayerBtn:(id)sender{
    //初始化视图控制器的对象
    self.playerViewController=[[AVPlayerViewController alloc] init];
    //设置播放器的对象
    AVPlayer *player=[[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    self.playerViewController.player=player;
    //设置样式
    self.playerViewController.videoGravity=AVLayerVideoGravityResizeAspect;
    //播放
    [self.playerViewController.player play];
    [self presentViewController:self.playerViewController animated:YES completion:^{
        NSLog(@"播放结束");
    }];
}
/*懒加载两个对象*/
-(AVPlayer *) player{
    if (_player) {
        return _player;
    }
    //1.创建player对象
    _player=[[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    //2.监听当前播放的时间
    __weak ViewController *vc=self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time){
        float seconds=CMTimeGetSeconds(time);
        NSLog(@"当前播放的时间%f",seconds);
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.proSlider setValue:seconds animated:YES];
        });
    }];
    return _player;
}
-(AVPlayerItem *) playerItem{
    if(_playerItem){
        return _playerItem;
    }
    //1.url对象
    NSURL *url=[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    //2.生成AVPlayerItem对象
    _playerItem=[[AVPlayerItem alloc] initWithURL:url];
    //3.注册监听
    [self addObserverForPlayer];
    return _playerItem;
}
//kvo的方式注册监听
-(void) addObserverForPlayer{
    //监听播放的状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监听当前视频缓冲的进度
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //添加通知中心以监听当播放结束的时候 调用的方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    AVPlayerItem *item=(AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if(item.status==AVPlayerStatusReadyToPlay){
            //初始化slider值
        CMTime time=item.duration;
        CGFloat seconds=time.value/time.timescale;
            self.proSlider.maximumValue=seconds;
        }else if(item.status==AVPlayerStatusFailed){
            NSLog(@"播放视频失败");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        //处理当前缓存的进度
        NSArray *timeArr=change[@"new"];
        //获取当前缓存的进度
        CMTimeRange range=[timeArr.firstObject CMTimeRangeValue];
        float start=CMTimeGetSeconds(range.start);
        float end=CMTimeGetSeconds(range.duration);
        NSLog(@"%f %f",start,end);
        //计算缓存的比例
        float totalBuffer=start+end;
        float value=totalBuffer/CMTimeGetSeconds(item.duration);
        self.progressView.progress=value;
        
    }
}
-(void) playFinished:(NSNotification *) notification{
    NSLog(@"播放结束");
    _progressView.progress=0;
    _proSlider.value=0;
}
//移除监听
-(void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
-(IBAction)PlayerBtn:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (!_isPlaying) {
        //播放
        BOOL isOpen=false;
        for (CALayer *layer in _playView.layer.sublayers) {
            //判断图层是否是播放器的图层
            if ([layer isKindOfClass:[AVPlayerLayer class]]) {
                isOpen=YES;
            }
        }
        if (!isOpen) {
            //不存在此图层
            [self addSubLayer];
        }
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.player play];
    }else{
        //暂停
        [btn setTitle:@"播放" forState:UIControlStateNormal];
        [self.player pause];
    }
    _isPlaying=!_isPlaying;
}
//添加播放视图的图层
-(void) addSubLayer{
    //1.初始化PalyerLayer的对象
    AVPlayerLayer *playerlayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    //1.1设置frame
    playerlayer.frame=_playView.layer.bounds;
    //1.2 内容填充的模式
    playerlayer.videoGravity=AVLayerVideoGravityResize;
    //2.添加到图层上
    [_playView.layer addSublayer:playerlayer];

}
-(IBAction)sliderValue:(UISlider *)sender{
    [self.playerItem seekToTime:CMTimeMake(sender.value, 1) completionHandler:^(BOOL finished){
        NSLog(@"滑动结束");
        //播放
        [self.player play];
        _isPlaying=YES;
    }];
}
@end
