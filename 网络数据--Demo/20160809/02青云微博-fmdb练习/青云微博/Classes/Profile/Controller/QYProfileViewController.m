//
//  QYProfileViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYProfileViewController.h"

@interface QYProfileViewController ()

@end

@implementation QYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    [self.view setBackgroundColor:QLColorRandom];
}

@end
