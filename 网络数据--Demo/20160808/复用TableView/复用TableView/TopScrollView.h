//
//  TopScrollView.h
//  复用TableView
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack)(NSInteger currentIndex);
@interface TopScrollView : UIScrollView
@property (nonatomic, strong) UIColor *seletedColor;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSArray *buttons;
@property (nonatomic, copy) CallBack callBack;
//初始化需要一个标题数组
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles;
@end
