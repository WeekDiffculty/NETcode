//
//  ViewController.m
//  响应者链demo
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
#import "ViewB.h"
#import "ViewC.h"
@interface ViewController ()
@property (nonatomic, strong) ViewA *viewA;
@property (nonatomic, strong) ViewB *viewB;
@property (nonatomic, strong) ViewC *viewC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hello");
//    NSArray *views = @[_viewA, _viewB, _viewC];
    UITouch *touch = [touches anyObject];
//    UIView *view = touch.view;
    if (_viewA == touch.view) {
        NSLog(@"is ViewA");
    }else if (_viewB == touch.view){
        NSLog(@"is ViewB");
    }else if(_viewC == touch.view){
        NSLog(@"is ViewC");
    }else{
        NSLog(@"is self.view");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
