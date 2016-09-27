//
//  UserDefaultsVC.m
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "UserDefaultsVC.h"

#define Name @"name" //姓名
#define Age @"age"//年龄
#define Sex @"sex"//性别
#define Icon @"icon"//用户头像
#define Info @"info"//用户其他的配置信息 例:信息的完整度

@interface UserDefaultsVC ()

@end

@implementation UserDefaultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readDataFromLocation];
}
//将数据保存至本地
-(BOOL) saveDataToLocation{
    //1.获取NSuserDefaults对象,单例的对象
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    //2.在对象中设置值,key-value 存储
    [userDefaults setObject:_nameTextFile.text forKey:Name];
    [userDefaults setInteger:_ageTextFiled.text.integerValue forKey:Age];
    [userDefaults setBool:_sexSwitch.on forKey:Sex];
    UIImage *imge=[UIImage imageNamed:@"monkey.jpg"];
    NSData *data=UIImageJPEGRepresentation(imge, 1);
    [userDefaults setObject:data forKey:Icon];
    [userDefaults setFloat:_infoSlider.value forKey:Info];
    return [userDefaults synchronize];//将数据保存到磁盘中,
}
-(void) readDataFromLocation{
    //NSUserDefaults 保存或者读取的操作 本质上是plist文件的操作,我们不需要通过文件名来读写
    //1.获取NSUserDefaults单例的对象
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    //读取name
   _nameTextFile.text =[userDefaults stringForKey:Name];
    //读取年龄
    _ageTextFiled.text=[NSString stringWithFormat:@"%ld",[userDefaults integerForKey:Age]];
    //读取性别
    _sexSwitch.on=[userDefaults boolForKey:Sex];
    //读取图像icon NSData
    NSData *data=[userDefaults dataForKey:Icon];
    _iconImgeView.image=[UIImage imageWithData:data];
    _infoSlider.value=[userDefaults floatForKey:Info];
    
}
-(IBAction)savaDataBtn:(id)sender{
    if ([self saveDataToLocation]) {
        NSLog(@"数据保存成功");
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
