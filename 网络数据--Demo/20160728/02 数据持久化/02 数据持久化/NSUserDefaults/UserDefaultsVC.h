//
//  UserDefaultsVC.h
//  02 数据持久化
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDefaultsVC : UIViewController
@property(weak,nonatomic) IBOutlet UITextField *nameTextFile;//姓名
@property(weak,nonatomic) IBOutlet UITextField *ageTextFiled;//年龄
@property(weak,nonatomic) IBOutlet UISwitch *sexSwitch;//性别
@property(weak,nonatomic) IBOutlet UIImageView *iconImgeView;//用户头像
@property(weak,nonatomic) IBOutlet UISlider *infoSlider;//用户其他信息
@end
