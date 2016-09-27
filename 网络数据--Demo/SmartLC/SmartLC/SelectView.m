//
//  SelectView.m
//  SmartLC
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SelectView.h"
#import "UIView+common.h"
#define kButtonW [UIScreen mainScreen].bounds.size.width/3
@implementation SelectView
- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        NSArray *titles = @[@"信息",@"招聘",@"求职"];
        for (NSUInteger index = 0; index < 3; index ++) {
//          选项按钮初始化
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(index * kButtonW, 0, kButtonW, frame.size.height-2);
            [button setTitle:titles[index] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
//            UIView *underView = [UIView alloc] initWithFrame:CGRectMake(kButtonW, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
            
        
        }
    }
    return self;
}
- (void)selectAction:(UIButton *)button
{
    
}
@end
