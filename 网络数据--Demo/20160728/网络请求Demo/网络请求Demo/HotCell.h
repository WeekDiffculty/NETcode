//
//  HotCell.h
//  网络请求Demo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotModel;
@interface HotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (weak, nonatomic) IBOutlet UIImageView *cover;

@property (nonatomic, strong) HotModel *model;
@end
