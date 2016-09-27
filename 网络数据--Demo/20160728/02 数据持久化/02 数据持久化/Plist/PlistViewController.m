//
//  PlistViewController.m
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PlistViewController.h"
//plilst文件名
#define PlistFile @"Person.plist"

#define Name @"name" //姓名
#define Age @"age"//年龄
#define Sex @"sex"//性别
#define Icon @"icon"//用户头像
#define Info @"info"//用户其他的配置信息 例:信息的完整度

@interface PlistViewController ()

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self  loadDataFromLocation];
}
-(NSString *) filePath{
    if (_filePath) {
        return _filePath;
    }
    //1.获取document路径
    NSString *strDocPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //2.合并文件路径
    _filePath=[strDocPath stringByAppendingPathComponent:PlistFile];
    NSLog(@"文件路径%@",_filePath);
    return _filePath;
}
-(IBAction)saveBtn:(id)sender{
    if ([self saveDataToLocation]) {
        NSLog(@"数据保存成功");
    }
}
//将数据保存到磁盘的plist文件当中
-(BOOL) saveDataToLocation{
    //1.plist文件保存数据本质上是字典数据保存到磁盘当中
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    //2.设置key关键字-value值的方式
    NSString *name=_nameTextFile.text;
    if (name) {
        [pars setValue:name forKey:Name];
    }
    NSInteger age=_ageTextFiled.text.integerValue;
    if (age) {
        [pars setValue:@(age) forKey:Age];
    }
    BOOL bSex=_sexSwitch.on;
    [pars setValue:@(bSex) forKey:Sex];
    
    UIImage *image=[UIImage imageNamed:@"monkey.jpg"];
    //UIimage imageWithContentsOfFile:<#(nonnull NSString *)#>
    NSData *data=UIImageJPEGRepresentation(image,1);
    [pars setObject:data forKey:Icon];
    
    [pars setObject:@(_infoSlider.value) forKey:Info];
    //将字典保存到文件plist中
   return  [pars writeToFile:self.filePath atomically:YES];
}
//读取plist文件
-(void) loadDataFromLocation{
    //1.读取plist文件=>字典
    NSDictionary *pars=[[NSDictionary alloc] initWithContentsOfFile:self.filePath];
    if (pars) {
        //2.读取字典的值 根据key读取
        NSString *name=pars[Name];
        _nameTextFile.text=name;
        _ageTextFiled.text=[pars[Age] stringValue];
        _sexSwitch.on=[pars[Sex] boolValue];
        NSData *data=pars[Icon];
        _iconImgeView.image=[UIImage imageWithData:data];
        _infoSlider.value=[pars[Info] floatValue];
    }
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
