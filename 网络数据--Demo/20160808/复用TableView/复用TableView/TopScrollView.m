//
//  TopScrollView.m
//  复用TableView
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TopScrollView.h"
#import "Common.h"

@implementation TopScrollView
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles
{
    
    if (self = [super initWithFrame:frame]) {
        self.seletedColor = [UIColor blackColor];
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.contentSize = CGSizeMake(kTopBtnWidth * titles.count, 0);
        
        self.backgroundColor = [UIColor redColor];
        NSMutableArray *muarr = [NSMutableArray array];
        for (NSUInteger index = 0; index < titles.count; index ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(index * kTopBtnWidth, 0, kTopBtnWidth, frame.size.height-2);
            [self addSubview:button];
            
            [button setTitle:titles[index] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setTitleColor:self.seletedColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [muarr addObject:button];
            button.tag = index + 100;
        }
        self.buttons = muarr;
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)button
{
    self.currentIndex = button.tag - 100;
    if (_callBack) {
        _callBack(self.currentIndex);
    }
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    UIButton *currentBtn = self.buttons[currentIndex];
    currentBtn.selected = YES;
    
    UIButton *lastBtn = self.buttons[_currentIndex];
    lastBtn.selected = NO;
    _currentIndex = currentIndex;
}
@end
