//
//  ViewController.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "StudentInfoDb.h"
#import "StudentModal.h"
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
//删除记录
-(IBAction)deleteBtn:(id)sender{
    [[StudentInfoDb shareInstance] Delete:1003];
}
//事务操作
-(IBAction)transactionBtn:(id)sender{
   // NSLog(@"开始插入");
    NSMutableArray *mArr=[NSMutableArray array];
    for (NSUInteger index = 0; index < 10000; index ++) {
        StudentModal *student=[[StudentModal alloc] init];
        student.Id=index+10000;
        student.Name=[NSString stringWithFormat: @"学生%ld",index];
        student.Age=@"19";
        student.Phone=@"110";
        student.FamilyAddress=@"郑州市";
       // [[StudentInfoDb shareInstance] Insert:student];
        [mArr addObject:student];
    }
   // NSLog(@"结束插入");
    [[StudentInfoDb shareInstance] InsertRecords:mArr];
}
@end
