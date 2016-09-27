//
//  ViewController.m
//  01播放系统声音
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
    [self initSystemSoundId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) initSystemSoundId{
    //获取音频文件的路径
//    CFURLRef urlRef=CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("tap"), CFSTR("caf"), NULL);
    
    CFURLRef urlref = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("tap"), CFSTR("caf"), NULL);
    AudioServicesCreateSystemSoundID(urlref, &_soundID);
    //释放
    CFRelease(urlref);
    AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, soundFinsished, NULL);
}
void soundFinsished(SystemSoundID snd,void *content){
    NSLog(@"音频播放结束");
}
-(IBAction)palySound:(id)sender{
   //播放声音
    AudioServicesPlaySystemSound(_soundID);
}
-(IBAction)playalertSound:(id)sender{
    AudioServicesPlayAlertSound(_soundID);
}
-(IBAction)palyVibrate:(id)sender{
    //播放振动的效果
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
