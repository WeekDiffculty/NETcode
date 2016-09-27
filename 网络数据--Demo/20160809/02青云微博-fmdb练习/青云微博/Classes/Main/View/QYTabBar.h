//
//  QYTabBar.h
//  Demo03_微博
//
//  Created by qingyun on 16/6/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol tabBarDelegate
//转发微博
-(void) tabBarMain;
@end
@interface QYTabBar : UITabBar
@property(nonatomic,strong) NSObject<tabBarDelegate> *delegate;
@end
