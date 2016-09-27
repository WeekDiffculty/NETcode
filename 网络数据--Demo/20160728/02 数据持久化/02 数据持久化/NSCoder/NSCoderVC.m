//
//  NSCoderVC.m
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSCoderVC.h"
#import "QYUserInfoEntity.h"
#define FileName @"userEntityArchive"
@interface NSCoderVC ()

@end

@implementation NSCoderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readDataFromLocation];
}
-(NSString *) filePath{
    if (_filePath) {
        return _filePath;
    }
    //1.获取documentsPath
    NSString *strDocPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //2.合并文件路径
    _filePath=[strDocPath stringByAppendingPathComponent:FileName];
    return _filePath;
}
//序列化写的文件操作
-(BOOL) saveDataTolocation{
    QYUserInfoEntity *userEntity=[[QYUserInfoEntity alloc] init];
    userEntity.userName=_userNameTf.text;
    userEntity.pwd=_pwdTf.text;
    //序列化操作,把实体model 存储到本地磁盘当中,操作时自动调用实体中encodeWithCoder(NSCoding协议)方法
    return [NSKeyedArchiver archiveRootObject:userEntity toFile:self.filePath];
}
//序列化读的文件操作
-(void) readDataFromLocation{
    //1.解档的操作 将存放在磁盘当中的文件读取 NSData =>实体的对象 会用到NSCoding协议中的initWithCoder:方法
    QYUserInfoEntity *userEntity=[NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    if(userEntity)
    {//将实体model中的数据赋值给UI控件
        _userNameTf.text=userEntity.userName;
        _pwdTf.text=userEntity.pwd;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveDataBtn:(id)sender{
    if ([self saveDataTolocation]) {
        NSLog(@"归档序列化成功");
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
