//
//  NSFileManagerVC.m
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSFileManagerVC.h"
//文件名称
#define KFILE @"text.txt"
//文件夹的名称
#define KDIR @"MyText"
@interface NSFileManagerVC ()
@property(strong,nonatomic) NSString *filePath;
@end

@implementation NSFileManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readDataFromlocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//生成一个文件的路径
-(NSString *) filePath{
    if (_filePath) {
        return _filePath;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:KDIR];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
   // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:KFILE];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}
-(IBAction)SaveBtn:(id)sender{
    if([self saveDataToLocation]){
        NSLog(@"存储数据成功");
    }
    
}
//将数据 textfield文本保存至磁盘中
-(BOOL) saveDataToLocation{
    if (_myTextField.text.length==0) {
        return FALSE;
    }
    return  [_myTextField.text writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
//读取磁盘中指定的文件
-(void) readDataFromlocation{
    //1.从指定路径的文件读取数据 然后转成NSString 对象中内容
    NSString *strContent=[[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    //2.填充UI
    if (strContent) {
        _myTextField.text=strContent;
    }
    
    
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
