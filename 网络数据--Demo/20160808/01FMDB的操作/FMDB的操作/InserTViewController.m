//
//  InserTViewController.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "InserTViewController.h"
#import "StudentModal.h"
#import "StudentInfoDb.h"
@interface InserTViewController ()

@end

@implementation InserTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//保存按钮
-(IBAction)saveBtn:(id)sender{
    StudentModal *student=[[StudentModal alloc] init];
    student.Id=[idTf.text integerValue];
    student.Name=nameTf.text;
    student.Age=ageTf.text;
    student.Phone=phoneTf.text;
    student.FamilyAddress=famillyAddrTf.text;
    
    [[StudentInfoDb shareInstance] Insert:student];
    
}
-(IBAction)updateBtn:(id)sender{
    //ui中获取值
    StudentModal *student=[[StudentModal alloc] init];
    student.Id=[idTf.text integerValue];
    student.Name=nameTf.text;
    student.Age=ageTf.text;
    student.Phone=phoneTf.text;
    student.FamilyAddress=famillyAddrTf.text;
    //更新指定id记录的数据
    [[StudentInfoDb shareInstance] Update:student.Id Info:student];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
