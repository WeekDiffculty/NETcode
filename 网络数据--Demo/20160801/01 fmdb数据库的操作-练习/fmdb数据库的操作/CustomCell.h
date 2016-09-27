//
//  CustomCell.h
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYStudent.h"
@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *ageLbl;
    IBOutlet UILabel *phoneLbl;
    IBOutlet UIImageView *headView;
}
-(void) updateCell:(QYStudent *) student;
@end
