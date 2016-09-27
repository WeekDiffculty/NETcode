//
//  ViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYMainViewController.h"
#import "QYTabBar.h"
#import "QYHomeViewController.h"
#import "QYMessageViewController.h"
#import "QYSearchViewController.h"
#import "QYProfileViewController.h"
#import "QYPlusViewController.h"
#import "QYAddMessageViewController.h"
@interface QYMainViewController ()

@end

@implementation QYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    QYHomeViewController *vcHome = [[QYHomeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addViewController:vcHome imageName:@"tabbar_home" title:@"首页"];
    
    QYMessageViewController *vcMessage = [QYMessageViewController new];
    [self addViewController:vcMessage imageName:@"tabbar_message_center" title:@"消息"];
    
    QYSearchViewController *vcDiscover = [QYSearchViewController new];
    [self addViewController:vcDiscover imageName:@"tabbar_discover" title:@"搜索"];
    
    QYProfileViewController *vcProfile = [QYProfileViewController new];
    [self addViewController:vcProfile imageName:@"tabbar_profile" title:@"我"];
    
    // 创建自己的TabBar
    QYTabBar *tabBar = [QYTabBar new];
    tabBar.delegate=self;
    //self.tabBar = tabBar;
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)addViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title {
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]];
    //viewController.tabBarItem.title = title;
    viewController.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    // 创建一个导航控制器
    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    // 把导航控制器添加到TanBarController中
    [self addChildViewController:vcNav];
}
//转发微博的方法 打开发微博的视图控制器
-(void) tabBarMain{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QYAddMessageViewController *vc=(QYAddMessageViewController *)[sb instantiateViewControllerWithIdentifier:@"AddMsgVC"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
