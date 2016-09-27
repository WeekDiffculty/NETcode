//
//  QueryViewController.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QueryViewController.h"
#import "StudentInfoDb.h"
#import "CustomCell.h"
@interface QueryViewController ()

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataList=[[StudentInfoDb shareInstance] Query];
    tableView.delegate=self;
    tableView.dataSource=self;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"customCell";
    CustomCell *cell=(CustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    StudentModal *student=dataList[indexPath.row];
    [cell updateCell:student];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentModal *student=dataList[indexPath.row];
    NSLog(@"%ld %@ %@ %@ %@",student.Id,student.Name,student.Age,student.Phone,student.FamilyAddress);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
