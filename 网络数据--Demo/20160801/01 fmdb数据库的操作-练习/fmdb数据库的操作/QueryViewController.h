//
//  QueryViewController.h
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;//存放的是查询的结果
    IBOutlet UITableView *tableView;//表格视图对象
}
@end
