//
//  ViewController.m
//  02KVODemo
//
//  Created by qingyun on 16/7/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property(nonatomic,strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.初始化对象Person
    _person=[[Person alloc] init];
    _person.name=@"张三";
    _person.age=20;
    //1.给对象注册一个监听
    [_person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(dispLbl)];
    
}
-(IBAction)changeValueForAgeBtn:(id)sender{
    _person.age+=1;
    countLbl.text=[NSString stringWithFormat:@"单击按钮 改变age:%ld",_person.age];
}
#pragma mark 监听方法
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"\nkeyPath %@ %@ %@",keyPath,object,change);
    //1.获取keypath 进行判断
    if ([keyPath isEqualToString:@"age"]) {
        //2. 取出change 参数中的new值,并进行转成字符串类型
        NSString *ageStr=[change[@"new"] stringValue];
        //3.刷新ui
        //获取ui控件
        UILabel *lbl=(__bridge UILabel *)context;
        lbl.text=[NSString stringWithFormat:@"KVO监听方法收到%@", ageStr];
    }
    
    
}
-(void)dealloc{
    //最后一步 移除监听
    [_person removeObserver:self forKeyPath:@"age"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
