//
//  QYGuideViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYGuideViewController.h"
#import "AppDelegate.h"

@interface QYGuideViewController () <NSObject>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation QYGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    // 添加ScrollView
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 给SCrollView添加图片控件
    NSArray *arrImageNames = @[@"helper_authority_miaopai_guide", @"helper_authority_notice_guide", @"helper_authority_place_guide", @"helper_authority_weibocamera_guide"];
    NSUInteger count = arrImageNames.count;
    CGFloat width = CGRectGetWidth(scrollView.frame);
    for (NSUInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(index * width, 0, width, CGRectGetHeight(scrollView.frame));
        imageView.image = [UIImage imageNamed:arrImageNames[index]];
        imageView.contentMode = UIViewContentModeCenter;
        [scrollView addSubview:imageView];
        if (index == count - 1) {
            [self loadEnjoyButton:imageView];
        }
    }
    
    // 设置ScrollView的ContentSize
    [scrollView setContentSize:CGSizeMake(count * width, 0)];
}

- (void)loadEnjoyButton:(UIImageView *)imageView {
    UIButton *btnEnjoy = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnEnjoy setTitle:@"Enjoy" forState:UIControlStateNormal];
    [btnEnjoy setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btnEnjoy.titleLabel.font = [UIFont italicSystemFontOfSize:40];
    [self.scrollView addSubview:btnEnjoy];
    CGFloat width = 150;
    CGFloat X = (QLScreenWidth - width) * 0.5 + CGRectGetMinX(imageView.frame);
    CGFloat Y = QLScreenHeight - 100;
    btnEnjoy.frame = CGRectMake(X, Y, width, 50);
    
    [btnEnjoy.layer setCornerRadius:5.0];
    [btnEnjoy.layer setBorderColor:[UIColor orangeColor].CGColor];
    [btnEnjoy.layer setBorderWidth:1.0];
    [btnEnjoy.layer setMasksToBounds:YES];
    
    [btnEnjoy addTarget:self action:@selector(tapEnjoyAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapEnjoyAction {
    // 保存版本号
    // NSUserDefaults:单例, 用法类似NSDictionary 就是能把信息存储到Bundle中的一个plist文件中
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:@"oldVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 强制现在就写入plist
    
    //NSLog(@"%@", NSHomeDirectory());
    
    // 跳转
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate loadMainController];
}

@end
