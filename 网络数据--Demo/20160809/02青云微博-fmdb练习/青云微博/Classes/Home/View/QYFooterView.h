//
//  QYFooterView.h
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYStatusModel;

@interface QYFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) QYStatusModel *status;//每个单元格对应的微博对象
@property(nonatomic,strong) UIViewController *vc;
+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end
