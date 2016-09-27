//
//  ViewController.m
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "DbHandle.h"
#import "QYStudent.h"
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
-(IBAction)saveBtn:(id)sender{
    //方式1:将文本控件值直接转换实体中属性的值
//    QYStudent *student=[[QYStudent alloc] init];
//    student.name=nameTf.text;
//    student.age=[ageTf.text integerValue];
//    student.phone=phoneTf.text;
//    student.icon=UIImageJPEGRepresentation(headView.image, 1);
//    student.Id=@"1001";
//        [[DbHandle shareInstance] insertIntoStudent:student];
    //方式2:kvc的方式赋值
    //
    NSDictionary *par=@{@"name":nameTf.text,@"age":ageTf.text,@"phone":phoneTf.text,@"icon":UIImageJPEGRepresentation(headView.image, 1),@"Id":@"1003",@"Address":@"郑州市高新区"};
    QYStudent *student=[QYStudent modeWithDic:par];
    [[DbHandle shareInstance] insertIntoStudent:student];
}
-(IBAction)updateBtn:(id)sender{
       NSDictionary *par=@{@"name":nameTf.text,@"age":ageTf.text,@"phone":phoneTf.text,@"icon":UIImageJPEGRepresentation(headView.image, 1),@"Id":@"1003"};
     QYStudent *student=[QYStudent modeWithDic:par];
    [[DbHandle shareInstance] update:student];
}
@end
