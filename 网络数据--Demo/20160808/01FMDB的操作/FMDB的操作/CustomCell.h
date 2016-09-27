//
//  CustomCell.h
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentModal.h"
@interface CustomCell : UITableViewCell{
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *ageLbl;
    IBOutlet UILabel *phoneLbl;
    IBOutlet UILabel *familyLbl;
}
-(void) updateCell:(StudentModal *) student;
@end
