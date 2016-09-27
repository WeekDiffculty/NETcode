//
//  QueryViewController.h
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface QueryViewController : ViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataList;
   
    IBOutlet UITableView *tableView;
}
@end
