//
//  ViewController.m
//  01MPMoviePlayerController
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
-(IBAction)playBtn:(id)sender{
    //1.NSURL对象
    NSURL *url=[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
#if 0
   
    //2.初始化对象
    _mpController=[[MPMoviePlayerController alloc] initWithContentURL:url];
    //3.设置控制面板
    _mpController.controlStyle= MPMovieControlStyleEmbedded;
    //4.设置frame
    _mpController.view.frame=CGRectMake(0, 150, self.view.frame.size.width, 300);
    [self.view addSubview:_mpController.view];
    //5.播放
    [_mpController play];
#endif
    MPMoviePlayerViewController *playerController=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:playerController animated:YES completion:^{
        NSLog(@"视频播放完成");
    }];
}

@end
