//
//  CustomCell.m
//  fmdb数据库的操作
//
//  Created by qingyun on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CustomCell.h"
#import "QYStudent.h"
@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) updateCell:(QYStudent *) student{
    nameLbl.text=student.name;
    ageLbl.text=[NSString stringWithFormat:@"%ld",student.age];
    phoneLbl.text=student.phone;
    headView.image=[UIImage imageWithData:student.icon];
}

@end
